# Accelerate (BLAS and LAPACK)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [ML and numerics](../README.md) › [Linear algebra and DSP](README.md)</sub>

**Tier C** (first-party numbers) · ✅ Holds up · Ships with Apple's SDKs · `C (Fortran-style BLAS/LAPACK interfaces)` · `Apple SDK` · 🟢 active

> Apple's tuned BLAS and LAPACK; Linpack over 24x faster than untuned code and SGEMM about 2.5x faster than Eigen on iPhone XS.

| | |
|---|---|
| **Beats** | Unoptimized Linpack code (no tuned BLAS); Eigen for single-precision GEMM |
| **Claimed result** | Linpack over 24 times faster than an unoptimized Linpack; single-precision GEMM almost two and a half times faster than Eigen, which tops out at about 51 gigaflops (iPhone XS); forum re-test: BLAS rendition ~4× faster than a manual loop on an M4 Mac mini |
| **Workload** | Linpack, no-holds-barred variant with unrestricted problem size; single-precision GEMM. Forum: daxpy over 800,000,000-element Double arrays. |
| **Metric** | throughput (GFLOPS) and time |
| **Hardware** | iPhone XS (A12); forum re-test on M4 Mac mini |
| **Measured** | 2019-06 |
| **Platforms** | iOS, macOS, tvOS, watchOS, visionOS |
| **Install** | built into all Apple OS versions |
| **Links** | [documentation](https://developer.apple.com/documentation/accelerate/blas) · [benchmark](https://developer.apple.com/videos/play/wwdc2019/718/) |

## Verdict

Apple showed Linpack over 24 times faster with Accelerate than an unoptimized build, and SGEMM almost 2.5 times faster than Eigen, on an iPhone XS. No newer data contradicts this. A 2025 forum user measured cblas_daxpy about 4x faster than a manual loop on an M4 Mac mini, though that comparison does different memory traffic.

**Why tier C:** First-party WWDC demo with the device stated but no problem sizes, flags or code.

## Use it when

- Matrix multiplication, factorizations and linear solvers on matrices of more than a few dozen rows
- Any dense linear algebra a Swift loop would do with nested for loops

## Skip it when

- Tiny fixed-size matrices (2x2 to 4x4), where simd types avoid call overhead
- Linux or Windows targets: use OpenBLAS or another BLAS there

## How it is fast

GEMM and the blocked LAPACK factorizations built on it are hand-tuned to each Apple CPU's caches and vector units, and on Apple silicon Accelerate can use matrix hardware that third-party code cannot reach directly. The routines also use multiple cores without extra code.

## What it costs

- The newer LAPACK interfaces need the ACCELERATE_NEW_LAPACK (and ILP64) defines
- C-style API with column-major conventions

## Problems with the evidence

- 2019 demo on iPhone XS; Apple silicon Macs and current OS releases were not covered
- The unoptimized Linpack baseline is not a naive Swift triple loop, and Eigen's build flags were not stated
- The forum ~4x figure compares daxpy (two arrays, in place) with a three-array loop, so the work differs

## Evidence

<details>
<summary>5 quotes from the sources, checked 2026-10-28</summary>

> At the top in orange, we're going to run an unoptimized Linpack.
>
> — [developer.apple.com/videos/play/wwdc2019/718/](https://developer.apple.com/videos/play/wwdc2019/718/)

> We can see that by using the Accelerate framework, we are over 24 times faster.
>
> — [developer.apple.com/videos/play/wwdc2019/718/](https://developer.apple.com/videos/play/wwdc2019/718/)

> Eigen tops out at about 51 gigaflops.
>
> — [developer.apple.com/videos/play/wwdc2019/718/](https://developer.apple.com/videos/play/wwdc2019/718/)

> We can see that the Accelerate framework is almost two and a half times faster than Eigen on the same platform.
>
> — [developer.apple.com/videos/play/wwdc2019/718/](https://developer.apple.com/videos/play/wwdc2019/718/)

> I find that the BLAS rendition was ~4× faster on my M4 Mac mini.
>
> — [forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-…](https://forums.swift.org/t/performance-of-accelerate-framework-vs-swift-on-apple-silicon/80919)

</details>
