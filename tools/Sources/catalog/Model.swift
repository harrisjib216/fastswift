import Foundation

/// One catalog entry: a library, framework or tool, the default it claims to beat, and how far the claim holds.
/// The fields are documented in docs/schema.md.
struct Entry: Codable, Sendable {
    var id: String
    var name: String
    var domain: String
    var category: String
    var baseline: String
    var verdict: Verdict
    var verdictReason: String
    var evidenceTier: Tier
    var tierReason: String
    var claimedSpeedup: String
    var workload: String
    var metric: String
    var hardware: String
    var os: String
    var toolchain: String
    var benchmarkDate: String
    var benchmarkUrl: String
    var repoUrl: String?
    var docsUrl: String?
    var license: String?
    var usability: Usability
    var language: String
    var platforms: String
    var install: String
    var maintenanceStatus: String
    var stars: Int?
    var lastCommit: String
    var oneLiner: String
    var howItIsFast: String
    var useItWhen: [String]
    var skipItWhen: [String]
    var caveats: [String]
    var tradeoffs: [String]
    var evidence: [Evidence]
    var checked: String

    struct Evidence: Codable, Sendable, Hashable {
        var url: String
        var quote: String
    }

    enum Verdict: String, Codable, Sendable, CaseIterable {
        case confirm, downgrade, reject
    }

    enum Tier: String, Codable, Sendable, CaseIterable, Comparable {
        case A, B, C, D
        static func < (a: Tier, b: Tier) -> Bool { a.rawValue < b.rawValue }
    }

    enum Usability: String, Codable, Sendable {
        case copyable, reference, platform, mixed
    }

    /// The file name and page name: `apple-swift-collections-deque`, `apple-synchronization-mutex`.
    var slug: String {
        var text = id.lowercased()
        for prefix in ["https://", "http://", "github.com/", "www."] where text.hasPrefix(prefix) {
            text.removeFirst(prefix.count)
        }
        if text.hasPrefix("github.com/") { text.removeFirst("github.com/".count) }
        let pieces = text.split(whereSeparator: { !$0.isLetter && !$0.isNumber })
        return pieces.joined(separator: "-")
    }
}

struct Domain: Codable, Sendable {
    var slug: String
    var title: String
    var categories: [Category]

    struct Category: Codable, Sendable {
        var slug: String
        var title: String
        var `default`: String
    }
}

/// The records in data/ and the taxonomy that orders them.
struct Catalog {
    var root: URL
    var domains: [Domain]
    var entries: [Entry]

    static func load(from root: URL) throws -> Catalog {
        let data = root.appendingPathComponent("data")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let domains = try decoder.decode([Domain].self, from: Data(contentsOf: data.appendingPathComponent("taxonomy.json")))
        let folder = data.appendingPathComponent("entries")
        let files = try FileManager.default.contentsOfDirectory(atPath: folder.path).filter { $0.hasSuffix(".json") }.sorted()
        var entries: [Entry] = []
        for file in files {
            do {
                entries.append(try decoder.decode(Entry.self, from: Data(contentsOf: folder.appendingPathComponent(file))))
            } catch {
                throw CatalogError("data/entries/\(file): \(error)")
            }
        }
        return Catalog(root: root, domains: domains, entries: entries)
    }

    func entries(in domain: Domain, _ category: Domain.Category) -> [Entry] {
        entries.filter { $0.domain == domain.slug && $0.category == category.slug }.sorted(by: Catalog.order)
    }

    /// Confirmed before downgraded before rejected; better evidence first; then by name.
    static func order(_ a: Entry, _ b: Entry) -> Bool {
        let rank: [Entry.Verdict: Int] = [.confirm: 0, .downgrade: 1, .reject: 2]
        if a.verdict != b.verdict { return rank[a.verdict]! < rank[b.verdict]! }
        if a.evidenceTier != b.evidenceTier { return a.evidenceTier < b.evidenceTier }
        return a.name.lowercased() < b.name.lowercased()
    }
}

struct CatalogError: Error, CustomStringConvertible {
    var description: String
    init(_ description: String) { self.description = description }
}
