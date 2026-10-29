# swift-extras-base64

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md) › [Base64 and encoding](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Open source · `Swift` · `Apache-2.0` · 🟢 active

> Foundation-free Base64 that was 3-10x faster than 2020 Foundation; its author has since brought the approach into Foundation.

| | |
|---|---|
| **Beats** | Foundation base64EncodedString / Data(base64Encoded:) with Swift 5.3 (2020), macOS and Linux |
| **Claimed result** | macOS, Swift 5.3: encode 0.66s vs 2.08s (3x), decode 0.54s vs 2.15s (4x). Linux: encode 0.27s vs 1.01s (3x), decode 0.41s vs 5.5s (~10x). |
| **Workload** | Encoding and decoding the base64 form of bytes 0x00-0xFF one million times |
| **Metric** | time |
| **Hardware** | MacBook Pro 16-inch (late 2019), 2.4 GHz 8-core Intel Core i9 |
| **OS** | macOS and Linux (versions not stated) |
| **Toolchain** | Swift 5.3 |
| **Measured** | 2020-10 |
| **Adoption** | 96 stars |
| **Last commit** | 2026-09-18 |
| **Platforms** | macOS, Linux (no Foundation dependency) |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/swift-extras/swift-extras-base64) · [benchmark](https://github.com/swift-extras/swift-extras-base64/blob/main/README.md) |

## Verdict

The 3-4x macOS and 3-10x Linux wins were measured against the 2020 Foundation. In February 2025 the same author merged a faster Swift Base64 into swift-foundation that measured 5x-7.5x faster than the Foundation of that time on 1 MB inputs, so the gap against current Foundation has likely closed; no direct comparison is published.

**Why tier A:** The performance test source is in the repo and the README states the Intel Core i9 MacBook Pro and Swift 5.3; build flags are not stated.

## Use it when

- Foundation-free targets (Embedded or minimal Linux images) that need Base64
- Toolchains or OS versions whose Foundation predates the 2025 swift-foundation Base64 rewrite

## Skip it when

- Current Foundation already uses the same author's faster implementation

## How it is fast

It maps bytes to characters and back with Chromium's precomputed lookup tables (from Lemire's fastbase64) in tight loops over unsafe buffers, without Foundation's NSData bridging.

## What it costs

- Separate API from Foundation's Data methods
- Uses unsafe Swift internally

## Problems with the evidence

- Numbers are from Swift 5.3 on a 2019 Intel Mac; build configuration not stated.
- Baseline replaced: swift-foundation PRs #1157 and #1160 (merged February 2025) rewrote Foundation's Base64 in Swift, and October 2026 follow-ups made it faster again.
- No line-break handling when decoding or encoding.

## Evidence

<details>
<summary>11 quotes from the sources, checked 2026-10-28</summary>

> Tests were run on a MacBook Pro (16-inch, late 2019). Processor: 2.4 GHz 8-Core Intel Core i9.
>
> — [github.com/swift-extras/swift-extras-base64/blob/main/README.md](https://github.com/swift-extras/swift-extras-base64/blob/main/README.md)

> #### macOS - swift 5.3
>
> — [github.com/swift-extras/swift-extras-base64/blob/main/README.md](https://github.com/swift-extras/swift-extras-base64/blob/main/README.md)

> | Foundation   | 2.08s | 2.15s |
>
> — [github.com/swift-extras/swift-extras-base64/blob/main/README.md](https://github.com/swift-extras/swift-extras-base64/blob/main/README.md)

> | swift-extras-base64 | 0.66s | 0.54s |
>
> — [github.com/swift-extras/swift-extras-base64/blob/main/README.md](https://github.com/swift-extras/swift-extras-base64/blob/main/README.md)

> | Speedup | 3x | 4x |
>
> — [github.com/swift-extras/swift-extras-base64/blob/main/README.md](https://github.com/swift-extras/swift-extras-base64/blob/main/README.md)

> | Foundation   | 1.01s | 5.5s |
>
> — [github.com/swift-extras/swift-extras-base64/blob/main/README.md](https://github.com/swift-extras/swift-extras-base64/blob/main/README.md)

> | swift-extras-base64 | 0.27s | 0.41s |
>
> — [github.com/swift-extras/swift-extras-base64/blob/main/README.md](https://github.com/swift-extras/swift-extras-base64/blob/main/README.md)

> | Speedup | 3x | **~10x** |
>
> — [github.com/swift-extras/swift-extras-base64/blob/main/README.md](https://github.com/swift-extras/swift-extras-base64/blob/main/README.md)

> This PR: 414μs (7x faster)
>
> — [github.com/swiftlang/swift-foundation/pull/1157](https://github.com/swiftlang/swift-foundation/pull/1157)

> This PR: 405μs (7.5x faster)
>
> — [github.com/swiftlang/swift-foundation/pull/1160](https://github.com/swiftlang/swift-foundation/pull/1160)

> This PR: 406μs (5.2x faster)
>
> — [github.com/swiftlang/swift-foundation/pull/1160](https://github.com/swiftlang/swift-foundation/pull/1160)

</details>
