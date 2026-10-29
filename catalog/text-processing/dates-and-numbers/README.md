# Dates and numbers

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Text processing](../README.md)</sub>

**The default:** DateFormatter, ISO8601DateFormatter and NumberFormatter.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Date.FormatStyle (Swift Foundation, macOS 14 / iOS 17)**](apple-foundation-date-formatstyle.md) | Apple reports a 150% speedup for Date.FormatStyle template formatting after Foundation's Swift rewrite in macOS 14 and iOS 17. | C | ✅ Holds up |
| [**Parse3339**](juri-parse3339.md) | Single-file RFC 3339 timestamp parser; parses in 16 ns with zero allocations, far ahead of Foundation formatters created per call. | A | 🟡 Holds up in part |
| [**swift-parsing (RFC 3339 date parser benchmark)**](pointfreeco-swift-parsing-date-parser.md) | Example RFC 3339 parser built with swift-parsing that ran 6.7x faster than a cached DateFormatter in a 2023 benchmark. | A | 🟡 Holds up in part |
| [**Date.ISO8601FormatStyle (Swift Foundation, ICU-free)**](apple-foundation-iso8601formatstyle.md) | Swift Foundation rebuilt ISO 8601 formatting on its own Gregorian calendar, cutting ICU out and formatting about 4.3x faster. | C | 🟡 Holds up in part |
