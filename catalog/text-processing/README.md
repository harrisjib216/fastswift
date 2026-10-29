# Text processing

<sub>[fastswift](../../README.md) › [Catalog](../README.md)</sub>

## [Regular expressions](regex/README.md)

**The default:** Swift Regex.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**NSRegularExpression (vs Swift Regex)**](regex/apple-foundation-nsregularexpression.md) | Foundation's ICU regex is ~19x cheaper to construct than Swift Regex and avoids some backtracking cliffs; matching is near parity once cached. | B | 🟡 Holds up in part |

## [Parsing and strings](parsing-and-strings/README.md)

**The default:** String APIs and Scanner.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**swift-parsing (UTF8View parsers vs Scanner)**](parsing-and-strings/pointfreeco-swift-parsing.md) | Composable parser library; its UTF-8 parsers beat Foundation Scanner 3x-9x, but Substring parsers do not beat hand-written split code. | A | 🟡 Holds up in part |

## [Dates and numbers](dates-and-numbers/README.md)

**The default:** DateFormatter, ISO8601DateFormatter and NumberFormatter.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Date.FormatStyle (Swift Foundation, macOS 14 / iOS 17)**](dates-and-numbers/apple-foundation-date-formatstyle.md) | Apple reports a 150% speedup for Date.FormatStyle template formatting after Foundation's Swift rewrite in macOS 14 and iOS 17. | C | ✅ Holds up |
| [**Parse3339**](dates-and-numbers/juri-parse3339.md) | Single-file RFC 3339 timestamp parser; parses in 16 ns with zero allocations, far ahead of Foundation formatters created per call. | A | 🟡 Holds up in part |
| [**swift-parsing (RFC 3339 date parser benchmark)**](dates-and-numbers/pointfreeco-swift-parsing-date-parser.md) | Example RFC 3339 parser built with swift-parsing that ran 6.7x faster than a cached DateFormatter in a 2023 benchmark. | A | 🟡 Holds up in part |
| [**Date.ISO8601FormatStyle (Swift Foundation, ICU-free)**](dates-and-numbers/apple-foundation-iso8601formatstyle.md) | Swift Foundation rebuilt ISO 8601 formatting on its own Gregorian calendar, cutting ICU out and formatting about 4.3x faster. | C | 🟡 Holds up in part |
