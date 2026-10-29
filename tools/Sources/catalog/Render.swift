import Foundation

/// Writes catalog/ from scratch, plus the generated sections of the README.
func render(_ catalog: Catalog) throws {
    let output = catalog.root.appendingPathComponent("catalog")
    try? FileManager.default.removeItem(at: output)

    var files: [String: String] = ["README.md": catalogIndex(catalog)]
    for domain in catalog.domains {
        let categories = domain.categories.filter { !catalog.entries(in: domain, $0).isEmpty }
        guard !categories.isEmpty else { continue }
        files["\(domain.slug)/README.md"] = domainPage(domain, categories, catalog)
        for category in categories {
            let entries = catalog.entries(in: domain, category)
            files["\(domain.slug)/\(category.slug)/README.md"] = categoryPage(domain, category, entries)
            for entry in entries {
                files["\(domain.slug)/\(category.slug)/\(entry.slug).md"] = entryPage(entry, domain, category)
            }
        }
    }
    files["catalog.jsonl"] = try jsonLines(catalog)
    files["catalog.csv"] = csv(catalog)

    for (path, text) in files {
        let url = output.appendingPathComponent(path)
        try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
        try text.write(to: url, atomically: true, encoding: .utf8)
    }
    try updateReadme(catalog)
}

// MARK: - Pages

private func entryPage(_ entry: Entry, _ domain: Domain, _ category: Domain.Category) -> String {
    var lines = [
        "# \(entry.name)",
        "",
        "<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [\(domain.title)](../README.md) › [\(category.title)](README.md)</sub>",
        "",
        [
            "**Tier \(entry.evidenceTier.rawValue)** (\(entry.evidenceTier.label))",
            entry.verdict.label,
            entry.usability.label,
            "`\(entry.language)`",
            entry.license.map { "`\($0)`" },
            status(entry),
        ].compactMap { $0 }.joined(separator: " · "),
        "",
        "> \(entry.oneLiner)",
        "",
        "| | |",
        "|---|---|",
    ]
    let rows: [(String, String)] = [
        ("Beats", entry.baseline),
        ("Claimed result", entry.claimedSpeedup),
        ("Workload", entry.workload),
        ("Metric", entry.metric),
        ("Hardware", entry.hardware),
        ("OS", entry.os),
        ("Toolchain", entry.toolchain),
        ("Measured", entry.benchmarkDate),
        ("Adoption", entry.stars.map(starCount) ?? ""),
        ("Last commit", entry.lastCommit),
        ("Platforms", entry.platforms),
        ("Install", entry.install),
        ("Links", links(entry)),
    ]
    for (title, value) in rows where !value.isEmpty {
        lines.append("| **\(title)** | \(cell(value)) |")
    }

    lines += ["", "## Verdict", "", entry.verdictReason, "", "**Why tier \(entry.evidenceTier.rawValue):** \(entry.tierReason)"]
    lines += section("Use it when", entry.useItWhen)
    lines += section("Skip it when", entry.skipItWhen)
    lines += ["", "## How it is fast", "", entry.howItIsFast]
    lines += section("What it costs", entry.tradeoffs)
    lines += section("Problems with the evidence", entry.caveats)

    let count = entry.evidence.count
    lines += ["", "## Evidence", "", "<details>",
              "<summary>\(count) \(count == 1 ? "quote" : "quotes") from the sources, checked \(entry.checked)</summary>",
              ""]
    for evidence in entry.evidence {
        let quote = evidence.quote.count > 400 ? evidence.quote.prefix(400) + "…" : Substring(evidence.quote)
        lines.append("> " + quote.split(whereSeparator: \.isNewline).joined(separator: " "))
        lines.append(">")
        lines.append("> — [\(shortURL(evidence.url))](\(evidence.url))")
        lines.append("")
    }
    lines.append("</details>")
    return lines.joined(separator: "\n") + "\n"
}

private func categoryPage(_ domain: Domain, _ category: Domain.Category, _ entries: [Entry]) -> String {
    var lines = [
        "# \(category.title)",
        "",
        "<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [\(domain.title)](../README.md)</sub>",
        "",
        "**The default:** \(category.default).",
        "",
    ]
    lines += entryTable(entries, linkPrefix: "")
    return lines.joined(separator: "\n") + "\n"
}

private func domainPage(_ domain: Domain, _ categories: [Domain.Category], _ catalog: Catalog) -> String {
    var lines = ["# \(domain.title)", "", "<sub>[fastswift](../../README.md) › [Catalog](../README.md)</sub>"]
    for category in categories {
        lines += ["", "## [\(category.title)](\(category.slug)/README.md)", "",
                  "**The default:** \(category.default).", ""]
        lines += entryTable(catalog.entries(in: domain, category), linkPrefix: "\(category.slug)/")
    }
    return lines.joined(separator: "\n") + "\n"
}

private func catalogIndex(_ catalog: Catalog) -> String {
    var lines = ["# Catalog", "", "<sub>[fastswift](../README.md)</sub>", "",
                 "Every entry, grouped by domain and category. Within a category, entries that hold up come first, "
                 + "then partial ones, then rejected claims, each ordered by the strength of their evidence.", ""]
    for domain in catalog.domains {
        let categories = domain.categories.filter { !catalog.entries(in: domain, $0).isEmpty }
        guard !categories.isEmpty else { continue }
        lines += ["## [\(domain.title)](\(domain.slug)/README.md)", ""]
        for category in categories {
            let entries = catalog.entries(in: domain, category)
            let names = entries.map { "[\($0.name)](\(domain.slug)/\(category.slug)/\($0.slug).md)" }
            lines.append("- **[\(category.title)](\(domain.slug)/\(category.slug)/README.md)**: " + names.joined(separator: ", "))
        }
        lines.append("")
    }
    return lines.joined(separator: "\n")
}

private func entryTable(_ entries: [Entry], linkPrefix: String) -> [String] {
    var lines = ["| Entry | What it is | Tier | Verdict |", "|---|---|:-:|---|"]
    for entry in entries {
        lines.append("| [**\(cell(entry.name))**](\(linkPrefix)\(entry.slug).md) | \(cell(entry.oneLiner)) | \(entry.evidenceTier.rawValue) | \(entry.verdict.label) |")
    }
    return lines
}

// MARK: - README sections

private func updateReadme(_ catalog: Catalog) throws {
    let url = catalog.root.appendingPathComponent("README.md")
    var readme = try String(contentsOf: url, encoding: .utf8)
    let entries = catalog.entries
    let tiers = Dictionary(grouping: entries, by: \.evidenceTier).mapValues(\.count)
    let verdicts = Dictionary(grouping: entries, by: \.verdict).mapValues(\.count)
    let usedDomains = catalog.domains.filter { domain in domain.categories.contains { !catalog.entries(in: domain, $0).isEmpty } }
    let usedCategories = usedDomains.flatMap { domain in domain.categories.filter { !catalog.entries(in: domain, $0).isEmpty } }

    func badge(_ label: String, _ value: Int, _ color: String) -> String {
        let text = value.formatted()
        let encoded = text.replacingOccurrences(of: ",", with: "%2C")
        return "  <img alt=\"\(label.replacingOccurrences(of: "_", with: " ")): \(text)\" src=\"https://img.shields.io/badge/\(label)-\(encoded)-\(color)\">"
    }
    let badges = [
        "<p align=\"center\">",
        badge("entries", entries.count, "2ea44f"),
        badge("tier_A", tiers[.A] ?? 0, "1f6feb"),
        badge("categories", usedCategories.count, "8250df"),
        badge("claims_rejected", verdicts[.reject] ?? 0, "cf222e"),
        "  <img alt=\"license: MIT\" src=\"https://img.shields.io/badge/license-MIT-blue\">",
        "</p>",
    ]
    readme = replaceSection("badges", in: readme, with: badges.joined(separator: "\n"))

    let stats = "**\(entries.count) entries** across **\(usedCategories.count) categories** in **\(usedDomains.count) domains** · "
        + Entry.Tier.allCases.map { "\(tiers[$0] ?? 0) tier \($0.rawValue)" }.joined(separator: " · ")
        + " · \(verdicts[.confirm] ?? 0) hold up · \(verdicts[.downgrade] ?? 0) hold up in part · \(verdicts[.reject] ?? 0) rejected"
    readme = replaceSection("stats", in: readme, with: stats)

    var index = ["| Domain | Entries | Categories |", "|---|--:|---|"]
    for domain in usedDomains {
        let categories = domain.categories.compactMap { category -> String? in
            let count = catalog.entries(in: domain, category).count
            return count == 0 ? nil : "[\(category.title)](catalog/\(domain.slug)/\(category.slug)/README.md) \(count)"
        }
        let count = entries.filter { $0.domain == domain.slug }.count
        index.append("| [**\(domain.title)**](catalog/\(domain.slug)/README.md) | \(count) | \(categories.joined(separator: " · ")) |")
    }
    readme = replaceSection("index", in: readme, with: index.joined(separator: "\n"))

    // The strongest entry in each domain that holds up as claimed.
    var featured = ["| Need faster… | Pick | What it is | Tier |", "|---|---|---|:-:|"]
    for domain in usedDomains {
        let candidates = entries.filter { $0.domain == domain.slug && $0.verdict == .confirm }
        guard let best = candidates.min(by: { ($0.evidenceTier, -($0.stars ?? 0)) < ($1.evidenceTier, -($1.stars ?? 0)) }),
              let category = domain.categories.first(where: { $0.slug == best.category }) else { continue }
        let path = "catalog/\(domain.slug)/\(category.slug)"
        featured.append("| [\(category.title)](\(path)/README.md) | [**\(cell(best.name))**](\(path)/\(best.slug).md) | \(cell(best.oneLiner)) | **\(best.evidenceTier.rawValue)** |")
    }
    readme = replaceSection("featured", in: readme, with: featured.joined(separator: "\n"))

    var rejected = ["| Claim | Why it doesn't hold up |", "|---|---|"]
    for entry in entries.filter({ $0.verdict == .reject }).sorted(by: { $0.name.lowercased() < $1.name.lowercased() }) {
        rejected.append("| [**\(cell(entry.name))**](catalog/\(entry.domain)/\(entry.category)/\(entry.slug).md) | \(cell(entry.verdictReason)) |")
    }
    readme = replaceSection("rejected", in: readme, with: rejected.joined(separator: "\n"))

    try readme.write(to: url, atomically: true, encoding: .utf8)
}

/// Replaces the text between `<!-- fastswift:name -->` and `<!-- /fastswift:name -->`.
private func replaceSection(_ name: String, in text: String, with content: String) -> String {
    let open = "<!-- fastswift:\(name) -->"
    let close = "<!-- /fastswift:\(name) -->"
    guard let start = text.range(of: open), let end = text.range(of: close, range: start.upperBound..<text.endIndex) else {
        return text
    }
    return text.replacingCharacters(in: start.upperBound..<end.lowerBound, with: "\n\(content)\n")
}

// MARK: - Exports

private func jsonLines(_ catalog: Catalog) throws -> String {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    var lines: [String] = []
    for entry in catalog.entries.sorted(by: { $0.id < $1.id }) {
        var object = try JSONSerialization.jsonObject(with: encoder.encode(entry)) as! [String: Any]
        object["page"] = "catalog/\(entry.domain)/\(entry.category)/\(entry.slug).md"
        let data = try JSONSerialization.data(withJSONObject: object, options: [.sortedKeys, .withoutEscapingSlashes])
        lines.append(String(decoding: data, as: UTF8.self))
    }
    return lines.joined(separator: "\n") + "\n"
}

private func csv(_ catalog: Catalog) -> String {
    let header = ["id", "name", "domain", "category", "evidence_tier", "verdict", "usability", "license", "language",
                  "status", "stars", "last_commit", "repo_url", "benchmark_url", "baseline", "one_liner", "page"]
    var rows = [header.joined(separator: ",")]
    for entry in catalog.entries.sorted(by: { $0.id < $1.id }) {
        let fields = [
            entry.id, entry.name, entry.domain, entry.category, entry.evidenceTier.rawValue, entry.verdict.rawValue,
            entry.usability.rawValue, entry.license ?? "", entry.language,
            String(entry.maintenanceStatus.split(separator: " ").first ?? ""), entry.stars.map(String.init) ?? "",
            entry.lastCommit, entry.repoUrl ?? "", entry.benchmarkUrl, entry.baseline, entry.oneLiner,
            "catalog/\(entry.domain)/\(entry.category)/\(entry.slug).md",
        ]
        rows.append(fields.map { field in
            field.contains(where: { $0 == "," || $0 == "\"" || $0.isNewline })
                ? "\"" + field.replacingOccurrences(of: "\"", with: "\"\"") + "\"" : field
        }.joined(separator: ","))
    }
    return rows.joined(separator: "\n") + "\n"
}

// MARK: - Formatting

extension Entry.Tier {
    var label: String {
        switch self {
        case .A: "reproducible public benchmark"
        case .B: "independent measurement"
        case .C: "first-party numbers"
        case .D: "directional only"
        }
    }
}

extension Entry.Verdict {
    var label: String {
        switch self {
        case .confirm: "✅ Holds up"
        case .downgrade: "🟡 Holds up in part"
        case .reject: "❌ Doesn't hold up"
        }
    }
}

extension Entry.Usability {
    var label: String {
        switch self {
        case .copyable: "Open source"
        case .reference: "No open-source license"
        case .platform: "Ships with Apple's SDKs"
        case .mixed: "Mixed licensing"
        }
    }
}

private func status(_ entry: Entry) -> String {
    let word = String(entry.maintenanceStatus.split(separator: " ").first ?? "unknown")
    let mark = ["active": "🟢", "stale": "🟡", "abandoned": "🔴"][word] ?? "⚪"
    return "\(mark) \(word)"
}

private func links(_ entry: Entry) -> String {
    var links: [String] = []
    if let repo = entry.repoUrl, !repo.isEmpty { links.append("[repository](\(repo))") }
    if let docs = entry.docsUrl, !docs.isEmpty { links.append("[documentation](\(docs))") }
    if !entry.benchmarkUrl.isEmpty { links.append("[benchmark](\(entry.benchmarkUrl))") }
    return links.joined(separator: " · ")
}

private func section(_ title: String, _ items: [String]) -> [String] {
    guard !items.isEmpty else { return [] }
    return ["", "## \(title)", ""] + items.map { "- \($0)" }
}

private func starCount(_ stars: Int) -> String {
    stars >= 1000 ? String(format: "%.1fk stars", Double(stars) / 1000) : "\(stars) stars"
}

private func shortURL(_ url: String) -> String {
    var text = url.replacingOccurrences(of: "https://", with: "").replacingOccurrences(of: "www.", with: "")
    if text.count > 70 { text = String(text.prefix(67)) + "…" }
    return text
}

/// Table cells can't hold pipes or line breaks.
private func cell(_ text: String) -> String {
    text.replacingOccurrences(of: "|", with: "\\|").split(whereSeparator: \.isNewline).joined(separator: " ")
}
