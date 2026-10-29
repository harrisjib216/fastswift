# xcbeautify

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md) › [Developer tools](README.md)</sub>

**Tier D** (directional only) · 🟡 Holds up in part · Open source · `Swift` · `MIT` · 🟢 active

> Swift replacement for xcpretty that formats xcodebuild output; claimed 2x faster, but never published a benchmark.

| | |
|---|---|
| **Beats** | xcpretty (Ruby xcodebuild output formatter) |
| **Claimed result** | 2x faster than xcpretty (former README claim, no benchmark) |
| **Workload** | Formatting xcodebuild output piped through the formatter |
| **Metric** | time |
| **Adoption** | 1.6k stars |
| **Last commit** | 2026-08-10 |
| **Platforms** | macOS, Linux |
| **Install** | Homebrew, Mint, or build from source |
| **Links** | [repository](https://github.com/cpisciotta/xcbeautify) · [benchmark](https://github.com/cpisciotta/xcbeautify/blob/04b028e398efe8298c703283f9a58184926b0cf7/README.md) |

## Verdict

The README claimed '2x faster than xcpretty' until March 2024 without any published benchmark, then dropped the number. What remains, from the project and from fastlane's docs, is the unquantified statement that it is faster.

**Why tier D:** The only number was an unsupported first-party claim that has since been removed; current statements are directional.

## Use it when

- CI pipelines that pipe xcodebuild through a formatter and want to drop the Ruby dependency
- Parallel testing or SwiftPM output, which xcbeautify supports

## Skip it when

- Expecting a measurable build speedup: the formatter runs alongside xcodebuild and is rarely the bottleneck
- Workflows that depend on xcpretty's HTML report output

## How it is fast

It compiles to a native static binary instead of running in a Ruby interpreter, so there is no gem loading and the line matching runs as native code. It also parses the new build system's and parallel testing output, which xcpretty handles poorly.

## What it costs

- Output format and report options differ from xcpretty

## Problems with the evidence

- No benchmark was ever published for the 2x figure, and it was removed from the README in March 2024
- fastlane recommends xcbeautify and calls it faster, but gives no numbers

## Evidence

<details>
<summary>3 quotes from the sources, checked 2026-10-28</summary>

> - [x] 2x faster than `xcpretty`.
>
> — [github.com/cpisciotta/xcbeautify/blob/04b028e398efe8298c703283f9a58…](https://github.com/cpisciotta/xcbeautify/blob/04b028e398efe8298c703283f9a58184926b0cf7/README.md)

> A faster alternative to `xcpretty` written in Swift.
>
> — [github.com/cpisciotta/xcbeautify](https://github.com/cpisciotta/xcbeautify)

> It's faster than xcpretty
>
> — [docs.fastlane.tools/best-practices/xcodebuild-formatters/](https://docs.fastlane.tools/best-practices/xcodebuild-formatters/)

</details>
