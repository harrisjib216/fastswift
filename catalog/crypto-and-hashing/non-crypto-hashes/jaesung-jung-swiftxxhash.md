# SwiftXXHash (xxHash XXH3/XXH64)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Crypto and hashing](../README.md) › [Non-cryptographic hashes](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Open source · `Swift + C` · `MIT` · 🟢 active

> Swift wrapper for the official xxHash C library; XXH3 hashes bytes about 10x faster than SipHash in xxHash's x86 benchmark.

| | |
|---|---|
| **Beats** | Swift's Hasher (SipHash-1-3) and hashValue |
| **Claimed result** | XXH3 (SSE2) 31.5 GB/s vs SipHash 3.0 GB/s (10.5x), XXH3 (AVX2) 59.4 GB/s (19.8x), XXH64 19.4 GB/s (6.5x); small-data velocity 133.1 vs 43.2 for SipHash (3.1x) (ratios derived from page data) |
| **Workload** | Bulk hashing bandwidth on in-cache input, plus a 'small data velocity' score for short keys |
| **Metric** | throughput |
| **Hardware** | Intel i7-9700K |
| **OS** | Ubuntu 20.04 x64 |
| **Toolchain** | Clang 10.0, -O3 |
| **Adoption** | 6 stars |
| **Last commit** | 2025-11-20 |
| **Platforms** | iOS 13+, macOS 10.15+, tvOS 13+, watchOS 6+, visionOS 1+ |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/Jaesung-Jung/SwiftXXHash) · [benchmark](https://github.com/Cyan4973/xxHash) |

## Verdict

xxHash's own x86 benchmark shows XXH3 at 10x SipHash's bulk bandwidth and 3.1x its small-input speed, and this package wraps that C code unmodified. But the comparison is against reference SipHash-2-4 in C, nothing measures the Swift wrapper, and Dictionary and Set cannot swap out Hasher, so the win applies only to hashing byte buffers yourself.

**Why tier A:** xxHash's public benchmark program with CPU, OS and compiler flags stated; it measures the bundled C library, not the Swift layer.

## Use it when

- Checksumming files, cache keys over large blobs, content deduplication, or change detection where you hash bytes directly
- Inputs are trusted, so hash flooding is not a concern

## Skip it when

- Dictionary or Set keys: Swift always runs keys through Hasher, so feeding a precomputed xxHash into hash(into:) still pays for SipHash
- Attacker-controlled keys: xxHash has no secret seed by default and can be flooded
- Integrity against tampering: use SHA-256 from CryptoKit

## How it is fast

XXH3 consumes input in wide stripes with SIMD multiply-and-accumulate (SSE2, AVX2 or NEON) and has a separate short-input path with few branches. SipHash runs several ARX rounds per 8-byte block to resist hash flooding, which costs throughput. The wrapper hands the buffer pointer straight to the C functions.

## What it costs

- Not resistant to hash flooding
- Adds a C target to the package
- Hash values are stable across runs, unlike Hasher's per-process seed, which is useful for persistence but leaks information if exposed

## Problems with the evidence

- x86 numbers (SSE2/AVX2); Apple silicon uses the NEON path, which this table does not cover
- The SipHash row is the C reference, almost certainly SipHash-2-4; Swift's Hasher runs the lighter SipHash-1-3, so the real gap to Hasher is smaller
- No measurement of the Swift wrapper or of Data/Array bridging overhead
- Very small project (6 stars)

## Evidence

<details>
<summary>6 quotes from the sources, checked 2026-10-28</summary>

> | SipHash | 64 | 3.0 GB/s | 43.2 | |
>
> — [github.com/Cyan4973/xxHash](https://github.com/Cyan4973/xxHash)

> | **XXH3** (SSE2) | 64 | 31.5 GB/s | 133.1 | |
>
> — [github.com/Cyan4973/xxHash](https://github.com/Cyan4973/xxHash)

> | **XXH3** (AVX2) | 64 | 59.4 GB/s | 133.1 | |
>
> — [github.com/Cyan4973/xxHash](https://github.com/Cyan4973/xxHash)

> | **XXH64** | 64 | 19.4 GB/s | 71.0 | |
>
> — [github.com/Cyan4973/xxHash](https://github.com/Cyan4973/xxHash)

> The benchmarked reference system uses an Intel i7-9700K CPU running Ubuntu x64 20.04.
>
> — [github.com/Cyan4973/xxHash](https://github.com/Cyan4973/xxHash)

> is a Swift wrapper around the official [xxHash](https://github.com/Cyan4973/xxHash) C library
>
> — [github.com/Jaesung-Jung/SwiftXXHash](https://github.com/Jaesung-Jung/SwiftXXHash)

</details>
