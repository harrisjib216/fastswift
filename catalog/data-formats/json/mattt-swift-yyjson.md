# swift-yyjson (YYJSON)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md) › [JSON](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Open source · `Swift + C` · `MIT` · 🟢 active

> yyjson wrapper with JSONSerialization/JSONDecoder-style APIs; parses 9-15x faster than JSONSerialization, Codable path unmeasured.

| | |
|---|---|
| **Beats** | Foundation JSONSerialization.jsonObject (macOS 26, swift-foundation era) |
| **Claimed result** | p50 wall clock, YYJSONValue parse vs JSONSerialization: twitter.json 128 μs vs 1962 μs (15.3x), citm_catalog.json 331 vs 3328 μs (10.1x), canada.json 1247 vs 11821 μs (9.5x), tokenizer.json 6521 vs 56951 μs (8.7x) (ratios derived from page data). README summary table: ~16×, ~10×, ~16×, ~9×. twitter.json: 3 allocations vs over 6,600; peak memory 19 MB vs 378 MB. |
| **Workload** | Parsing four nativejson-benchmark fixtures (twitter.json ~632KB, citm_catalog.json ~1.7MB, canada.json ~2.2MB, tokenizer.json ~11MB) into an untyped value: YYJSONValue(data:) vs JSONSerialization.jsonObject(with:) |
| **Metric** | time (p50 wall clock), allocations, peak memory |
| **Hardware** | Apple silicon MacBook Pro, 16 arm64 cores, 48 GB (chip not named) |
| **OS** | macOS 26 (Darwin 25.2.0) |
| **Toolchain** | swift package benchmark (package-benchmark); Swift version not stated |
| **Measured** | 2026 |
| **Adoption** | 93 stars |
| **Last commit** | 2026-05-31 |
| **Platforms** | macOS 10.15+, iOS 13+, tvOS 13+, watchOS 6+, visionOS 1+ |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/mattt/swift-yyjson) · [benchmark](https://github.com/mattt/swift-yyjson/blob/main/README.md) |

## Verdict

The raw results confirm 8.7x-15x faster untyped parsing than JSONSerialization on four standard fixtures. The headline table overstates canada.json (~16x claimed, raw p50 about 9.5x), and no numbers are published for its JSONDecoder replacement against Codable JSONDecoder.

**Why tier A:** Benchmark source is public (swift-yyjson-benchmark, package-benchmark) and the raw output names the host (16 arm64 cores, 48 GB) and its Darwin 25.2.0 kernel; first-party.

## Use it when

- Untyped JSON access (dictionary-style traversal, partial reads) on large documents
- Number-heavy data such as GeoJSON
- Memory-constrained parsing of large files: 19 MB vs 378 MB peak on twitter.json

## Skip it when

- Your hot path is Codable decoding: no YYJSONDecoder vs JSONDecoder numbers are published
- You need exact decimal semantics with the fast number strategy, which the README calls lossy (opt-in)

## How it is fast

yyjson parses the whole document into one contiguous immutable structure with a handful of allocations (3 for twitter.json) and fast floating-point parsing. YYJSONValue reads from that structure on demand instead of creating NSDictionary, NSArray and NSNumber objects for every node as JSONSerialization does. In-place parsing can reuse the input buffer for string storage.

## What it costs

- Bundles yyjson (C)
- The largest wins need the YYJSONValue API rather than the Codable drop-in

## Problems with the evidence

- Baseline is JSONSerialization building a full Foundation object graph; YYJSONValue does not materialize Swift objects up front, so the comparison favors YYJSON when only part of the document is read.
- Summary table and raw results disagree for canada.json: the table says ~36.0 ms vs ~2.3 ms, the raw p50 is 11821 μs vs 1247 μs.
- Codable encoder/decoder benchmarks exist in the benchmark repo but their results are not published.
- First-party.

## Evidence

<details>
<summary>15 quotes from the sources, checked 2026-10-28</summary>

> | `twitter.json` (~632KB)      | ~180 μs |    ~2.9 ms |    ~16× |
>
> — [github.com/mattt/swift-yyjson/blob/main/README.md](https://github.com/mattt/swift-yyjson/blob/main/README.md)

> | `citm_catalog.json` (~1.7MB) | ~425 μs |    ~4.3 ms |    ~10× |
>
> — [github.com/mattt/swift-yyjson/blob/main/README.md](https://github.com/mattt/swift-yyjson/blob/main/README.md)

> | `canada.json` (~2.2MB)       | ~2.3 ms |   ~36.0 ms |    ~16× |
>
> — [github.com/mattt/swift-yyjson/blob/main/README.md](https://github.com/mattt/swift-yyjson/blob/main/README.md)

> | `tokenizer.json` (~11MB)     | ~6.5 ms |   ~57.0 ms |     ~9× |
>
> — [github.com/mattt/swift-yyjson/blob/main/README.md](https://github.com/mattt/swift-yyjson/blob/main/README.md)

> Parsing twitter.json requires only 3 allocations compared to over 6,600 for Foundation, with peak memory of 19 MB versus up to 378 MB.
>
> — [github.com/mattt/swift-yyjson/blob/main/README.md](https://github.com/mattt/swift-yyjson/blob/main/README.md)

> Host 'MacBook-Pro.local' with 16 'arm64' processors with 48 GB memory, running: Darwin Kernel Version 25.2.0
>
> — [github.com/mattt/swift-yyjson/blob/main/README.md](https://github.com/mattt/swift-yyjson/blob/main/README.md)

> | Time (wall clock) (μs) \*  | 1883 | 1945 | 1962 | 1982 | 2032 | 2198 | 2294 |     501 |
>
> — [github.com/mattt/swift-yyjson/blob/main/README.md](https://github.com/mattt/swift-yyjson/blob/main/README.md)

> | Time (wall clock) (μs) \*  |  117 |  122 |  128 |  135 |  138 |  150 |  420 |    6785 |
>
> — [github.com/mattt/swift-yyjson/blob/main/README.md](https://github.com/mattt/swift-yyjson/blob/main/README.md)

> | Time (wall clock) (μs) \*  | 3203 | 3291 | 3328 | 3381 | 3518 | 3629 | 3659 |     297 |
>
> — [github.com/mattt/swift-yyjson/blob/main/README.md](https://github.com/mattt/swift-yyjson/blob/main/README.md)

> | Time (wall clock) (μs) \*  |  307 |  325 |  331 |  336 |  342 |  357 |   386 |    2871 |
>
> — [github.com/mattt/swift-yyjson/blob/main/README.md](https://github.com/mattt/swift-yyjson/blob/main/README.md)

> | Time (wall clock) (μs) \*  | 11419 | 11723 | 11821 | 11969 | 12034 | 12227 | 12227 |      85 |
>
> — [github.com/mattt/swift-yyjson/blob/main/README.md](https://github.com/mattt/swift-yyjson/blob/main/README.md)

> | Time (wall clock) (μs) \*  | 1162 | 1234 | 1247 | 1258 | 1271 | 1316 | 1342 |     790 |
>
> — [github.com/mattt/swift-yyjson/blob/main/README.md](https://github.com/mattt/swift-yyjson/blob/main/README.md)

> | Time (wall clock) (μs) \*  | 54202 | 56001 | 56951 | 57541 | 58917 | 59050 | 59050 |      18 |
>
> — [github.com/mattt/swift-yyjson/blob/main/README.md](https://github.com/mattt/swift-yyjson/blob/main/README.md)

> | Time (wall clock) (μs) \*  | 6315 | 6476 | 6521 | 6554 | 6599 | 6816 | 7857 |     153 |
>
> — [github.com/mattt/swift-yyjson/blob/main/README.md](https://github.com/mattt/swift-yyjson/blob/main/README.md)

> Benchmark.blackHole(try! JSONSerialization.jsonObject(with: data))
>
> — [github.com/mattt/swift-yyjson-benchmark/blob/main/Benchmarks/YYJSON…](https://github.com/mattt/swift-yyjson-benchmark/blob/main/Benchmarks/YYJSONBenchmarks/FixtureBenchmarks.swift)

</details>
