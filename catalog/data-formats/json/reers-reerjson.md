# ReerJSON

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md) › [JSON](README.md)</sub>

**Tier D** (directional only) · ✅ Holds up · Open source · `Swift + C` · `MIT` · 🟢 active

> yyjson-backed drop-in JSONDecoder/JSONEncoder; its charts show it ahead of Foundation on iOS 26, but the numbers are only in images.

| | |
|---|---|
| **Beats** | Foundation JSONDecoder / JSONEncoder, both before iOS 17 and after the swift-foundation rewrite (iOS 26, macOS 15.6) |
| **Claimed result** | No figures in text; README charts (images) show it ahead of Foundation JSONDecoder and JSONEncoder on iOS 17+, on earlier iOS, and on macOS |
| **Workload** | Decoding and encoding the github_events, twitter, apache_builds, canada and random JSON fixtures with Codable models (chart labels) |
| **Metric** | throughput (operations per second) |
| **Hardware** | iPhone 15 Pro, iPhone 14 Plus, Apple M4 Pro MacBook Pro (chart subtitles) |
| **OS** | iOS 26.0 and 26.4.1, iOS 16.1.2, macOS 15.6 (chart subtitles) |
| **Measured** | 2025-09 |
| **Adoption** | 48 stars |
| **Last commit** | 2026-09-25 |
| **Platforms** | iOS 15+, macOS 12+, tvOS 15+, watchOS 9+, visionOS 1+ |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/reers/ReerJSON) · [benchmark](https://github.com/reers/ReerJSON/blob/main/README.md) |

## Verdict

Its charts show it ahead of the current Foundation decoder and encoder on every test file on iPhone and Mac, and the benchmark app is public. The figures exist only as images and come from the library's authors, so the claim stands on weak evidence.

**Why tier D:** Every number is in a chart image; the README text has no figures.

## Use it when

- You want a drop-in JSONDecoder/JSONEncoder replacement and have measured JSON as a hotspot on your own devices
- Number-heavy payloads (the canada.json fixture shows the largest gap in the charts)

## Skip it when

- Your toolchain is older than Swift 6.4, which the package requires
- You need published, reproducible numbers before adopting: there are none in text

## How it is fast

It parses with yyjson, a C library that builds a compact immutable document in one pass with very few allocations, then runs a Codable decoder over that document. Encoding builds a yyjson mutable document and serializes it in C instead of going through Foundation's encoder.

## What it costs

- Bundles yyjson (C), adding binary size
- Requires a Swift 6.4 toolchain
- The README notes that on older chips such as the A11, yyjson's build-a-DOM-then-serialize encoder can lose to IkigaJSON's streaming encoder

## Problems with the evidence

- Numbers are only in chart images (screenshots). Read off the images: the iOS 26.0 iPhone 15 Pro decode chart shows about 1.5x-3.8x Foundation's throughput, and the iOS 26.4.1 encode chart about 2.3x-6.5x.
- Benchmarks are by the library's authors; the benchmark app (Asura19/ReerJSONBenchmark) has no README or committed results.
- No Swift version or build configuration is stated for the runs.

## Evidence

<details>
<summary>5 quotes from the sources, checked 2026-10-28</summary>

> A faster version of JSONDecoder & JSONEncoder powered by
>
> — [github.com/reers/ReerJSON/blob/main/README.md](https://github.com/reers/ReerJSON/blob/main/README.md)

> Tested with ReerJSON 1.0.1, ZippyJSON 1.2.15, IkigaJSON 2.3.2
>
> — [github.com/reers/ReerJSON/blob/main/README.md](https://github.com/reers/ReerJSON/blob/main/README.md)

> ReerJSON requires Swift 6.4 or newer
>
> — [github.com/reers/ReerJSON/blob/main/README.md](https://github.com/reers/ReerJSON/blob/main/README.md)

> ### iOS 17+
>
> — [github.com/reers/ReerJSON/blob/main/README.md](https://github.com/reers/ReerJSON/blob/main/README.md)

> ### Lower than iOS 17
>
> — [github.com/reers/ReerJSON/blob/main/README.md](https://github.com/reers/ReerJSON/blob/main/README.md)

</details>
