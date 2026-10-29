import CryptoKit
import Foundation

/// Re-fetches every evidence URL and checks that every quote appears on the page.
///
/// Matching ignores case and collapses whitespace. A page counts as containing a quote if any of its readings
/// does: the raw text, the text with HTML tags removed (joined with and without spaces, since a number split across
/// two tags reads either way), and for JSON, its string values. Pages are cached in .cache/ so reruns are fast.
func verify(_ catalog: Catalog, token: String?) async -> (failures: [String], unreachable: [String]) {
    let cache = catalog.root.appendingPathComponent(".cache")
    try? FileManager.default.createDirectory(at: cache, withIntermediateDirectories: true)
    let urls = Set(catalog.entries.flatMap { $0.evidence.map(\.url) }).sorted()

    var pages: [String: [String]] = [:]
    var unreachable: [String] = []
    await withTaskGroup(of: (String, Result<[String], Error>).self) { group in
        var pending = urls[...]
        func next() {
            guard let url = pending.popFirst() else { return }
            group.addTask {
                do { return (url, .success(try await readings(of: url, cache: cache, token: token))) }
                catch { return (url, .failure(error)) }
            }
        }
        for _ in 0..<8 { next() }
        for await (url, result) in group {
            switch result {
            case .success(let texts): pages[url] = texts
            case .failure(let error): unreachable.append("\(url): \(error)")
            }
            next()
        }
    }

    var failures: [String] = []
    for entry in catalog.entries {
        for evidence in entry.evidence {
            guard let texts = pages[evidence.url] else { continue }
            let quote = normalize(decodeEntities(evidence.quote))
            if !texts.contains(where: { $0.contains(quote) }) {
                failures.append("\(entry.slug): quote not found at \(evidence.url)\n    \"\(evidence.quote.prefix(160))\"")
            }
        }
    }
    return (failures, unreachable.sorted())
}

/// The normalized readings of a page, from the cache or the network.
private func readings(of url: String, cache: URL, token: String?) async throws -> [String] {
    let key = SHA256.hash(data: Data(url.utf8)).map { String(format: "%02x", $0) }.joined()
    let file = cache.appendingPathComponent(key)
    let body: String
    if let cached = try? String(contentsOf: file, encoding: .utf8) {
        body = cached
    } else {
        body = try await fetch(url, token: token)
        try? body.write(to: file, atomically: true, encoding: .utf8)
    }

    var texts = [body]
    if body.range(of: "<html", options: .caseInsensitive) != nil || body.contains("</div>") {
        let withoutCode = body
            .replacing(/(?is)<script.*?<\/script>/, with: " ")
            .replacing(/(?is)<style.*?<\/style>/, with: " ")
        texts.append(decodeEntities(withoutCode.replacing(/<[^>]*>/, with: "")))
        texts.append(decodeEntities(withoutCode.replacing(/<[^>]*>/, with: " ")))
    }
    if let data = body.data(using: .utf8), let json = try? JSONSerialization.jsonObject(with: data) {
        texts.append(strings(in: json).joined(separator: "\n"))
    }
    return texts.map(normalize)
}

/// GitHub pages are read from their raw source, which is where the text a quote was copied from lives.
private func fetch(_ address: String, token: String?) async throws -> String {
    var address = address
    var headers: [String: String] = ["User-Agent": "fastswift-catalog"]
    let parts = address.split(separator: "/", omittingEmptySubsequences: false).map(String.init)
    if address.hasPrefix("https://github.com/"), parts.count > 6, parts[5] == "blob" {
        // https://github.com/owner/repo/blob/ref/path → https://raw.githubusercontent.com/owner/repo/ref/path
        address = "https://raw.githubusercontent.com/\(parts[3])/\(parts[4])/" + parts[6...].joined(separator: "/")
        address = address.components(separatedBy: "#")[0]
    } else if address.hasPrefix("https://github.com/"), parts.count <= 5 || parts[5].isEmpty || parts[5].hasPrefix("#") {
        let repo = parts[4].components(separatedBy: "#")[0]
        address = "https://api.github.com/repos/\(parts[3])/\(repo)/readme"
        headers["Accept"] = "application/vnd.github.raw"
    }
    if address.hasPrefix("https://api.github.com/"), let token {
        headers["Authorization"] = "Bearer \(token)"
    }

    guard let url = URL(string: address) else { throw CatalogError("bad URL") }
    var request = URLRequest(url: url, timeoutInterval: 180)
    for (field, value) in headers { request.setValue(value, forHTTPHeaderField: field) }
    let (data, response) = try await URLSession.shared.data(for: request)
    if let http = response as? HTTPURLResponse, !(200..<300).contains(http.statusCode) {
        throw CatalogError("HTTP \(http.statusCode)")
    }
    return String(decoding: data, as: UTF8.self)
}

private func strings(in json: Any) -> [String] {
    switch json {
    case let text as String: [text]
    case let array as [Any]: array.flatMap(strings)
    case let object as [String: Any]: object.keys.sorted().flatMap { strings(in: object[$0]!) }
    default: []
    }
}

/// Lowercased, typographic quotes and dashes folded to ASCII, whitespace collapsed to single spaces.
func normalize(_ text: String) -> String {
    var folded = text.lowercased()
    for (from, to) in [("\u{2019}", "'"), ("\u{2018}", "'"), ("\u{201C}", "\""), ("\u{201D}", "\""),
                       ("\u{00A0}", " "), ("\u{2013}", "-"), ("\u{2014}", "-"), ("\u{2212}", "-")] {
        folded = folded.replacingOccurrences(of: from, with: to)
    }
    return folded.split(whereSeparator: \.isWhitespace).joined(separator: " ")
}

func decodeEntities(_ text: String) -> String {
    guard text.contains("&") else { return text }
    var result = text
    for (entity, character) in [("&quot;", "\""), ("&#39;", "'"), ("&#x27;", "'"), ("&apos;", "'"), ("&lt;", "<"),
                                ("&gt;", ">"), ("&nbsp;", " "), ("&#x2F;", "/"), ("&#47;", "/")] {
        result = result.replacingOccurrences(of: entity, with: character)
    }
    result = result.replacing(/&#(\d+);/) { match in
        Int(match.1).flatMap(UnicodeScalar.init).map { String(Character($0)) } ?? String(match.0)
    }
    result = result.replacing(/&#x([0-9a-fA-F]+);/) { match in
        Int(match.1, radix: 16).flatMap(UnicodeScalar.init).map { String(Character($0)) } ?? String(match.0)
    }
    return result.replacingOccurrences(of: "&amp;", with: "&")
}
