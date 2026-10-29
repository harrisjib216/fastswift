# ZippyJSON

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md) › [JSON](README.md)</sub>

**Tier C** (first-party numbers) · 🟡 Holds up in part · Open source · `Swift + C++` · `MIT` · 🟡 stale

> Drop-in JSONDecoder built on simdjson; 3-4x faster than the pre-iOS 17 decoder, and slower than iOS 17+'s by its own README.

| | |
|---|---|
| **Beats** | Foundation JSONDecoder before iOS 17 / macOS 14 (Swift wrapper over NSJSONSerialization) |
| **Claimed result** | 3x+ faster decode for all 3 test files on Mac and iPhone; README rule of thumb: divide JSONDecoder's time by 4 (pre-iOS 17 only) |
| **Workload** | Decoding three JSON files into Codable models (files not named in the text); release build |
| **Metric** | time |
| **Hardware** | MacBook Pro and iPhone (models not stated) |
| **Adoption** | 956 stars |
| **Last commit** | 2025-09-07 |
| **Platforms** | iOS 11+, macOS 10.13+, tvOS 12+ (CocoaPods); Swift Package Manager on iOS only |
| **Install** | CocoaPods; Swift Package Manager (iOS only) |
| **Links** | [repository](https://github.com/michaeleisel/ZippyJSON) · [benchmark](https://github.com/michaeleisel/ZippyJSON/blob/master/README.md) |

## Verdict

The 3x+ decode win was measured against the old JSONDecoder that went through NSJSONSerialization. The README now says JSONDecoder is faster than ZippyJSON on iOS 17+, so the gain only applies to apps still running on iOS 16 and earlier.

**Why tier C:** First-party README: the text gives only '3x+' and 'divide by 4', the per-file figures are in a chart image, and no device model, OS or Swift version is stated.

## Use it when

- The app still supports iOS 16 or earlier and JSON decoding shows up in profiles on those devices
- Large payloads decoded on older OS versions where the pre-2023 decoder runs

## Skip it when

- Deployment target is iOS 17+ / macOS 14+: the README says the system JSONDecoder is faster
- You need a faster encoder: ZippyJSON only replaces JSONDecoder
- You are measuring a debug build: the README warns to build for release

## How it is fast

It tokenizes with simdjson, a SIMD-vectorized C++ parser, and decodes Codable values straight from the parsed result. The old Foundation decoder first built an NSDictionary/NSArray tree through NSJSONSerialization and then walked it; ZippyJSON skips that tree. ISO-8601 dates go through JJLISO8601DateFormatter instead of Foundation's formatter.

## What it costs

- Adds a C++ dependency (simdjson) and its binary size
- Decoder only; no JSONEncoder replacement
- Swift Package Manager support is iOS-only per the README

## Problems with the evidence

- Per-file numbers exist only in a chart image (misc/chart.svg); the text gives only '3x+' and 'divide by 4'.
- The chart predates iOS 17; README history shows it from the 2019-2020 releases. No OS or Swift version is given.
- A chart-only benchmark in the ReerJSON README (iPhone 15 Pro, iOS 26.0, by a competing library's author) shows ZippyJSON at roughly 1.0x-2.1x Foundation's decode throughput, which conflicts with ZippyJSON's own iOS 17+ note. Neither source gives text numbers for iOS 17+.

## Evidence

<details>
<summary>3 quotes from the sources, checked 2026-10-28</summary>

> JSONDecoder is faster than ZippyJSON for iOS 17+. The rest of this document describes the performance difference pre-iOS 17.
>
> — [github.com/michaeleisel/ZippyJSON/blob/master/README.md](https://github.com/michaeleisel/ZippyJSON/blob/master/README.md)

> These benchmarks were done on a Macbook Pro. The results are very similar on the iPhone (ZippyJSON is 3x+ faster for all 3 files on both platforms).
>
> — [github.com/michaeleisel/ZippyJSON/blob/master/README.md](https://github.com/michaeleisel/ZippyJSON/blob/master/README.md)

> divide its current time taken by 4 to approximate the time taken with ZippyJSON
>
> — [github.com/michaeleisel/ZippyJSON/blob/master/README.md](https://github.com/michaeleisel/ZippyJSON/blob/master/README.md)

</details>
