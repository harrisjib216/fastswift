# swift-parsing (RFC 3339 date parser benchmark)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Text processing](../README.md) › [Dates and numbers](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Open source · `Swift` · `MIT` · 🟢 active

> Example RFC 3339 parser built with swift-parsing that ran 6.7x faster than a cached DateFormatter in a 2023 benchmark.

| | |
|---|---|
| **Beats** | Foundation DateFormatter and ISO8601DateFormatter (cached instances, pre-2023 Foundation) |
| **Claimed result** | Date.Parser 3500 ns vs DateFormatter 23542 ns (6.7x, derived from page data) and ISO8601DateFormatter 29041 ns (8.3x, derived from page data), M1 Pro. |
| **Workload** | Parse one RFC 3339 timestamp '1979-05-27T00:32:00Z' into a Date, formatters created once outside the timed block. |
| **Metric** | time |
| **Hardware** | MacBook Pro (16-inch, 2021), Apple M1 Pro |
| **Toolchain** | swift run -c release (Makefile); Swift version not stated |
| **Measured** | 2023-07 |
| **Adoption** | 1.0k stars |
| **Last commit** | 2026-09-02 |
| **Platforms** | iOS 13+, macOS 10.15+, tvOS 13+, watchOS 6+, Linux |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/pointfreeco/swift-parsing) · [benchmark](https://github.com/pointfreeco/swift-parsing#benchmarks) |

## Verdict

The benchmark parser beats cached DateFormatter by 6.7x and ISO8601DateFormatter by 8.3x, but the formatter rows date from March 2023, before the Swift Foundation rewrite shipped. The parser row was re-run separately in July 2023, and the comparison leaves out Date.ISO8601FormatStyle, today's default.

**Why tier A:** Public benchmark source and release-mode command in the repository, hardware stated in the README; OS and Swift version not stated.

## Use it when

- Bulk parsing of strict RFC 3339 timestamps where formatter cost shows up in profiles
- Needing sub-millisecond precision, which the benchmark notes the formatters do not parse

## Skip it when

- Localized or user-facing date strings
- Before comparing against Date.ISO8601FormatStyle on your target OS

## How it is fast

The parser reads digits straight from UTF-8 bytes, validates ranges, and builds the Date with timegm, skipping locale, calendar and pattern handling that DateFormatter performs through ICU.

## What it costs

- Handles one strict format only; no locale or calendar support.
- timegm-based conversion assumes the Gregorian calendar.

## Problems with the evidence

- Formatter rows were last updated in March 2023 and the parser row in July 2023: not one run.
- Predates the Swift Foundation rewrite in macOS 14 / iOS 17 and later releases; OS not stated.
- Date.ISO8601FormatStyle is not benchmarked.
- The parser lives in the benchmark target, not in the library's public API; you copy the example.

## Evidence

<details>
<summary>7 quotes from the sources, checked 2026-10-28</summary>

> Date.Parser                                      3500.000 ns ±   5.65 %     238924
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> Date.DateFormatter                              23542.000 ns ±   5.50 %      58766
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> Date.ISO8601DateFormatter                       29041.000 ns ±   3.31 %      48028
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> Apple M1 Pro (10 cores, 8 performance and 2 efficiency)
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> Not only is the parser faster than both formatters, it is more flexible and accurate: it will
>
> — [github.com/pointfreeco/swift-parsing/blob/main/Sources/swift-parsin…](https://github.com/pointfreeco/swift-parsing/blob/main/Sources/swift-parsing-benchmark/Date.swift)

> let input = "1979-05-27T00:32:00Z"
>
> — [github.com/pointfreeco/swift-parsing/blob/main/Sources/swift-parsin…](https://github.com/pointfreeco/swift-parsing/blob/main/Sources/swift-parsing-benchmark/Date.swift)

> swift run -c release swift-parsing-benchmark
>
> — [github.com/pointfreeco/swift-parsing/blob/main/Makefile](https://github.com/pointfreeco/swift-parsing/blob/main/Makefile)

</details>
