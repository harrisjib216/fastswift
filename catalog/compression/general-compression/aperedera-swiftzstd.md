# SwiftZSTD (zstd)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Compression](../README.md) › [General-purpose compression](README.md)</sub>

**Tier A** (reproducible public benchmark) · ✅ Holds up · Open source · `Swift + C` · `NOASSERTION` · 🟢 active

> Swift wrapper for zstd; the codec compresses 4.7-15x and decompresses about 4x faster than zlib at similar or better ratios.

| | |
|---|---|
| **Beats** | Compression framework COMPRESSION_ZLIB and NSData.compressed(using: .zlib) |
| **Claimed result** | zstd -1: 411 MB/s vs 26.8 MB/s compression (15.3x) and 1351 MB/s vs 314 MB/s decompression (4.3x) against zlib 1.3.2 -6, ratio 34.53% vs 32.19%; zstd -5: 126 MB/s (4.7x) and 1172 MB/s (3.7x) at a smaller 29.60% (derived from page data) |
| **Workload** | Silesia corpus (silesia.tar, 212 MB), single thread, whole-file compress and decompress |
| **Metric** | throughput |
| **Hardware** | AMD EPYC 9555P at 3.20 GHz, turbo off, single thread |
| **OS** | Ubuntu 26.04 |
| **Toolchain** | lzbench 2.4 built with gcc 15.2.0; zstd 1.5.7 |
| **Measured** | 2026 |
| **Adoption** | 88 stars |
| **Last commit** | 2026-09-28 |
| **Platforms** | macOS, iOS, Linux (streaming API on Apple platforms only) |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/aperedera/SwiftZSTD) · [benchmark](https://github.com/inikep/lzbench) |

## Verdict

In lzbench, zstd at level 1 compresses 15.3x and decompresses 4.3x faster than zlib -6 at a similar ratio, and level 5 is still 4.7x and 3.7x faster with smaller output. SwiftZSTD builds the official zstd C code, so the codec numbers carry over, though the Swift layer itself is unmeasured.

**Why tier A:** Independent lzbench run with public code, CPU, compiler and corpus stated; it measures the zstd C library that SwiftZSTD builds from source.

## Use it when

- Both ends are under your control (your app and your server) and you want zlib-or-better ratio at a fraction of the CPU
- Large payloads, logs or caches where decode throughput matters
- Dictionary compression of many small, similar records

## Skip it when

- The consumer only speaks gzip/zlib (browsers' Content-Encoding without zstd support, older servers)
- You want no third-party C code in the app; LZFSE or LZMESH are built in

## How it is fast

zstd uses a fast LZ77 match finder, Huffman-coded literals and Finite State Entropy for sequences, with branch-light decode loops that process several streams in parallel. Its low levels skip most match searching, and its decoder speed barely changes with level.

## What it costs

- Adds the zstd C library to the binary
- Streaming API fails on Linux and Windows per the README
- Small single-maintainer wrapper

## Problems with the evidence

- Codec measured on x86 Linux with gcc, not through the Swift wrapper on Apple silicon
- lzbench compares stock zlib; Apple's COMPRESSION_ZLIB is a separate level-5 implementation with a faster decoder
- The lzbench author has contributed to zstd
- GitHub reports NOASSERTION; the LICENSE file is BSD 3-Clause with an extra heading line

## Evidence

<details>
<summary>5 quotes from the sources, checked 2026-10-28</summary>

> | zstd 1.5.7 -1 | 411 MB/s | 1351 MB/s | 73193704 | 34.53 |
>
> — [github.com/inikep/lzbench](https://github.com/inikep/lzbench)

> | zstd 1.5.7 -5 | 126 MB/s | 1172 MB/s | 62740852 | 29.60 |
>
> — [github.com/inikep/lzbench](https://github.com/inikep/lzbench)

> | zlib 1.3.2 -6 | 26.8 MB/s | 314 MB/s | 68228431 | 32.19 |
>
> — [github.com/inikep/lzbench](https://github.com/inikep/lzbench)

> The tests were run on a single thread of an AMD EPYC 9555P processor at 3.20 GHz
>
> — [github.com/inikep/lzbench](https://github.com/inikep/lzbench)

> `Package.swift` references the official ZSTD C repository on GitHub as a dependency.
>
> — [github.com/aperedera/SwiftZSTD](https://github.com/aperedera/SwiftZSTD)

</details>
