# Developer tools

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md)</sub>

**The default:** xcpretty and the usual formatters and linters.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**SwiftLint (SwiftSyntax-based rules)**](realm-swiftlint.md) | The standard Swift linter; rewriting rules on SwiftSyntax made them 7-10x faster and whole runs 6-30% faster per release. | C | ✅ Holds up |
| [**xcodes (aria2 downloads)**](xcodesorg-xcodes.md) | Command-line Xcode installer that downloads over up to 16 connections with aria2, claimed 3-5x faster than URLSession. | C | ✅ Holds up |
| [**SwiftFormat**](nicklockwood-swiftformat.md) | Swift code formatter with its own tokenizer; timed 8x faster than swift-format on one small file in 2019, unmeasured since. | B | 🟡 Holds up in part |
| [**unxip**](saagarjha-unxip.md) | Swift tool that extracts Xcode .xip files about 2-3x faster than xip(1) and Archive Utility, per its author. | C | 🟡 Holds up in part |
| [**xcbeautify**](cpisciotta-xcbeautify.md) | Swift replacement for xcpretty that formats xcodebuild output; claimed 2x faster, but never published a benchmark. | D | 🟡 Holds up in part |
