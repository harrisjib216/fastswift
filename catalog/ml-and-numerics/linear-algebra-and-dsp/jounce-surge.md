# Surge

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [ML and numerics](../README.md) › [Linear algebra and DSP](README.md)</sub>

**Tier D** (directional only) · 🟡 Holds up in part · Open source · `Swift` · `MIT` · 🔴 abandoned

> Swift wrappers over Accelerate's vDSP, vForce and BLAS; claims near-Accelerate speed but publishes no numbers against plain loops.

| | |
|---|---|
| **Beats** | Plain Swift loops over [Double] and [Float] |
| **Claimed result** | No numbers published; claims to be nearly as fast, in most cases, as using Accelerate directly |
| **Workload** | Not stated. |
| **Metric** | time |
| **Adoption** | 5.3k stars |
| **Last commit** | 2023-07-20 |
| **Platforms** | iOS, macOS, tvOS, watchOS |
| **Install** | Swift Package Manager, CocoaPods, Carthage |
| **Links** | [repository](https://github.com/Jounce/Surge) · [benchmark](https://github.com/Jounce/Surge/blob/ac638794d4b02377e3628c1c8b1e07c2a15f1d52/README.md) |

## Verdict

Surge publishes no numbers, only that it is nearly as fast as calling Accelerate directly, and its own README warns that plain loops can win on small data. Any gain is Accelerate's, and a 2025 forum re-test found vDSP only matches an optimized Swift loop on simple element-wise arithmetic. The project has had no commits since July 2023.

**Why tier D:** Directional claim only; the repository has XCTest benchmark targets but publishes no results.

## Use it when

- Older codebases that already depend on it and want Accelerate behind operator syntax

## Skip it when

- New code: Apple's own Swift vDSP and vForce overlays (iOS 13+, macOS 10.15+) cover the same ground
- Small arrays, where its README says conventional loops can be faster
- Projects that need maintained dependencies

## How it is fast

Surge is a thin layer of Swift functions and operators over vDSP, vForce, BLAS and LAPACK, so its speed is Accelerate's minus wrapper overhead. It adds matrix and vector types with operator overloads.

## What it costs

- Extra dependency over APIs Apple now ships in Swift form
- Apple platforms only

## Problems with the evidence

- No published benchmark numbers at all
- Last release 2.3.0 in November 2019; last commit July 2023

## Evidence

<details>
<summary>2 quotes from the sources, checked 2026-10-28</summary>

> Surge aims to bring Accelerate to the mainstream, making it as easy (and nearly as fast, in most cases) to perform computation over a set of numbers as for a single member.
>
> — [github.com/Jounce/Surge/blob/ac638794d4b02377e3628c1c8b1e07c2a15f1d…](https://github.com/Jounce/Surge/blob/ac638794d4b02377e3628c1c8b1e07c2a15f1d52/README.md)

> Under certain conditions, such as performing simple calculations over a small data set, Accelerate can be out-performed by conventional algorithms.
>
> — [github.com/Jounce/Surge/blob/ac638794d4b02377e3628c1c8b1e07c2a15f1d…](https://github.com/Jounce/Surge/blob/ac638794d4b02377e3628c1c8b1e07c2a15f1d52/README.md)

</details>
