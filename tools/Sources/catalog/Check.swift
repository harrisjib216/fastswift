import Foundation

/// Offline checks: every field present and well formed, every entry in a known category, no duplicate ids or slugs.
func check(_ catalog: Catalog) -> [String] {
    var problems: [String] = []
    let categories = Set(catalog.domains.flatMap { domain in domain.categories.map { "\(domain.slug)/\($0.slug)" } })
    let date = /^\d{4}(-\d{2}(-\d{2})?)?$/
    let statuses: Set = ["active", "stale", "abandoned", "finished", "unknown"]
    var ids: [String: Int] = [:]
    var slugs: [String: Int] = [:]

    for entry in catalog.entries {
        func problem(_ text: String) { problems.append("\(entry.slug): \(text)") }
        ids[entry.id, default: 0] += 1
        slugs[entry.slug, default: 0] += 1

        if !categories.contains("\(entry.domain)/\(entry.category)") {
            problem("unknown category \(entry.domain)/\(entry.category)")
        }
        let required: [(String, String)] = [
            ("name", entry.name), ("baseline", entry.baseline), ("verdict_reason", entry.verdictReason),
            ("tier_reason", entry.tierReason), ("claimed_speedup", entry.claimedSpeedup), ("workload", entry.workload),
            ("metric", entry.metric), ("benchmark_url", entry.benchmarkUrl), ("one_liner", entry.oneLiner),
            ("how_it_is_fast", entry.howItIsFast), ("language", entry.language), ("checked", entry.checked),
        ]
        for (field, value) in required where value.trimmingCharacters(in: .whitespaces).isEmpty {
            problem("\(field) is empty")
        }
        if entry.oneLiner.count > 200 { problem("one_liner is \(entry.oneLiner.count) characters; keep it under 200") }
        if entry.evidence.isEmpty { problem("no evidence") }
        for evidence in entry.evidence where !evidence.url.hasPrefix("https://") {
            problem("evidence URL is not https: \(evidence.url)")
        }
        if !entry.benchmarkDate.isEmpty, entry.benchmarkDate.wholeMatch(of: date) == nil {
            problem("benchmark_date '\(entry.benchmarkDate)' is not YYYY, YYYY-MM or YYYY-MM-DD")
        }
        if !entry.lastCommit.isEmpty, entry.lastCommit.wholeMatch(of: date) == nil {
            problem("last_commit '\(entry.lastCommit)' is not a date")
        }
        let status = entry.maintenanceStatus.split(separator: " ").first.map(String.init) ?? ""
        if !statuses.contains(status) { problem("maintenance_status '\(entry.maintenanceStatus)' is not one of \(statuses.sorted())") }
        if entry.usability == .platform, entry.docsUrl == nil { problem("an Apple framework needs docs_url") }
        if entry.useItWhen.isEmpty, entry.verdict != .reject { problem("use_it_when is empty") }
    }
    for (id, count) in ids where count > 1 { problems.append("id \(id) is used \(count) times") }
    for (slug, count) in slugs where count > 1 { problems.append("slug \(slug) is used \(count) times") }
    return problems.sorted()
}
