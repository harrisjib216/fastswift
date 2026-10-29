# Matft

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [ML and numerics](../README.md) › [Linear algebra and DSP](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Open source · `Swift` · `BSD-3-Clause` · 🟢 active

> NumPy-style arrays for Swift on Accelerate; 10-33x faster than NumPy on sin and power, slower on sorting and comparisons.

| | |
|---|---|
| **Beats** | NumPy 2.0.2 on the same Mac (the published comparison); no plain-Swift-loop baseline is published |
| **Claimed result** | vs NumPy: sin 290μs vs 2.80ms (0.10x), power 125μs vs 4.06ms (0.03x), rfft with vDSP 629μs vs 1.45ms (0.43x), inv 490μs vs 506μs (0.97x); slower on argsort 7.02ms vs 2.41ms (2.91x), MfArray(nested) 3.95ms vs 1.19ms (3.31x), default rfft 1.98ms vs 1.43ms (1.39x) |
| **Workload** | 1,000,000-element Int and Double arrays shaped 10x10x10x10x10x10, including transposed views; 1024x1024 Float signal for rfft; 256x256 Double matrix inverse; 1000x100 nested [[Float]] for array creation. |
| **Metric** | time |
| **Hardware** | Apple M5 |
| **OS** | macOS 26.5.1 |
| **Toolchain** | Swift 6.2.3, swift test -c release (XCTest measure, median after warm-up); NumPy 2.0.2 on Python 3.9.6 |
| **Measured** | 2026-09-27 |
| **Adoption** | 147 stars |
| **Last commit** | 2026-09-27 |
| **Platforms** | macOS 10.13+, iOS 12+ (tvOS, watchOS and visionOS untested) |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/jjjkkkjjj/Matft) · [benchmark](https://github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61f811d/website/docs/performance.md) |

## Verdict

Release-build benchmarks on an M5 show Matft well ahead of NumPy on element-wise math and reductions and level on matrix inversion. It is slower on argsort, on building arrays from nested Swift arrays and on the default rfft. The baseline is NumPy, not the plain Swift loops a Swift developer would otherwise write.

**Why tier A:** Benchmark script and XCTest performance tests are in the repository, with hardware, macOS, Swift and NumPy versions and the release-build command stated.

## Use it when

- Porting NumPy code to Swift, especially element-wise math, reductions and FFT with the vDSP flag
- Audio and image preprocessing for on-device models (STFT, mel spectrograms, OpenCV-compatible ops)

## Skip it when

- Sorting- or comparison-heavy code, where it was 1.2x to 3x slower than NumPy
- Building arrays from nested Swift arrays in hot paths (3.31x slower than NumPy)
- Simple loops over a flat [Float]: no data shows it beating a plain optimized Swift loop

## How it is fast

MfArray operations dispatch to vDSP, vForce, BLAS and LAPACK from Accelerate on contiguous buffers, so element-wise math and reductions run as vectorized library calls. Operations without a matching Accelerate routine, such as argsort and boolean comparisons, use Swift code and lose to NumPy's C loops.

## What it costs

- Its own MfArray type instead of [Double] or [Float]
- Apple platforms only (Accelerate)

## Problems with the evidence

- Benchmarks are by the library's author
- NumPy timings include Python call overhead, which favors Matft on small operations
- No comparison against hand-written Swift loops

## Evidence

<details>
<summary>9 quotes from the sources, checked 2026-10-28</summary>

> | `let _ = Matft.math.sin(a)` | `290μs` | `np.sin(a)` | `2.80ms` | 0.10x |
>
> — [github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61…](https://github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61f811d/website/docs/performance.md)

> | `let _ = Matft.math.power(bases: ad, exponents: 2)` | `125μs` | `np.power(ad, 2)` | `4.06ms` | 0.03x |
>
> — [github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61…](https://github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61f811d/website/docs/performance.md)

> | `let _ = Matft.fft.rfft(signal, vDSP: true)` | `629μs` | `np.fft.rfft(signal)` | `1.45ms` | 0.43x |
>
> — [github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61…](https://github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61f811d/website/docs/performance.md)

> | `let _ = try! Matft.linalg.inv(m)` | `490μs` | `np.linalg.inv(m)` | `506μs` | 0.97x |
>
> — [github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61…](https://github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61f811d/website/docs/performance.md)

> | `let _ = aneg.argsort(axis: -1)` | `7.02ms` | `np.argsort(aneg, axis=-1)` | `2.41ms` | **2.91x** |
>
> — [github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61…](https://github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61f811d/website/docs/performance.md)

> | `let _ = MfArray(nested)` | `3.95ms` | `np.array(nested, dtype=np.float32)` | `1.19ms` | **3.31x** |
>
> — [github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61…](https://github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61f811d/website/docs/performance.md)

> | `let _ = Matft.fft.rfft(signal)` | `1.98ms` | `np.fft.rfft(signal)` | `1.43ms` | **1.39x** |
>
> — [github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61…](https://github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61f811d/website/docs/performance.md)

> Measured on Apple M5, macOS 26.5.1, Swift version 6.2.3, Python 3.9.6, numpy 2.0.2 (Matft `1.0.0`, 2026-09-27).
>
> — [github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61…](https://github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61f811d/website/docs/performance.md)

> Matft: median of XCTest `measure {}` in release build (`swift test -c release`)
>
> — [github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61…](https://github.com/jjjkkkjjj/Matft/blob/618dcfcbd0674bc4081b582a5b1380bec61f811d/website/docs/performance.md)

</details>
