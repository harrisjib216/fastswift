# Date.FormatStyle (Swift Foundation, macOS 14 / iOS 17)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Text processing](../README.md) › [Dates and numbers](README.md)</sub>

**Tier C** (first-party numbers) · ✅ Holds up · Ships with Apple's SDKs · `Swift` · `Apple SDK` · 🟢 active

> Apple reports a 150% speedup for Date.FormatStyle template formatting after Foundation's Swift rewrite in macOS 14 and iOS 17.

| | |
|---|---|
| **Beats** | Date.FormatStyle on macOS 13 / iOS 16 (Objective-C Foundation) |
| **Claimed result** | 'a massive 150% improvement in a benchmark of formatting with a standard date and time template'. Unmerged follow-up, ICU vs Swift pattern filling: date-format-style 1,007 ns vs 573 ns (1.76x). |
| **Workload** | Format a Date with a standard date and time template. |
| **Metric** | throughput |
| **OS** | macOS 14 / iOS 17 vs macOS 13 / iOS 16 |
| **Measured** | 2023-06 |
| **Platforms** | iOS 17+, macOS 14+ |
| **Install** | built into iOS 17+ and macOS 14+ |
| **Links** | [documentation](https://developer.apple.com/documentation/foundation/date/formatstyle) · [benchmark](https://developer.apple.com/videos/play/wwdc2023/10164/) |

## Verdict

Apple reports a 150% improvement in one date-and-time template formatting benchmark after moving FormatStyle to Swift Foundation. No contradicting data was found; a 2026 open PR measuring a further Swift pattern formatter against ICU (1.3x-3.3x) suggests ICU is still on the path and more gains remain.

**Why tier C:** First-party WWDC statement about a single benchmark with no workload detail or hardware.

## Use it when

- Formatting dates for display on iOS 17+ and macOS 14+, instead of building DateFormatter instances

## Skip it when

- Deployment targets below iOS 17 / macOS 14, where the old implementation runs

## How it is fast

The Swift rewrite of Foundation removed Objective-C bridging and intermediate allocations from FormatStyle. ICU still fills in the date pattern; an open swift-foundation PR moves that step into Swift as well.

## What it costs

- None to adopt beyond the OS requirement.

## Problems with the evidence

- '150% improvement' is ambiguous (2.5x throughput or 1.5x) and covers one benchmark.
- No hardware, method or code published with the WWDC claim.
- The 1.76x Swift pattern formatter figure is from an open PR (October 2026) behind a build flag, not shipping code.

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> Date formatting using FormatStyle also gained some major performance upgrades, showing a massive 150% improvement in a benchmark of formatting with a standard date and time template.
>
> — [developer.apple.com/videos/play/wwdc2023/10164/](https://developer.apple.com/videos/play/wwdc2023/10164/)

> | date-format-style | 1,007 | 573 | 1.76 |
>
> — [api.github.com/repos/swiftlang/swift-foundation/pulls/2330](https://api.github.com/repos/swiftlang/swift-foundation/pulls/2330)

> | date-format-verbatim-long | 1,479 | 446 | 3.32 |
>
> — [api.github.com/repos/swiftlang/swift-foundation/pulls/2330](https://api.github.com/repos/swiftlang/swift-foundation/pulls/2330)

> | date-format-fresh-style | 1,433 | 1,093 | 1.31 |
>
> — [api.github.com/repos/swiftlang/swift-foundation/pulls/2330](https://api.github.com/repos/swiftlang/swift-foundation/pulls/2330)

</details>
