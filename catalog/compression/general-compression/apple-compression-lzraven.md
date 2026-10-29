# Compression framework (LZRAVEN)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Compression](../README.md) › [General-purpose compression](README.md)</sub>

**Tier C** (first-party numbers) · ✅ Holds up · Ships with Apple's SDKs · `C` · `Apple SDK` · 🟢 active

> Apple's OS 27 high-ratio codec, documented as decoding 3x faster than LZMA at a similar or slightly better ratio.

| | |
|---|---|
| **Beats** | Compression framework COMPRESSION_LZMA (NSData.compressed(using: .lzma)) |
| **Claimed result** | Decodes 3x faster than COMPRESSION_LZMA on Apple silicon; encodes faster than LZMA (no number given) |
| **Workload** | Not stated |
| **Metric** | throughput |
| **Hardware** | Apple silicon (model not stated) |
| **OS** | iOS 27 / macOS 27 family |
| **Measured** | 2026 |
| **Platforms** | iOS 27+, iPadOS 27+, macOS 27+, tvOS 27+, watchOS 27+, visionOS 27+ |
| **Install** | built into OS 27 releases (Compression framework, buffer API only) |
| **Links** | [documentation](https://developer.apple.com/documentation/compression/compression_lzraven) · [benchmark](https://developer.apple.com/documentation/compression/compression_lzraven) |

## Verdict

Apple states LZRAVEN decodes 3x faster than LZMA on Apple silicon at a slightly better ratio. It is new in OS 27, no independent numbers exist, and nothing contradicts the claim.

**Why tier C:** First-party documentation claim with no data set, device or method given.

## Use it when

- Apple-only payloads compressed once and decoded often, where LZMA's ratio is wanted but its decode time is too slow
- OS 27 minimum deployment targets

## Skip it when

- Data that must be readable by xz tools or non-Apple platforms
- Streaming input: buffer API only
- Devices on OS versions before 27

## How it is fast

Apple describes LZ77 with an 8 MB dictionary, context-modeled entropy coding and near-optimal parsing, with a decoder that uses vector units to process several symbols per operation. LZMA's range decoder handles one bit at a time with serial dependencies, which limits its decode speed.

## What it costs

- Requires OS 27 on every decoding device
- Buffer API only

## Problems with the evidence

- No published benchmark data, corpus or device
- LZMA is not the default most apps use; compare against zlib or LZFSE if that is your current choice

## Evidence

<details>
<summary>3 quotes from the sources, checked 2026-10-28</summary>

> while decoding 3x faster on Apple silicon, where the decoder leverages vector units to process multiple symbols per operation.
>
> — [developer.apple.com/tutorials/data/documentation/compression/compre…](https://developer.apple.com/tutorials/data/documentation/compression/compression_lzraven.json)

> LZRAVEN uses an 8 MB dictionary and encodes faster than
>
> — [developer.apple.com/tutorials/data/documentation/compression/compre…](https://developer.apple.com/tutorials/data/documentation/compression/compression_lzraven.json)

> algorithm is available in version 27 or later of Apple operating systems.
>
> — [developer.apple.com/tutorials/data/documentation/compression/compre…](https://developer.apple.com/tutorials/data/documentation/compression/compression_lzraven.json)

</details>
