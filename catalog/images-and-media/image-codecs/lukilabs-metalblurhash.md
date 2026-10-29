# MetalBlurHash

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Images and media](../README.md) › [Image codecs](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Open source · `Swift + Metal` · `MIT` · 🟡 stale

> Metal port of BlurHash; decodes a 3840 x 2560 placeholder 250x faster than Wolt's CPU code on an M1 Max.

| | |
|---|---|
| **Beats** | Wolt's reference BlurHash Swift encoder and decoder (CPU) |
| **Claimed result** | Decode 3.267s vs 0.013s (250×); encode 32.212s vs 0.154s (210×). |
| **Workload** | Decode a 9 x 9-component BlurHash into a 3840 x 2560 image; encode a 3648 x 5472 image with 9 x 9 components. |
| **Metric** | time |
| **Hardware** | Apple M1 Max |
| **Toolchain** | Release test configuration in the shared Xcode scheme; Xcode version not stated |
| **Measured** | 2025-06-04 |
| **Adoption** | 73 stars |
| **Last commit** | 2025-06-04 |
| **Platforms** | iOS 15+, Mac Catalyst 15+, visionOS 1+ |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/lukilabs/MetalBlurHash) · [benchmark](https://github.com/lukilabs/MetalBlurHash#performance-benchmarks) |

## Verdict

The 250x decode figure (3.267 s to 0.013 s) holds for a 3840 x 2560 output on an M1 Max in a Release build, but the README calls its numbers illustrative, and placeholders are normally decoded at a few dozen pixels and scaled up, where GPU dispatch overhead would eat much of the gap. No small-size or iPhone numbers are published.

**Why tier A:** Public XCTest performance tests and test plan in the repository, Release test configuration in the shared scheme, and M1 Max hardware stated.

## Use it when

- Generating BlurHash strings from full-resolution photos on device, where encoding took 32 s on the CPU
- Decoding placeholders at or near screen resolution

## Skip it when

- Decoding small placeholders (for example 32 x 32) and scaling them up, as the BlurHash authors recommend: no numbers show a GPU win there
- Widgets and other background contexts, where GPU command buffers are refused
- Code that cannot handle a nil image when Metal initialization fails

## How it is fast

Decoding BlurHash means summing up to 81 cosine basis functions at every output pixel. MetalBlurHash runs that per-pixel sum as a Metal compute kernel, so pixels are evaluated in parallel on the GPU instead of in nested Swift loops on one CPU core. Encoding moves the per-component sums over the source image to the GPU the same way.

## What it costs

- Requires Metal; returns nil if Metal setup fails
- No GPU work from widgets or the background

## Problems with the evidence

- Measured on a Mac (M1 Max), not an iPhone
- The README calls the times and multipliers 'illustrative'
- Craft's blog post on the same benchmark prints the decode speedup as 25x, a typo for 250x (3.267 / 0.013)
- One output size per task; no curve across sizes

## Evidence

<details>
<summary>5 quotes from the sources, checked 2026-10-28</summary>

> Below are indicative benchmarks measured on an M1 Max.
>
> — [github.com/lukilabs/MetalBlurHash/blob/main/readme.md](https://github.com/lukilabs/MetalBlurHash/blob/main/readme.md)

> | Encode | 32.212s | 0.154s | 210× |
>
> — [github.com/lukilabs/MetalBlurHash/blob/main/readme.md](https://github.com/lukilabs/MetalBlurHash/blob/main/readme.md)

> | Decode | 3.267s | 0.013s | 250× |
>
> — [github.com/lukilabs/MetalBlurHash/blob/main/readme.md](https://github.com/lukilabs/MetalBlurHash/blob/main/readme.md)

> | Decode | 3840 × 2560 | 9 × 9 |
>
> — [github.com/lukilabs/MetalBlurHash/blob/main/readme.md](https://github.com/lukilabs/MetalBlurHash/blob/main/readme.md)

> (Times and multipliers are illustrative. Actual performance will depend on your hardware and usage patterns.)
>
> — [github.com/lukilabs/MetalBlurHash/blob/main/readme.md](https://github.com/lukilabs/MetalBlurHash/blob/main/readme.md)

</details>
