# IkigaJSON (orlandos-nl/swift-json)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md) › [JSON](README.md)</sub>

**Tier A** (reproducible public benchmark) · ❌ Doesn't hold up · Open source · `Swift` · `MIT` · 🟢 active

> SwiftNIO-friendly Codable JSON coder; its own 2026 benchmark puts it level with or behind modern Foundation, with fewer decode allocations.

| | |
|---|---|
| **Beats** | Foundation JSONDecoder / JSONEncoder after the swift-foundation rewrite (macOS 26) |
| **Claimed result** | p50 decode, IkigaJSON vs Foundation: small 3.79 μs vs 3.88 μs, medium 9.05 μs vs 8.26 μs, large (~27 KB) 556 μs vs 381 μs (1.46x slower, derived from page data). p50 encode: small 3.21 vs 3.54 μs, medium 6.17 vs 6.30 μs, large 329 vs 300 μs. Decode mallocs: 10 vs 15 (small), 26 vs 33 (medium). |
| **Workload** | Codable encode and decode of small (~100 bytes), medium (~400 bytes) and large (~27 KB) payloads; p50 wall-clock time and malloc counts |
| **Metric** | time (p50 wall clock) and malloc count |
| **Hardware** | Apple M4 Max |
| **OS** | macOS 26 |
| **Toolchain** | swift package benchmark (package-benchmark, release build); Swift version not stated |
| **Measured** | 2026-05-19 |
| **Adoption** | 425 stars |
| **Last commit** | 2026-08-20 |
| **Platforms** | macOS, iOS, Linux |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/orlandos-nl/swift-json) · [benchmark](https://github.com/orlandos-nl/swift-json/blob/master/README.md) |

## Verdict

The project's current benchmark on macOS 26 has it within about 10% of Foundation on small and medium payloads and slower on the large one (decode 556 μs vs 381 μs, encode 329 μs vs 300 μs). Its remaining advantage is fewer allocations when decoding, not speed.

**Why tier A:** Benchmark code ships in the repo (Benchmarks/JSONBenchmark, run with swift package benchmark) and the README states the Apple M4 Max and macOS 26; first-party, Swift version not stated.

## Use it when

- Server code on SwiftNIO, Hummingbird or Vapor where decode allocation count matters more than raw speed
- You want raw JSONObject/JSONArray access without full Codable decoding

## Skip it when

- Choosing a JSON library for speed on current Apple OSes: Foundation matches or beats it in the project's own table
- Large payloads: 556 μs vs Foundation's 381 μs to decode ~27 KB

## How it is fast

It parses into a compact index over the original bytes instead of materializing a tree of Swift values, and reads and writes SwiftNIO ByteBuffers directly. That keeps allocation counts low. Against the post-2023 Foundation decoder, the Codable protocol layer dominates and the parser advantage mostly disappears.

## What it costs

- Depends on SwiftNIO
- More allocations than Foundation on medium encodes (40 vs 24 mallocs)

## Problems with the evidence

- First-party benchmark; Swift toolchain version not stated.
- Results have moved a lot between versions: the README table before the 2026-05-19 update showed large decodes at 37 ms vs Foundation's 416 μs.
- A second measurement by the same author (swift-json-schema forum post, Apple M4 Max, June 2026) also has IkigaJSON's Codable decoder slower than Foundation on a large payload: 590 µs vs 408 µs.
- The README intro still says it 'outperforms older versions of Foundation JSON by a large margin', but gives no numbers for those older versions.

## Evidence

<details>
<summary>13 quotes from the sources, checked 2026-10-28</summary>

> Benchmarks run on Apple M4 Max (macOS 26). Lower time is better.
>
> — [github.com/orlandos-nl/swift-json/blob/master/README.md](https://github.com/orlandos-nl/swift-json/blob/master/README.md)

> | Small (~100 bytes) | 3.54 μs | 3.21 μs |
>
> — [github.com/orlandos-nl/swift-json/blob/master/README.md](https://github.com/orlandos-nl/swift-json/blob/master/README.md)

> | Medium (~400 bytes) | 6.30 μs | 6.17 μs |
>
> — [github.com/orlandos-nl/swift-json/blob/master/README.md](https://github.com/orlandos-nl/swift-json/blob/master/README.md)

> | Large (~27 KB) | 300 μs | 329 μs |
>
> — [github.com/orlandos-nl/swift-json/blob/master/README.md](https://github.com/orlandos-nl/swift-json/blob/master/README.md)

> | Small (~100 bytes) | 3.88 μs | 3.79 μs |
>
> — [github.com/orlandos-nl/swift-json/blob/master/README.md](https://github.com/orlandos-nl/swift-json/blob/master/README.md)

> | Medium (~400 bytes) | 8.26 μs | 9.05 μs |
>
> — [github.com/orlandos-nl/swift-json/blob/master/README.md](https://github.com/orlandos-nl/swift-json/blob/master/README.md)

> | Large (~27 KB) | 381 μs | 556 μs |
>
> — [github.com/orlandos-nl/swift-json/blob/master/README.md](https://github.com/orlandos-nl/swift-json/blob/master/README.md)

> | Decode Small | 15 | 10 |
>
> — [github.com/orlandos-nl/swift-json/blob/master/README.md](https://github.com/orlandos-nl/swift-json/blob/master/README.md)

> | Decode Medium | 33 | 26 |
>
> — [github.com/orlandos-nl/swift-json/blob/master/README.md](https://github.com/orlandos-nl/swift-json/blob/master/README.md)

> | Encode Medium | 24 | 40 |
>
> — [github.com/orlandos-nl/swift-json/blob/master/README.md](https://github.com/orlandos-nl/swift-json/blob/master/README.md)

> IkigaJSON is competitive with Foundation in throughput for small and medium payloads. Its main advantage is fewer memory allocations for decoding
>
> — [github.com/orlandos-nl/swift-json/blob/master/README.md](https://github.com/orlandos-nl/swift-json/blob/master/README.md)

> 590 µs · 1,840 allocs
>
> — [forums.swift.org/t/swift-json-schema-an-efficient-codable-alternati…](https://forums.swift.org/t/swift-json-schema-an-efficient-codable-alternative/87268)

> 408 µs · 1,752 allocs
>
> — [forums.swift.org/t/swift-json-schema-an-efficient-codable-alternati…](https://forums.swift.org/t/swift-json-schema-an-efficient-codable-alternative/87268)

</details>
