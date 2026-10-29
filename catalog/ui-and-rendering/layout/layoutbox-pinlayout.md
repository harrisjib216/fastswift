# PinLayout

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [UI and rendering](../README.md) › [Layout](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Open source · `Swift` · `MIT` · 🟡 stale

> Frame-based layout DSL for UIKit that runs about 3x faster than Auto Layout on current iPhones in LayoutFrameworkBenchmark.

| | |
|---|---|
| **Beats** | Auto Layout (NSLayoutConstraint) laying out self-sizing UICollectionView cells |
| **Claimed result** | README: 'between 8x and 12x faster than auto layout' (iPhone 5S to X). Current data, 100 cells: iPhone 16 0.02 s vs 0.0595 s Auto Layout (3.0x, derived from page data); iPhone 13 Pro iOS 18.6 0.0191 s vs 0.064 s (3.4x, derived from page data); manual frame layout 0.0208 s and 0.0216 s on the same devices. Older runs' 'PinLayout vs Autolayout Ratio' column: 8.07 (iPhone X/8, iOS 11.3), 10 (iPhone 5S), 5.78 (iPhone 7, iOS 12.1). Times rounded to three significant figures from the raw results. |
| **Workload** | Lay out a feed-style UICollectionView cell (labels, images, buttons) for 10 to 100 cells per pass; time is seconds for vc.view.layoutIfNeeded() on the main thread. |
| **Metric** | time |
| **Hardware** | iPhone 16; iPhone 13 Pro; older runs on iPhone 5S, 6, 6S, 7, X, XS |
| **OS** | iOS 18.6 (iPhone 13 Pro); iOS 11.0 to 12.1 for older runs; iPhone 16 OS not stated |
| **Toolchain** | Release mode per benchmark README; Xcode 16 required by current project; exact Swift version not stated |
| **Measured** | 2025-08 |
| **Adoption** | 2.4k stars |
| **Last commit** | 2025-07-23 |
| **Platforms** | iOS 9+, tvOS 9+, macOS 10.9+ |
| **Install** | Swift Package Manager, CocoaPods |
| **Links** | [repository](https://github.com/layoutBox/PinLayout) · [benchmark](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/edit#gid=1032991425) |

## Verdict

PinLayout is still faster than Auto Layout and matches hand-written frame code, but the README's 8x-12x figure comes from iPhone 5S to X runs on iOS 11. The same benchmark's 2025 runs show about 3.0x on iPhone 16 and 3.4x on iPhone 13 Pro (iOS 18.6).

**Why tier A:** Public LayoutFrameworkBenchmark app with per-device raw data, device and iOS version stated, runs done in Release mode; the authors of PinLayout also maintain the benchmark.

## Use it when

- Complex self-sizing cells in long UICollectionView or UITableView feeds where Auto Layout shows up in Time Profiler
- Teams already writing manual frame code who want a shorter, chainable syntax at the same speed

## Skip it when

- SwiftUI screens, where it does not apply
- Simple or static screens where Auto Layout cost is not measurable
- Codebases that rely on Interface Builder, intrinsic content size propagation or the system's automatic RTL and Dynamic Type handling through constraints

## How it is fast

PinLayout sets each view's frame directly inside layoutSubviews, the same work hand-written frame code does. There is no constraint engine, so no system of linear equations is built, solved or updated when content changes. Cost grows with the number of views, not with the number of relationships between them.

## What it costs

- You write layout code by hand in layoutSubviews and handle sizeThatFits yourself.
- No Interface Builder support and no constraint-based animation.

## Problems with the evidence

- The 8x-12x headline is from iPhone 5S to X on iOS 11; on iPhone 16 and iPhone 13 Pro (iOS 18.6) the gap is about 3x.
- The PinLayout author also maintains LayoutFrameworkBenchmark, so the benchmark is not independent.
- The 'Compare all' sheet mixes 90-cell and 100-cell values across devices; ratios here use the per-device sheets at 100 cells.
- Single synthetic cell design; the README says the layouts do not match pixel for pixel across frameworks.
- Last commit 2025-07-23; no release since.

## Evidence

<details>
<summary>12 quotes from the sources, checked 2026-10-28</summary>

> PinLayout are faster or equal to manual layouting, and **between 8x and 12x faster than auto layout**, and this for all types of iPhone (5S/6/6S/7/8/X)
>
> — [github.com/layoutBox/PinLayout/blob/master/README.md](https://github.com/layoutBox/PinLayout/blob/master/README.md)

> ,iPhone16,iPhone 13 Pro (iOS 18.6),iPhone XS/ iOS 12,iPhone X/8 (iOS 11.3),iPhone 7 (iOS 12.1),iPhone 7 (iOS 11.3),iPhone 6S (iOS 11.3),iPhone 6 (iOS 11.0),iPhone 5S
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1032991425)

> PinLayout vs Autolayout Ratio,,,7.745748231,8.066571247,5.782034008,8.049055752,6.836422597,7.630711588,10.00596102
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1032991425)

> Auto Layout,0.0595,0.064,0.1181380086
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1032991425)

> Number of Cells in a UICollectionView ,10,20,30,40,50,60,70,80,90,100
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1326117825)

> Auto Layout,0.0094,0.0146,0.02,0.0261,0.031,0.0378,0.0421,0.047,0.0538,0.0595
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1326117825)

> Manual Layout ,0.0039,0.0059,0.0077,0.0096,0.0116,0.0132,0.0151,0.0172,0.0189,0.0208
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1326117825)

> PinLayout 1.10,0.0036,0.0053,0.0072,0.009,0.0107,0.0126,0.0144,0.0162,0.0185,0.02
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1326117825)

> Auto Layout,0.0094,0.0152,0.0212,0.0273,0.0333,0.0397,0.0457,0.0517,0.0582,0.064
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=70868672)

> Manual Layout ,0.0038,0.0055,0.0075,0.0094,0.0114,0.0136,0.0153,0.0175,0.0197,0.0216
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=70868672)

> PinLayout 1.10.6,0.0034,0.0048,0.0064,0.0082,0.01,0.0117,0.0135,0.0154,0.0175,0.0191
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=70868672)

> Run on all reference devices (or at least the two latest generation) in **Release mode**.
>
> — [github.com/layoutBox/LayoutFrameworkBenchmark/blob/master/README.md](https://github.com/layoutBox/LayoutFrameworkBenchmark/blob/master/README.md)

</details>
