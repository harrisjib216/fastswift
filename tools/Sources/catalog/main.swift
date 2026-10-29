import Foundation

let usage = """
    usage: swift run --package-path tools catalog <command>

      check    validate every record in data/entries against the schema
      verify   fetch every evidence URL and check every quote is on the page
      render   write catalog/, the README's generated sections, and the JSONL and CSV exports
    """

/// The repository root: the folder above tools/.
let root = URL(fileURLWithPath: #filePath)
    .deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data((message + "\n").utf8))
    exit(1)
}

let catalog: Catalog
do {
    catalog = try Catalog.load(from: root)
} catch {
    fail("catalog: \(error)")
}

switch CommandLine.arguments.dropFirst().first {
case "check":
    let problems = check(catalog)
    problems.forEach { print($0) }
    print("\(catalog.entries.count) entries, \(problems.count) problems")
    exit(problems.isEmpty ? 0 : 1)

case "verify":
    let token = ProcessInfo.processInfo.environment["GITHUB_TOKEN"]
    let (failures, unreachable) = await verify(catalog, token: token)
    for line in unreachable { print("unreachable: \(line)") }
    for line in failures { print(line) }
    let quotes = catalog.entries.reduce(0) { $0 + $1.evidence.count }
    print("\(quotes) quotes, \(failures.count) not found, \(unreachable.count) pages unreachable")
    exit(failures.isEmpty && unreachable.isEmpty ? 0 : 1)

case "render":
    do {
        let problems = check(catalog)
        guard problems.isEmpty else { fail(problems.joined(separator: "\n") + "\nfix these before rendering") }
        try render(catalog)
        print("rendered \(catalog.entries.count) entries")
    } catch {
        fail("catalog: \(error)")
    }

default:
    fail(usage)
}
