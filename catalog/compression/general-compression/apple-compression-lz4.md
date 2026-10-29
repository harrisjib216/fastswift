# Compression framework (LZ4)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Compression](../README.md) › [General-purpose compression](README.md)</sub>

**Tier B** (independent measurement) · ✅ Holds up · Ships with Apple's SDKs · `C` · `Apple SDK` · 🟢 active

> Apple's LZ4 codec; upstream LZ4 decompresses 12.9x and compresses 6.2x faster than zlib's fastest level, with larger output.

| | |
|---|---|
| **Beats** | Compression framework COMPRESSION_ZLIB and NSData.compressed(using: .zlib) |
| **Claimed result** | 550 MB/s vs 89.0 MB/s compression (6.2x) and 3832 MB/s vs 297 MB/s decompression (12.9x) against zlib 1.3.2 -1; output 47.60% of input vs 36.45% (derived from page data) |
| **Workload** | Silesia corpus (silesia.tar, 212 MB), single thread, whole-file compress and decompress |
| **Metric** | throughput |
| **Hardware** | AMD EPYC 9555P at 3.20 GHz, turbo off, single thread |
| **OS** | Ubuntu 26.04 |
| **Toolchain** | lzbench 2.4 built with gcc 15.2.0 |
| **Measured** | 2026 |
| **Platforms** | iOS 9+, macOS 10.11+, tvOS 9+, watchOS 2+, visionOS 1+ |
| **Install** | built into iOS 9+ / macOS 10.11+ (Compression framework; NSData.compressed(using: .lz4) on iOS 13+ / macOS 10.15+) |
| **Links** | [documentation](https://developer.apple.com/documentation/compression/compression_lz4) · [benchmark](https://github.com/inikep/lzbench) |

## Verdict

Apple gives no LZ4 numbers, but an independent lzbench run of upstream LZ4 shows 6.2x faster compression and 12.9x faster decompression than zlib's fastest level, in exchange for noticeably larger output.

**Why tier B:** Independent, reproducible lzbench run, but of the upstream LZ4 library rather than Apple's own implementation in the Compression framework.

## Use it when

- Speed matters more than size: caches, IPC, scratch files, in-memory snapshots
- Decoding happens often on battery-powered devices

## Skip it when

- Bandwidth or storage is the constraint; output is about 30% larger than zlib's here
- Interop with third-party LZ4 readers: use COMPRESSION_LZ4_RAW, because COMPRESSION_LZ4 adds Apple's own block framing

## How it is fast

LZ4 does LZ77 matching with a single hash probe and writes literals and matches as byte-aligned tokens with no entropy coding. Decoding is little more than memcpy of literals and back-references.

## What it costs

- Lowest ratio of the Compression framework algorithms
- COMPRESSION_LZ4's framing is not readable by stock LZ4 tools

## Problems with the evidence

- Measures upstream lz4 1.10.0 on x86 Linux, not Apple's implementation on Apple silicon
- Apple's documentation gives no LZ4 numbers

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> | lz4 1.10.0 | 550 MB/s | 3832 MB/s | 100880800 | 47.60 |
>
> — [github.com/inikep/lzbench](https://github.com/inikep/lzbench)

> | zlib 1.3.2 -1 | 89.0 MB/s | 297 MB/s | 77259029 | 36.45 |
>
> — [github.com/inikep/lzbench](https://github.com/inikep/lzbench)

> The tests were run on a single thread of an AMD EPYC 9555P processor at 3.20 GHz
>
> — [github.com/inikep/lzbench](https://github.com/inikep/lzbench)

> The LZ4 compression algorithm for fast compression.
>
> — [developer.apple.com/tutorials/data/documentation/compression/compre…](https://developer.apple.com/tutorials/data/documentation/compression/compression_lz4.json)

</details>
