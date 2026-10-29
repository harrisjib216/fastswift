# SWCompression

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Compression](../README.md) › [General-purpose compression](README.md)</sub>

**Tier A** (reproducible public benchmark) · ❌ Doesn't hold up · Open source · `Swift` · `MIT` · 🟢 active

> Pure-Swift decompressors for Deflate, LZ4, LZMA, BZip2 and archive formats; roughly 23-74x slower than the C codecs.

| | |
|---|---|
| **Beats** | Compression framework COMPRESSION_ZLIB / NSData.compressed(using: .zlib), and Apple's LZ4 |
| **Claimed result** | Slower, not faster: Deflate (gzip) decompress 13.4-13.6 MB/s vs 314 MB/s for zlib -6 (about 23x slower); LZ4 decompress 51.8-70.3 MB/s vs 3832 MB/s for lz4 (55-74x slower) (derived across two pages and two machines) |
| **Workload** | Decompress three real data sets (Git 2.15.0 source, the VS Code 1.18.1 app, Linux 4.14.2 documentation), averaged over 10 iterations, release build |
| **Metric** | throughput |
| **Hardware** | MacBook Air M4, 15-inch, 2025 |
| **OS** | macOS 26.5 |
| **Toolchain** | Swift 6.3.2, Release configuration |
| **Measured** | 2026 |
| **Adoption** | 278 stars |
| **Last commit** | 2026-07-01 |
| **Platforms** | iOS 18+, macOS 15+, tvOS 18+, watchOS 11+, visionOS 2+, Linux, Windows |
| **Install** | Swift Package Manager (CocoaPods and Carthage only up to 4.8.6) |
| **Links** | [repository](https://github.com/tsolomko/SWCompression) · [benchmark](https://github.com/tsolomko/SWCompression/blob/develop/Tests/Results.md) |

## Verdict

Its own benchmarks on an M4 MacBook Air show Deflate decompression at about 13.5 MB/s and LZ4 decompression at 52-70 MB/s. Stock zlib decompresses at 314 MB/s and LZ4 at 3832 MB/s on a server core, so the pure-Swift codecs are one to two orders of magnitude slower than the C ones they would replace.

**Why tier A:** The project's own benchmark command with hardware, macOS and Swift versions stated; the comparison to zlib and LZ4 is across sources and machines.

## Use it when

- Formats the Compression framework does not read: BZip2, 7-Zip, TAR, XZ containers on Linux
- Pure-Swift builds on Linux or Windows with no C dependencies

## Skip it when

- Deflate, LZ4 or LZMA decoding on Apple platforms, where the Compression framework is built in and far faster
- Large archives or hot paths where decode time shows up

## How it is fast

It is not fast. Every codec is implemented in Swift on top of a bit reader (BitByteData) with bounds-checked array access, and none uses the hand-tuned C or SIMD decoders that zlib, LZ4 or Apple's Compression framework use. Its value is format coverage and portability, not speed.

## What it costs

- Much lower throughput than C codecs
- Deflate compression ratio is weaker than zlib's, per the project's own to-do list

## Problems with the evidence

- The zlib and LZ4 reference speeds come from lzbench on an AMD EPYC server core, not the M4; an M4 core is likely faster than that server core at 3.2 GHz, so the real gap on the same machine is probably larger
- Compression-speed rows are not comparable across sources because the ratios differ, so only decompression is compared
- Data sets differ: SWCompression's three sets versus lzbench's Silesia corpus

## Evidence

<details>
<summary>6 quotes from the sources, checked 2026-10-28</summary>

> In this document you can find the results of benchmarking which was performed on Macbook Air M4, 15-inch, 2025.
>
> — [github.com/tsolomko/SWCompression/blob/develop/Tests/Results.md](https://github.com/tsolomko/SWCompression/blob/develop/Tests/Results.md)

> |4.9.0|2.1.0|26.5|6.3.2|13.570 ± 0.015 MB/s|13.392 ± 0.014 MB/s|13.373 ± 0.068 MB/s|
>
> — [github.com/tsolomko/SWCompression/blob/develop/Tests/Results.md](https://github.com/tsolomko/SWCompression/blob/develop/Tests/Results.md)

> |4.9.0|2.1.0|26.5|6.3.2|54.635 ± 0.315 MB/s|70.268 ± 0.562 MB/s|51.792 ± 0.396 MB/s|
>
> — [github.com/tsolomko/SWCompression/blob/develop/Tests/Results.md](https://github.com/tsolomko/SWCompression/blob/develop/Tests/Results.md)

> All tests were run using swcomp's "benchmark" command. SWCompression (and swcomp) were compiled using "Release" configuration.
>
> — [github.com/tsolomko/SWCompression/blob/develop/Tests/Results.md](https://github.com/tsolomko/SWCompression/blob/develop/Tests/Results.md)

> | zlib 1.3.2 -6 | 26.8 MB/s | 314 MB/s | 68228431 | 32.19 |
>
> — [github.com/inikep/lzbench](https://github.com/inikep/lzbench)

> | lz4 1.10.0 | 550 MB/s | 3832 MB/s | 100880800 | 47.60 |
>
> — [github.com/inikep/lzbench](https://github.com/inikep/lzbench)

</details>
