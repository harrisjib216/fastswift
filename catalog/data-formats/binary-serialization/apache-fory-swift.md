# Apache Fory (Swift)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md) › [Binary serialization](README.md)</sub>

**Tier A** (reproducible public benchmark) · ✅ Holds up · Open source · `Swift` · `Apache-2.0` · 🟢 active

> Macro-generated cross-language binary serializer; 11-59x the throughput of Codable JSON and up to 5.6x SwiftProtobuf in its own benchmark.

| | |
|---|---|
| **Beats** | Codable with Foundation JSONEncoder / JSONDecoder (macOS 15.7.2); SwiftProtobuf also compared |
| **Claimed result** | vs JSONEncoder/JSONDecoder: NumericStruct serialize 14,759,606 vs 481,278 ops/s (30.7x), deserialize 18,155,795 vs 377,802 (48.1x); MediaContent serialize 2,987,821 vs 111,200 (26.9x), deserialize 1,072,345 vs 97,799 (11.0x) (JSON ratios derived from page data). vs SwiftProtobuf: from fory (1.65x) on Sample deserialize to fory (5.57x) on MediaContentList serialize. |
| **Workload** | Serialize and deserialize six model shapes (struct of 12 int32 fields, mixed struct with arrays, nested media object graph, and lists of each) for 3 s per case |
| **Metric** | throughput (operations per second) and payload size |
| **Hardware** | MacBook Pro, 12 logical cores, 48 GB (chip not named) |
| **OS** | macOS 15.7.2 (24G325) |
| **Toolchain** | swift build -c release (run.sh); Swift version not stated |
| **Measured** | 2026-08-04 |
| **Adoption** | 4.6k stars |
| **Last commit** | 2026-10-23 |
| **Platforms** | macOS 13+, iOS 16+, tvOS 16+, watchOS 9+, visionOS 1+ |
| **Install** | Swift Package Manager (product Fory, from 1.7.7) |
| **Links** | [repository](https://github.com/apache/fory) · [benchmark](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md) |

## Verdict

Its reproducible benchmark shows 11x-59x the throughput of JSONEncoder/JSONDecoder and 1.65x-5.57x that of SwiftProtobuf on six data shapes. The numbers are first-party, but the harness and run script are public.

**Why tier A:** Benchmark source and run script (swift build -c release) are in the repo and the page states OS build, cores and memory; first-party.

## Use it when

- Object serialization where you control both ends, in-process or across languages
- Object graphs with shared or circular references (trackRef)

## Skip it when

- Human-readable or third-party JSON interchange
- Builds that cannot take a swift-syntax macro dependency

## How it is fast

Swift macros (@ForyStruct, @ForyEnum, @ForyUnion) generate a serializer per type at compile time that writes fields in a fixed order into a compact binary format with variable-length integers. At runtime there are no key strings and no Codable container existentials. The same xlang format is readable from Java, Python, Rust, Go and other Fory runtimes.

## What it costs

- Depends on swift-syntax for its macros, which adds build time
- Fory-specific wire format; some payloads are larger than protobuf's (Sample: 445 vs 375 bytes)

## Problems with the evidence

- First-party benchmark; Fory wins every row of its own table.
- CPU model not named; one run of 3 s per case.
- Repository star count covers the whole multi-language project, not the Swift package.

## Evidence

<details>
<summary>11 quotes from the sources, checked 2026-10-28</summary>

> - **Fory**: Apache Fory Swift implementation (`swift/Sources/Fory`)
>
> — [github.com/apache/fory/blob/main/benchmarks/swift/README.md](https://github.com/apache/fory/blob/main/benchmarks/swift/README.md)

> - **JSON**: Foundation `JSONEncoder` and `JSONDecoder`
>
> — [github.com/apache/fory/blob/main/benchmarks/swift/README.md](https://github.com/apache/fory/blob/main/benchmarks/swift/README.md)

> | OS                    | Version 15.7.2 (Build 24G325) |
>
> — [github.com/apache/fory/blob/main/docs/benchmarks/object-serializati…](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md)

> swift build -c release --product swift-benchmark
>
> — [github.com/apache/fory/blob/main/benchmarks/swift/run.sh](https://github.com/apache/fory/blob/main/benchmarks/swift/run.sh)

> | Sample            | Deserialize |  1,509,740 |      916,626 |   52,897 | fory (1.65x) |
>
> — [github.com/apache/fory/blob/main/docs/benchmarks/object-serializati…](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md)

> | MediaContentList  | Serialize   |    657,276 |      118,004 |   22,744 | fory (5.57x) |
>
> — [github.com/apache/fory/blob/main/docs/benchmarks/object-serializati…](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md)

> | Sample            |  445 |      375 |  696 |
>
> — [github.com/apache/fory/blob/main/docs/benchmarks/object-serializati…](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md)

> | NumericStruct     | Serialize   | 14,759,606 |    7,572,190 |  481,278 | fory (1.95x) |
>
> — [github.com/apache/fory/blob/main/docs/benchmarks/object-serializati…](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md)

> | NumericStruct     | Deserialize | 18,155,795 |    7,317,942 |  377,802 | fory (2.48x) |
>
> — [github.com/apache/fory/blob/main/docs/benchmarks/object-serializati…](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md)

> | MediaContent      | Serialize   |  2,987,821 |      784,863 |  111,200 | fory (3.81x) |
>
> — [github.com/apache/fory/blob/main/docs/benchmarks/object-serializati…](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md)

> | MediaContent      | Deserialize |  1,072,345 |      549,726 |   97,799 | fory (1.95x) |
>
> — [github.com/apache/fory/blob/main/docs/benchmarks/object-serializati…](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md)

</details>
