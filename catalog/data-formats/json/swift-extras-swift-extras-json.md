# swift-extras-json (ExtrasJSON, formerly pure-swift-json)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md) › [JSON](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Open source · `Swift` · `Apache-2.0` · 🔴 abandoned

> Foundation-free JSON coder that beat Swift 5.1/5.2 Foundation by 1.5-10x; its parsing approach later went into Foundation itself.

| | |
|---|---|
| **Beats** | Foundation JSONEncoder / JSONDecoder in Swift 5.1 and 5.2 (macOS: pre-2023 NSJSONSerialization-backed; Linux: swift-corelibs-foundation before Swift 5.5) |
| **Claimed result** | Encoding: ~2x on macOS (1.23s vs 2.61s, Swift 5.1), ~10x on Linux (1.05s vs 12.52s, Swift 5.2). Decoding: ~1.5x on macOS (1.70s vs 2.72s, Swift 5.1), ~7x-~8x on Linux (1.16s vs 10.65s, Swift 5.2). |
| **Workload** | Encoding and decoding a sample Codable structure (PerfTests SampleStructure) in a loop; total seconds |
| **Metric** | time |
| **Hardware** | 2019 MacBook Pro 16-inch, 2.4 GHz 8-core Intel Core i9 |
| **OS** | macOS and Linux (versions not stated) |
| **Toolchain** | Swift 5.1 and 5.2, swift run -c release |
| **Measured** | 2020 |
| **Adoption** | 348 stars |
| **Last commit** | 2020-11-14 |
| **Platforms** | macOS, Linux (no Foundation dependency) |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/swift-extras/swift-extras-json) · [benchmark](https://github.com/swift-extras/swift-extras-json/blob/main/README.md) |

## Verdict

The ~2x macOS and 7-10x Linux gains were measured in 2020 against Foundation versions that no longer ship. The author upstreamed the same value-type parsing approach into swift-corelibs-foundation in 2021, Apple platforms moved to the Swift rewrite in 2023, and nobody has compared the two since.

**Why tier A:** The PerfTests package is in the repo, run with swift run -c release, and the README states the 2019 Intel Core i9 MacBook Pro and Swift 5.1/5.2.

## Use it when

- Foundation-free targets on old toolchains (Linux before Swift 5.5)

## Skip it when

- Swift 5.5+ on Linux or any current Apple OS: Foundation now parses into value types too
- You need Date or Data strategies, snake_case key conversion, or UTF-16/UTF-32 input: none are supported

## How it is fast

It parses into a Swift enum value tree instead of NSDictionary, NSArray and NSNumber reference types, avoiding Objective-C bridging and per-node reference counting, and it never touches Foundation. Encoding writes bytes directly into a [UInt8] buffer.

## What it costs

- No Date/Data strategies or key conversion
- No UTF-16/UTF-32 input

## Problems with the evidence

- Numbers are from 2020, Swift 5.1/5.2, on an Intel Mac.
- Both baselines have since been replaced: swift-corelibs-foundation merged the author's JSONValue-based parser and coders (PRs #2966, #2985, #2987, March 2021), and macOS 14 / iOS 17 ship the Swift rewrite of JSONDecoder.
- A reviewer's measurement on corelibs PR #2966 showed that change alone cut a JSONSerialization parse loop from 1.71 s to 0.67 s on Linux.
- No commits since November 2020.

## Evidence

<details>
<summary>10 quotes from the sources, checked 2026-10-28</summary>

> All tests have been run on a 2019 MacBook Pro (16" – 2,4 GHz 8-Core Intel Core i9).
>
> — [github.com/swift-extras/swift-extras-json/blob/main/README.md](https://github.com/swift-extras/swift-extras-json/blob/main/README.md)

> |  | macOS Swift 5.1 | macOS Swift 5.2 | Linux Swift 5.1 | Linux Swift 5.2 |
>
> — [github.com/swift-extras/swift-extras-json/blob/main/README.md](https://github.com/swift-extras/swift-extras-json/blob/main/README.md)

> | Foundation   | 2.61s | 2.62s | 13.03s | 12.52s |
>
> — [github.com/swift-extras/swift-extras-json/blob/main/README.md](https://github.com/swift-extras/swift-extras-json/blob/main/README.md)

> | ExtrasJSON | 1.23s | 1.25s | 1.13s | 1.05s |
>
> — [github.com/swift-extras/swift-extras-json/blob/main/README.md](https://github.com/swift-extras/swift-extras-json/blob/main/README.md)

> | Speedup | ~2x | ~2x | **~10x** | **~10x** |
>
> — [github.com/swift-extras/swift-extras-json/blob/main/README.md](https://github.com/swift-extras/swift-extras-json/blob/main/README.md)

> | Foundation   | 2.72s | 3.04s | 10.27s | 10.65s |
>
> — [github.com/swift-extras/swift-extras-json/blob/main/README.md](https://github.com/swift-extras/swift-extras-json/blob/main/README.md)

> | ExtrasJSON | 1.70s | 1.72s | 1.39s | 1.16s |
>
> — [github.com/swift-extras/swift-extras-json/blob/main/README.md](https://github.com/swift-extras/swift-extras-json/blob/main/README.md)

> | Speedup | ~1.5x | ~1.5x | **~7x** | **~8x** |
>
> — [github.com/swift-extras/swift-extras-json/blob/main/README.md](https://github.com/swift-extras/swift-extras-json/blob/main/README.md)

> It should significantly improve overall JSON performance, since we save on a lot of roundtrips through NSArray and NSDictionary.
>
> — [github.com/swiftlang/swift-corelibs-foundation/pull/2985](https://github.com/swiftlang/swift-corelibs-foundation/pull/2985)

> this is the last step to make JSON Encoding and Decoding much more performant on Linux.
>
> — [github.com/swiftlang/swift-corelibs-foundation/pull/2987](https://github.com/swiftlang/swift-corelibs-foundation/pull/2987)

</details>
