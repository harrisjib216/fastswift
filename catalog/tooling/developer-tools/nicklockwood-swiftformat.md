# SwiftFormat

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md) › [Developer tools](README.md)</sub>

**Tier B** (independent measurement) · 🟡 Holds up in part · Open source · `Swift` · `MIT` · 🟢 active

> Swift code formatter with its own tokenizer; timed 8x faster than swift-format on one small file in 2019, unmeasured since.

| | |
|---|---|
| **Beats** | swift-format (swiftlang/swift-format) |
| **Claimed result** | 0.03 s vs 0.24 s real time to format one example file (about 8x, derived from page data) |
| **Workload** | Formatting a single short Swift example file with default settings, timed with time(1) |
| **Metric** | time |
| **Hardware** | 2017 MacBook Pro, 2.9 GHz Intel Core i7, 16 GB RAM |
| **Toolchain** | SwiftFormat 0.38-era; swift-format 0.0.1 (2019-05-15) on Swift 4.2 SwiftSyntax |
| **Measured** | 2019-05 |
| **Adoption** | 8.9k stars |
| **Last commit** | 2026-10-27 |
| **Platforms** | macOS, Linux |
| **Install** | Homebrew, Mint, CocoaPods, Swift Package Manager plugin |
| **Links** | [repository](https://github.com/nicklockwood/SwiftFormat) · [benchmark](https://nshipster.com/swift-format/) |

## Verdict

The only published head-to-head is NSHipster's 2019 timing of one small file: SwiftFormat 0.03 s, swift-format 0.24 s. That swift-format build used Swift 4.2's slowest way to get a syntax tree and has since moved to the Swift-native parser, and no current large-codebase comparison exists.

**Why tier B:** Independent third-party timing with hardware stated, but a single small file and 2019-era versions.

## Use it when

- Format-on-save or pre-commit hooks where per-file latency matters
- Teams already standardized on SwiftFormat's rule set

## Skip it when

- Choosing on speed alone today: the measured gap is from 2019 and swift-format's parser has since been rewritten
- Projects that want the formatter shipped with the Swift toolchain (swift-format is included in Swift 6 toolchains)

## How it is fast

SwiftFormat uses its own lightweight tokenizer and applies rules to the token stream, rather than building a full syntax tree. In 2019 swift-format had to run swiftc and parse a large JSON file to get its tree, which dominated the timing.

## What it costs

- Its own parser can lag new Swift syntax compared with SwiftSyntax-based tools
- Different default style and rule set from swift-format

## Problems with the evidence

- One small file; process startup likely dominates both timings
- 2019 versions on an Intel MacBook Pro; swift-format then used Swift 4.2's slow SwiftSyntax path
- No modern benchmark of either tool on a large codebase was found

## Evidence

<details>
<summary>5 quotes from the sources, checked 2026-10-28</summary>

> Timings are measured in seconds and taken on a 2017 MacBook Pro with 2.9 GHz Intel Core i7 processor and 16 GB 2133 MHz LPDDR3 memory.
>
> — [nshipster.com/swift-format/](https://nshipster.com/swift-format/)

> SwiftFormat is consistently the fastest of the tools tested in this article, completing in a few milliseconds. $ time swiftformat Example.swift 0.03 real 0.01 user 0.01 sys
>
> — [nshipster.com/swift-format/](https://nshipster.com/swift-format/)

> $ time swift-format Example.swift 0.24 real 0.16 user 0.14 sys
>
> — [nshipster.com/swift-format/](https://nshipster.com/swift-format/)

> Our initial benchmarks reflected the Swift 4.2 version of SwiftSyntax, which predates these optimizations.
>
> — [nshipster.com/swift-format/](https://nshipster.com/swift-format/)

> the NSHipster article compared swift-format using swift-4.2 which only provides the slowest available way to get a SwiftSyntax tree (invoke the swiftc binary and parse a large JSON file)
>
> — [forums.swift.org/t/se-0250-swift-code-style-guidelines-and-formatte…](https://forums.swift.org/t/se-0250-swift-code-style-guidelines-and-formatter/21795/157)

</details>
