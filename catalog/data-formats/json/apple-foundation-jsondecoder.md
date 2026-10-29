# Foundation JSONDecoder / JSONEncoder (swift-foundation rewrite)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md) › [JSON](README.md)</sub>

**Tier C** (first-party numbers) · ✅ Holds up · Ships with Apple's SDKs · `Swift` · `Apple SDK` · 🟢 active

> Apple's 2023 Swift rewrite of JSONDecoder/JSONEncoder; 2x-5x faster decoding than the NSJSONSerialization-based version it replaced.

| | |
|---|---|
| **Beats** | Foundation JSONDecoder before macOS 14 / iOS 17 (Swift wrapper over NSJSONSerialization) |
| **Claimed result** | Decode time improved by 200% to almost 500% on JSON benchmark test data |
| **Workload** | Decoding the JSON files from the Boost.JSON benchmark suite into Codable types |
| **Metric** | time |
| **Measured** | 2023-04-26 |
| **Platforms** | macOS 14+, iOS 17+ and the matching 2023 OS releases; Linux and Windows through the Swift 6 toolchain's swift-foundation |
| **Install** | built into macOS 14+ / iOS 17+ |
| **Links** | [documentation](https://developer.apple.com/documentation/foundation/jsondecoder) · [benchmark](https://www.swift.org/blog/foundation-preview-now-available/) |

## Verdict

Apple reported 200% to almost 500% decode-time improvements on standard JSON benchmark files. Libraries built to beat the old decoder now say the new one matches or beats them (ZippyJSON, IkigaJSON), which fits a step of that size.

**Why tier C:** First-party figure with no hardware, OS build or per-file numbers; only the test data (the Boost.JSON benchmark files) is identified.

## Use it when

- Default choice on iOS 17+ / macOS 14+ before adding a third-party decoder
- Re-measure third-party decoders adopted for older OS versions after raising the deployment target

## Skip it when

- Apps running on iOS 16 and earlier still get the old decoder
- Throughput-critical paths: yyjson-based libraries and Apple's experimental NewCodable report further multiples

## How it is fast

The new decoder parses JSON in Swift straight into the structure Codable reads from, instead of first building NSDictionary, NSArray and NSNumber objects through NSJSONSerialization and bridging them back to Swift. Removing that Objective-C round trip removes most of the per-value allocation and bridging cost.

## What it costs

- Only on the 2023 and later OS releases; older deployment targets keep the old implementation

## Problems with the evidence

- No per-file numbers, hardware or OS build; '200%' is ambiguous between 2x and 3x faster.
- The post (April 2023) describes the swift-foundation preview package; the OS release came with macOS 14 / iOS 17.
- Very large apps can still lose decode time to protocol-conformance checks inside JSONDecoder; swift-foundation PR #1481 (merged 2025-09-30) removed the main one for the default key strategy.

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> eliminating costly roundtrips to and from the Objective-C collection types
>
> — [swift.org/blog/foundation-preview-now-available/](https://www.swift.org/blog/foundation-preview-now-available/)

> there are improvements in decode time from 200% to almost 500%.
>
> — [swift.org/blog/foundation-preview-now-available/](https://www.swift.org/blog/foundation-preview-now-available/)

> JSONDecoder is faster than ZippyJSON for iOS 17+.
>
> — [github.com/michaeleisel/ZippyJSON/blob/master/README.md](https://github.com/michaeleisel/ZippyJSON/blob/master/README.md)

> IkigaJSON is competitive to the modern Foundation JSON in benchmarks, and outperforms older versions of Foundation JSON by a large margin.
>
> — [github.com/orlandos-nl/swift-json/blob/master/README.md](https://github.com/orlandos-nl/swift-json/blob/master/README.md)

</details>
