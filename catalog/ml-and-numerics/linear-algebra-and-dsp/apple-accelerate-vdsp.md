# Accelerate (vDSP and vForce element-wise math)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [ML and numerics](../README.md) › [Linear algebra and DSP](README.md)</sub>

**Tier C** (first-party numbers) · 🟡 Holds up in part · Ships with Apple's SDKs · `C (Swift overlay)` · `Apple SDK` · 🟢 active

> Apple's vectorized array math; claimed 3-10x over scalar loops, but optimized Swift loops match it on simple element-wise arithmetic.

| | |
|---|---|
| **Beats** | Plain Swift for loops and map over [Double] and [Float] |
| **Claimed result** | vDSP approximately three times faster than a for loop and approximately four times faster than a scalar map for Double-to-UInt16 conversion; vForce square root up to 10 times faster than map. Independent re-test of vDSP.add: 1.93 seconds vs 1.96 seconds for a plain Swift loop (n = 1_000_000, m = 10_000). Times rounded to three significant figures from the raw results. |
| **Workload** | WWDC: element-wise arithmetic on four arrays, type conversion and square root over unstated array sizes. Forum: element-wise addition of two 1,000,000-element Double arrays repeated 10,000 times after warm-up. |
| **Metric** | time |
| **Hardware** | WWDC: not stated; forum re-test: MacBook Air 15-inch, M4, 2025 |
| **OS** | Forum re-test: macOS Sequoia 15.5 |
| **Toolchain** | Forum re-test: Apple Swift 6.1.2, swiftc -Ounchecked |
| **Measured** | 2019-06 |
| **Platforms** | iOS 13+, macOS 10.15+ for the Swift vDSP API; C API on all Apple platforms |
| **Install** | built into iOS 13+ and macOS 10.15+ |
| **Links** | [documentation](https://developer.apple.com/documentation/accelerate/vdsp) · [benchmark](https://developer.apple.com/videos/play/wwdc2019/718/) |

## Verdict

Apple's 2019 claims of large speedups over scalar loops do not hold for simple arithmetic in optimized builds. A 2025 Swift Forums test on an M4 timed vDSP.add and a plain -Ounchecked loop within 2% of each other, and the generated assembly showed the loop auto-vectorized. The re-test covered only addition; vForce transcendental functions and debug builds were not re-measured.

**Why tier C:** First-party WWDC claims with no device, array size or build settings stated for the vDSP and vForce examples.

## Use it when

- Debug builds or code that must stay fast without the optimizer
- Transcendental functions over large arrays (exp, log, sin, sqrt in vForce)
- FFT, convolution, strided access and type conversion with rounding

## Skip it when

- Simple element-wise add or multiply in release builds, where the compiler's auto-vectorized loop runs at the same speed
- Very small arrays, where call overhead can make a plain loop faster
- Linux targets: Accelerate is Apple-only

## How it is fast

vDSP and vForce are hand-tuned SIMD routines for each Apple CPU, so the vector code is right even in debug builds and on new chips. Since the Swift optimizer auto-vectorizes simple loops in release builds, the advantage is concentrated in work the compiler cannot vectorize, such as transcendental functions, conversions with rounding, FFTs and convolutions.

## What it costs

- Pointer-based C API; the Swift overlay allocates a new result array unless you pass existing storage
- Apple platforms only

## Problems with the evidence

- WWDC numbers have no device, array size or build settings
- The forum arrays are far larger than the L1 cache, so the test is memory-bound, as a numerics developer in the thread pointed out; L1-sized arrays were not re-tested
- Only addition was re-tested; the vForce and conversion speedups were not independently re-measured

## Evidence

<details>
<summary>12 quotes from the sources, checked 2026-10-28</summary>

> Using vDSP is approximately three times faster than the four loop.
>
> — [developer.apple.com/videos/play/wwdc2019/718/](https://developer.apple.com/videos/play/wwdc2019/718/)

> This example converts an array containing double precision values to 16-bit unsigned integer values rounding toward zero.
>
> — [developer.apple.com/videos/play/wwdc2019/718/](https://developer.apple.com/videos/play/wwdc2019/718/)

> In this example, vDSP is approximately four times faster than the previous scalar implementation.
>
> — [developer.apple.com/videos/play/wwdc2019/718/](https://developer.apple.com/videos/play/wwdc2019/718/)

> vForce provides a vectorized function to calculate the square roots that in some situations can be up to 10 times faster than the scalar implementation.
>
> — [developer.apple.com/videos/play/wwdc2019/718/](https://developer.apple.com/videos/play/wwdc2019/718/)

> Here are the benchmark results for n = 1_000_000 and m = 10_000
>
> — [forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-…](https://forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-apple-silicon/80919)

> The Swift and vDSP code performs about the same.
>
> — [forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-…](https://forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-apple-silicon/80919)

> Accelerate vDSP first 4.38 last 4.38 1.93274625 seconds
>
> — [forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-…](https://forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-apple-silicon/80919)

> Swift first 4.38 last 4.38 1.95879725 seconds
>
> — [forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-…](https://forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-apple-silicon/80919)

> So it is indeed autovectorized and unrolled 2x
>
> — [forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-…](https://forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-apple-silicon/80919)

> MacBook Air 15-inch, M4, 2025
>
> — [forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-…](https://forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-apple-silicon/80919)

> Apple Swift version 6.1.2
>
> — [forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-…](https://forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-apple-silicon/80919)

> If your buffers are much bigger than that, you are only measuring the speed of the cache hierarchy, which is independent of the implementation used.
>
> — [forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-…](https://forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-apple-silicon/80919)

</details>
