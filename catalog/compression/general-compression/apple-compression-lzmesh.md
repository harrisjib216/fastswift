# Compression framework (LZMESH)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Compression](../README.md) › [General-purpose compression](README.md)</sub>

**Tier C** (first-party numbers) · ✅ Holds up · Ships with Apple's SDKs · `C` · `Apple SDK` · 🟢 active

> Apple's OS 27 general-purpose codec, documented as decoding 3.5x faster than zlib with a better ratio than zlib or LZFSE.

| | |
|---|---|
| **Beats** | Compression framework COMPRESSION_ZLIB and COMPRESSION_LZFSE |
| **Claimed result** | Decodes 3.5x faster than COMPRESSION_ZLIB on Apple silicon; encodes significantly faster than zlib or LZFSE (no number given) |
| **Workload** | Not stated |
| **Metric** | throughput |
| **Hardware** | Apple silicon (model not stated) |
| **OS** | iOS 27 / macOS 27 family |
| **Measured** | 2026 |
| **Platforms** | iOS 27+, iPadOS 27+, macOS 27+, tvOS 27+, watchOS 27+, visionOS 27+ |
| **Install** | built into OS 27 releases (Compression framework, buffer API only) |
| **Links** | [documentation](https://developer.apple.com/documentation/compression/compression_lzmesh) · [benchmark](https://developer.apple.com/documentation/compression/compression_lzmesh) |

## Verdict

Apple states LZMESH decodes 3.5x faster than zlib on Apple silicon with a better ratio than zlib and LZFSE. No independent measurement exists yet for this OS 27 algorithm, and nothing contradicts the claim.

**Why tier C:** First-party documentation claim with no data set, device or method given.

## Use it when

- Apple-only payloads with an OS 27 minimum deployment target
- In-memory buffers where decode speed matters (assets, caches)

## Skip it when

- Streaming input: LZMESH is buffer API only
- Any reader on an older OS or a non-Apple platform

## How it is fast

Apple describes LZ77 matching with length-limited Huffman coding and a lazy match parser. Length-limited codes allow small, fixed decode tables, and the decoder needs only 64 KB of scratch memory. Apple positions it as the replacement for both LZFSE and zlib on its platforms.

## What it costs

- Requires OS 27 on every device that decodes the data
- Buffer API only, no compression_stream support

## Problems with the evidence

- No published benchmark data, corpus or device; documentation claim only
- Brand-new format; no third-party implementations or measurements yet

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> LZMESH decodes 3.5x faster than
>
> — [developer.apple.com/tutorials/data/documentation/compression/compre…](https://developer.apple.com/tutorials/data/documentation/compression/compression_lzmesh.json)

> while encoding significantly faster than either.
>
> — [developer.apple.com/tutorials/data/documentation/compression/compre…](https://developer.apple.com/tutorials/data/documentation/compression/compression_lzmesh.json)

> The decoder requires only 64 KB of scratch memory, making it well suited for memory-constrained environments.
>
> — [developer.apple.com/tutorials/data/documentation/compression/compre…](https://developer.apple.com/tutorials/data/documentation/compression/compression_lzmesh.json)

> algorithm is available in version 27 or later of Apple operating systems.
>
> — [developer.apple.com/tutorials/data/documentation/compression/compre…](https://developer.apple.com/tutorials/data/documentation/compression/compression_lzmesh.json)

</details>
