# SwiftProtobuf (binary wire format)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md) › [Binary serialization](README.md)</sub>

**Tier A** (reproducible public benchmark) · ✅ Holds up · Open source · `Swift` · `Apache-2.0` · 🟢 active

> Apple's Protocol Buffers runtime for Swift; 5-19x the throughput of Codable JSON in a third-party benchmark, at about half the bytes.

| | |
|---|---|
| **Beats** | Codable with Foundation JSONEncoder / JSONDecoder (swift-foundation, macOS 15.7.2) |
| **Claimed result** | Throughput vs JSONEncoder/JSONDecoder: NumericStruct serialize 7,572,190 vs 481,278 ops/s (15.7x), deserialize 7,317,942 vs 377,802 (19.4x); MediaContent serialize 784,863 vs 111,200 (7.1x), deserialize 549,726 vs 97,799 (5.6x); MediaContentList deserialize 99,445 vs 19,521 (5.1x) (ratios derived from page data). Size: 93 vs 159 bytes (NumericStruct), 301 vs 608 bytes (MediaContent). |
| **Workload** | Serialize and deserialize six model shapes (struct of 12 int32 fields, mixed struct with arrays, nested media object graph, and lists of each) for 3 s per case; the protobuf path includes converting between the Swift models and generated message types |
| **Metric** | throughput (operations per second) and payload size |
| **Hardware** | MacBook Pro, 12 logical cores, 48 GB (chip not named) |
| **OS** | macOS 15.7.2 (24G325) |
| **Toolchain** | swift build -c release (run.sh); Swift version not stated; swift-protobuf 1.35.0 or later |
| **Measured** | 2026-08-04 |
| **Adoption** | 5.0k stars |
| **Last commit** | 2026-10-27 |
| **Platforms** | Apple platforms and Linux |
| **Install** | Swift Package Manager (plus the protoc-gen-swift plugin) |
| **Links** | [repository](https://github.com/apple/swift-protobuf) · [benchmark](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md) |

## Verdict

A third-party benchmark (Apache Fory's Swift suite) measured 5.1x-19.4x the throughput of JSONEncoder/JSONDecoder across six data shapes, with payloads 42-50% smaller. The swift-protobuf README itself only says the serializers are 'extensively optimized'.

**Why tier A:** Benchmark code and run script (swift build -c release) are public in apache/fory, the page states OS build, core count and memory, and the authors are independent of swift-protobuf.

## Use it when

- Wire or disk formats where you control both ends
- Cross-language contracts defined in .proto files
- Hot paths encoding many small structs

## Skip it when

- Payloads must be human-readable or match an existing JSON API
- You cannot add a code-generation step to the build

## How it is fast

protoc generates a concrete serializer for each message type, so encoding and decoding are straight-line visits over numbered fields in a varint and length-delimited wire format. There are no key strings to write, match or hash, no Codable container existentials, and no text escaping or number formatting.

## What it costs

- Generated message types instead of your own structs, or a conversion layer
- Schema files and a protoc plugin in the build
- Binary payloads are not human-readable

## Problems with the evidence

- Measured by a competing serialization project (Apache Fory), which ranks first in its own table.
- The protobuf numbers include converting to and from generated message types, which understates SwiftProtobuf's raw speed.
- CPU model not named; one run of 3 s per case.

## Evidence

<details>
<summary>14 quotes from the sources, checked 2026-10-28</summary>

> - **Protocol Buffers**: `apple/swift-protobuf`
>
> — [github.com/apache/fory/blob/main/benchmarks/swift/README.md](https://github.com/apache/fory/blob/main/benchmarks/swift/README.md)

> - **JSON**: Foundation `JSONEncoder` and `JSONDecoder`
>
> — [github.com/apache/fory/blob/main/benchmarks/swift/README.md](https://github.com/apache/fory/blob/main/benchmarks/swift/README.md)

> | OS                    | Version 15.7.2 (Build 24G325) |
>
> — [github.com/apache/fory/blob/main/docs/benchmarks/object-serializati…](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md)

> | CPU Cores (Logical)   | 12                            |
>
> — [github.com/apache/fory/blob/main/docs/benchmarks/object-serializati…](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md)

> | Memory (GB)           | 48.00                         |
>
> — [github.com/apache/fory/blob/main/docs/benchmarks/object-serializati…](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md)

> swift build -c release --product swift-benchmark
>
> — [github.com/apache/fory/blob/main/benchmarks/swift/run.sh](https://github.com/apache/fory/blob/main/benchmarks/swift/run.sh)

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

> | MediaContentList  | Deserialize |    215,726 |       99,445 |   19,521 | fory (2.17x) |
>
> — [github.com/apache/fory/blob/main/docs/benchmarks/object-serializati…](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md)

> | NumericStruct     |   78 |       93 |  159 |
>
> — [github.com/apache/fory/blob/main/docs/benchmarks/object-serializati…](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md)

> | MediaContent      |  362 |      301 |  608 |
>
> — [github.com/apache/fory/blob/main/docs/benchmarks/object-serializati…](https://github.com/apache/fory/blob/main/docs/benchmarks/object-serialization/xlang/swift/README.md)

> Performant: The binary and JSON serializers have been extensively optimized.
>
> — [github.com/apple/swift-protobuf/blob/main/README.md](https://github.com/apple/swift-protobuf/blob/main/README.md)

</details>
