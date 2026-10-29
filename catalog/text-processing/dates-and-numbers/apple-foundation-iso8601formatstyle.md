# Date.ISO8601FormatStyle (Swift Foundation, ICU-free)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Text processing](../README.md) › [Dates and numbers](README.md)</sub>

**Tier C** (first-party numbers) · 🟡 Holds up in part · Ships with Apple's SDKs · `Swift` · `Apple SDK` · 🟢 active

> Swift Foundation rebuilt ISO 8601 formatting on its own Gregorian calendar, cutting ICU out and formatting about 4.3x faster.

| | |
|---|---|
| **Beats** | Date.ISO8601FormatStyle formatting on the earlier ICU-backed implementation |
| **Claimed result** | 'about 5x' faster. Table median: throughput 108K to 467K formats per second (4.3x, derived from page data); total CPU 9216 ns to 2099 ns per format (4.4x, derived from page data). The internal OutputBuffer alone was worth a 25% improvement. |
| **Workload** | Format a Date with ISO8601FormatStyle (swift-foundation 'iso8601' benchmark). |
| **Metric** | throughput |
| **Measured** | 2024-01-30 |
| **Platforms** | Apple platforms with Swift Foundation releases after January 2024; Linux and Windows with Swift 6 toolchains |
| **Install** | built into Foundation |
| **Links** | [documentation](https://developer.apple.com/documentation/foundation/date/iso8601formatstyle) · [benchmark](https://github.com/swiftlang/swift-foundation/pull/392) |

## Verdict

The rewrite is a large real gain, but the PR's own table shows 4.3x at the median, a little under its 'about 5x' headline. It covers formatting a Date to a string only, not parsing.

**Why tier C:** First-party PR numbers from the repository's benchmark target, with no hardware, OS or toolchain stated.

## Use it when

- Producing ISO 8601 timestamps in logs, JSON or network payloads on current OS releases and on Linux
- Replacing ISO8601DateFormatter for output

## Skip it when

- Supporting OS versions that ship the older ICU-backed Foundation, where the gain does not apply

## How it is fast

Formatting now uses Swift Foundation's own Gregorian calendar code instead of calling into ICU, which also lets it live in FoundationEssentials. An internal output buffer avoids retains, releases and exclusivity checks while writing the string.

## What it costs

- None to adopt; FormatStyle API differs from ISO8601DateFormatter options.

## Problems with the evidence

- No hardware or toolchain stated; benchmark sources are in the swift-foundation repository.
- Formatting only; parsing performance was not measured in this PR.
- The PR does not say which Apple OS release first shipped the change.

## Evidence

<details>
<summary>6 quotes from the sources, checked 2026-10-28</summary>

> Bottom line: The new implementation is about *5x* faster than the old one, in terms of throughput.
>
> — [api.github.com/repos/swiftlang/swift-foundation/pulls/392](https://api.github.com/repos/swiftlang/swift-foundation/pulls/392)

> │ Throughput (# / s) (K)    │     112 │     109 │     108 │
>
> — [api.github.com/repos/swiftlang/swift-foundation/pulls/392](https://api.github.com/repos/swiftlang/swift-foundation/pulls/392)

> │ Throughput (# / s) (K)    │     491 │     476 │     467 │
>
> — [api.github.com/repos/swiftlang/swift-foundation/pulls/392](https://api.github.com/repos/swiftlang/swift-foundation/pulls/392)

> │ Time (total CPU) (ns) *   │    8915 │    9126 │    9216 │
>
> — [api.github.com/repos/swiftlang/swift-foundation/pulls/392](https://api.github.com/repos/swiftlang/swift-foundation/pulls/392)

> │ Time (total CPU) (ns) *   │    2035 │    2084 │    2099 │
>
> — [api.github.com/repos/swiftlang/swift-foundation/pulls/392](https://api.github.com/repos/swiftlang/swift-foundation/pulls/392)

> Using this was worth a 25% improvement by avoiding retains, releases, and exclusivity checking in the formatting part of the code.
>
> — [api.github.com/repos/swiftlang/swift-foundation/pulls/392](https://api.github.com/repos/swiftlang/swift-foundation/pulls/392)

</details>
