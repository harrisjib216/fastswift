# LASwift

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [ML and numerics](../README.md) › [Linear algebra and DSP](README.md)</sub>

**Tier B** (independent measurement) · 🟡 Holds up in part · Open source · `Swift` · `BSD-3-Clause` · 🔴 abandoned

> Matlab-style vector and matrix library over Accelerate; a 2017 Swift 3 benchmark puts it near NumPy, with no Swift-loop baseline.

| | |
|---|---|
| **Beats** | Plain Swift loops; the only benchmark compares against NumPy, Octave, hmatrix and gonum |
| **Claimed result** | 1000x1000 matrices: multiply 30 ms vs NumPy 37.01 ms; invert 39 ms vs 84.74 ms; but sum by columns 13 ms vs 0.692 ms and transpose reported as 11e9 ns |
| **Workload** | 1000x1000 random matrices: creation, inversion, Cholesky, multiply, transpose, sigmoid, ReLU, row and column sums and argmax; 1,000,000-element dot product. |
| **Metric** | time |
| **Toolchain** | Apple Swift 3.0.2; NumPy 1.11.1 on Python 3.5.2 |
| **Measured** | 2017-08 |
| **Adoption** | 147 stars |
| **Last commit** | 2023-01-09 |
| **Platforms** | macOS 10.13+, iOS 12+, tvOS 12+, watchOS 6+ |
| **Install** | Swift Package Manager, CocoaPods, Carthage |
| **Links** | [repository](https://github.com/AlexanderTar/LASwift) · [benchmark](https://github.com/Alexander-Ignatyev/linalg-benchmarks/blob/d2abf7695d7452752d6f86acfa7bdb6b721c4d40/README.md) |

## Verdict

The only benchmark (2017, LASwift 0.1.2 on Swift 3.0.2) compares against other languages' libraries, not Swift loops. It shows LASwift level with or ahead of NumPy on multiply and inversion but about 19 times slower on column sums, and its transpose figure of 11e9 ns looks like a measurement error. The project has had no commits since January 2023.

**Why tier B:** Third-party benchmark repository with code for every library, written by another library's author, but no hardware or build flags stated.

## Use it when

- Porting Matlab or hmatrix-style code to Swift where matrix multiply and solves dominate

## Skip it when

- Column-wise reductions, which were about 19 times slower than NumPy
- Projects that need a maintained dependency or current Swift performance data

## How it is fast

LASwift maps vector and matrix operations onto LAPACK, BLAS and vDSP calls from Accelerate, so multiply, inversion and decompositions run in Apple's tuned routines. Operations without a direct Accelerate call, such as column-wise reductions, fall back to slower paths.

## What it costs

- Matlab-style API with its own Vector and Matrix types
- Apple platforms only (Accelerate)

## Problems with the evidence

- Swift 3.0.2 era numbers; the compiler and Accelerate have changed a great deal since
- No hardware stated
- Transpose result of 11e9 ns is implausible next to the other columns
- Baselines are other languages' libraries, not Swift loops

## Evidence

<details>
<summary>7 quotes from the sources, checked 2026-10-28</summary>

> * LASwift: 0.1.2 (Apple Swift 3.0.2)
>
> — [github.com/Alexander-Ignatyev/linalg-benchmarks/blob/d2abf7695d7452…](https://github.com/Alexander-Ignatyev/linalg-benchmarks/blob/d2abf7695d7452752d6f86acfa7bdb6b721c4d40/README.md)

> 6. Matrix (1000x1000 <> 1000x1000) multiply.
>
> — [github.com/Alexander-Ignatyev/linalg-benchmarks/blob/d2abf7695d7452…](https://github.com/Alexander-Ignatyev/linalg-benchmarks/blob/d2abf7695d7452752d6f86acfa7bdb6b721c4d40/README.md)

> | 2. Invert matrix | 84.85 ms  | 84.74 ms | 57.00 ms | 364.49 ms | 39 ms |
>
> — [github.com/Alexander-Ignatyev/linalg-benchmarks/blob/d2abf7695d7452…](https://github.com/Alexander-Ignatyev/linalg-benchmarks/blob/d2abf7695d7452752d6f86acfa7bdb6b721c4d40/README.md)

> | 6. Matrix multiply | 32.78 ms | 37.01 ms | 36.38 ms | 185.65 ms | 30 ms |
>
> — [github.com/Alexander-Ignatyev/linalg-benchmarks/blob/d2abf7695d7452…](https://github.com/Alexander-Ignatyev/linalg-benchmarks/blob/d2abf7695d7452752d6f86acfa7bdb6b721c4d40/README.md)

> | 10. sum by columns | 14.690 ms (0.539 ms) | 0.692 ms | 1.049 ms | | 13 ms |
>
> — [github.com/Alexander-Ignatyev/linalg-benchmarks/blob/d2abf7695d7452…](https://github.com/Alexander-Ignatyev/linalg-benchmarks/blob/d2abf7695d7452752d6f86acfa7bdb6b721c4d40/README.md)

> | 5. Matrix transpose | 41.80 ns | 262.0 ns | 22,860 ns | 0.65 ns | 11e9 ns |
>
> — [github.com/Alexander-Ignatyev/linalg-benchmarks/blob/d2abf7695d7452…](https://github.com/Alexander-Ignatyev/linalg-benchmarks/blob/d2abf7695d7452752d6f86acfa7bdb6b721c4d40/README.md)

> LASwift is using high-performant calculations provided by LAPACK, BLAS and vDSP through Apple Accelerate framework.
>
> — [github.com/AlexanderTar/LASwift/blob/b0bdd4869e8aa2de37414b0cc2c4b7…](https://github.com/AlexanderTar/LASwift/blob/b0bdd4869e8aa2de37414b0cc2c4b739225b643f/README.md)

</details>
