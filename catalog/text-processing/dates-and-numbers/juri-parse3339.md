# Parse3339

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Text processing](../README.md) › [Dates and numbers](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Open source · `Swift` · `MIT` · 🟢 active

> Single-file RFC 3339 timestamp parser; parses in 16 ns with zero allocations, far ahead of Foundation formatters created per call.

| | |
|---|---|
| **Beats** | Foundation DateFormatter and ISO8601DateFormatter |
| **Claimed result** | Median wall clock per iteration: DateFormatter 93503 ns and ISO8601DateFormatter 119679 ns vs Parse3339 to Date via Unix time 2291 ns (40.8x and 52.2x, derived from page data) or via DateComponents 708 ns; parse-only String entry point 16 ns. Mallocs per iteration: 1063 (DateFormatter) vs 0 (Parse3339, Unix time). |
| **Workload** | Parse '2023-07-04T08:21:25+03:00' to a Date; Foundation rows include creating and configuring the formatter each iteration. Parse-only rows cycle through 8,192 varied timestamps. |
| **Metric** | time, allocations |
| **Hardware** | MacBook Pro M5 |
| **OS** | macOS 27.0.1 |
| **Toolchain** | swift package benchmark (release); swift-tools-version 6.3 |
| **Measured** | 2026-10 |
| **Adoption** | 46 stars |
| **Last commit** | 2026-10-25 |
| **Platforms** | macOS 15+, iOS 16+ |
| **Install** | Swift Package Manager (or copy the single source file) |
| **Links** | [repository](https://github.com/juri/Parse3339) · [benchmark](https://github.com/juri/Parse3339#speed-and-memory-usage) |

## Verdict

Parse3339 is clearly faster and allocation-free, but its Foundation rows construct and configure a new formatter inside every timed iteration, so the 41x-52x gap mixes formatter creation with parsing. Code that caches its formatter will see a smaller gap.

**Why tier A:** Public package-benchmark suite in the repository with hardware and OS stated (MacBook Pro M5, macOS 27.0.1); package-benchmark builds in release mode.

## Use it when

- Decoding many RFC 3339 timestamps, for example as a JSONDecoder custom date strategy
- Code that currently builds a DateFormatter per call or per object

## Skip it when

- Inputs outside its four supported RFC 3339 shapes (no week dates, no basic format, no localized dates)
- Apps targeting below iOS 16 or macOS 15

## How it is fast

It walks the bytes of the string once with no regex, locale or ICU involvement and no heap allocation, producing plain integer fields. Conversion to Date goes through timegm or DateComponents only when asked.

## What it costs

- Supports a restricted subset of RFC 3339.
- Requires a recent toolchain (Swift tools 6.3).

## Problems with the evidence

- Foundation formatter construction happens inside the timed closure, so the 41x-52x ratios overstate the gain against a cached formatter.
- Date.ISO8601FormatStyle is not benchmarked.
- The 16 ns parse-only figure excludes building a Date; the full path to Date is 708-2,291 ns.
- Single machine, single run.

## Evidence

<details>
<summary>13 quotes from the sources, checked 2026-10-28</summary>

> Parse3339 is a fast [RFC 3339] time stamp parser written in pure Swift.
>
> — [github.com/juri/Parse3339/blob/main/README.md](https://github.com/juri/Parse3339/blob/main/README.md)

> Output from one run (macOS 27.0.1, MacBook Pro M5):
>
> — [github.com/juri/Parse3339/blob/main/README.md](https://github.com/juri/Parse3339/blob/main/README.md)

> There are also benchmarks that parse the same string using Foundation's `DateFormatter`, Foundation's `ISO8601DateFormatter`, Parse3339 creating a `Date` with Foundation's `DateComponents` and `Calendar`, and Parse3339 creating a `Date` with standard Unix functions.
>
> — [github.com/juri/Parse3339/blob/main/README.md](https://github.com/juri/Parse3339/blob/main/README.md)

> | Time (wall clock) (ns) * | 86750 | 92927 | 93503 | 94079 |
>
> — [github.com/juri/Parse3339/blob/main/README.md](https://github.com/juri/Parse3339/blob/main/README.md)

> | Time (wall clock) (ns) * | 110958 | 118847 | 119679 | 120575 |
>
> — [github.com/juri/Parse3339/blob/main/README.md](https://github.com/juri/Parse3339/blob/main/README.md)

> | Time (wall clock) (ns) * | 542 | 667 | 708 | 708 |
>
> — [github.com/juri/Parse3339/blob/main/README.md](https://github.com/juri/Parse3339/blob/main/README.md)

> | Time (wall clock) (ns) * | 2041 | 2251 | 2291 | 2333 |
>
> — [github.com/juri/Parse3339/blob/main/README.md](https://github.com/juri/Parse3339/blob/main/README.md)

> | Time (wall clock) (ns) * | 15 | 16 | 16 | 16 |
>
> — [github.com/juri/Parse3339/blob/main/README.md](https://github.com/juri/Parse3339/blob/main/README.md)

> | Malloc (total) * | 1063 | 1063 | 1063 | 1063 |
>
> — [github.com/juri/Parse3339/blob/main/README.md](https://github.com/juri/Parse3339/blob/main/README.md)

> These benchmarks use 8,192 timestamps with varying dates, fractional precision, and time zones.
>
> — [github.com/juri/Parse3339/blob/main/README.md](https://github.com/juri/Parse3339/blob/main/README.md)

> let dateFormatter = DateFormatter()
>
> — [github.com/juri/Parse3339/blob/main/Benchmarks/ParserBenchmarks/Par…](https://github.com/juri/Parse3339/blob/main/Benchmarks/ParserBenchmarks/ParserBenchmarks.swift)

> let s = "2023-07-04T08:21:25+03:00"
>
> — [github.com/juri/Parse3339/blob/main/Benchmarks/ParserBenchmarks/Par…](https://github.com/juri/Parse3339/blob/main/Benchmarks/ParserBenchmarks/ParserBenchmarks.swift)

> swift-tools-version: 6.3
>
> — [github.com/juri/Parse3339/blob/main/Package.swift](https://github.com/juri/Parse3339/blob/main/Package.swift)

</details>
