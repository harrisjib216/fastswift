# LayoutKit

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [UI and rendering](../README.md) › [Layout](README.md)</sub>

**Tier A** (reproducible public benchmark) · ✅ Holds up · Open source · `Swift` · `Apache-2.0` · 🔴 abandoned

> LinkedIn's immutable layout engine for UIKit; still about 3.8x faster than Auto Layout in a 2025 run, but archived since 2021.

| | |
|---|---|
| **Beats** | Auto Layout (NSLayoutConstraint) laying out self-sizing UICollectionView cells |
| **Claimed result** | LinkedIn: 'as fast as manual layout code and ... significantly faster than Auto Layout' (chart only, iPhone 6, iOS 9.3.2). Independent run, 100 cells: iPhone 16 0.0156 s vs 0.0595 s Auto Layout (3.8x, derived from page data) and 0.0208 s manual; iPhone 13 Pro iOS 18.6 0.0165 s vs 0.064 s Auto Layout (3.9x, derived from page data) and 0.0216 s manual. |
| **Workload** | Lay out a feed-style UICollectionView cell for 10 to 100 cells per pass; seconds for vc.view.layoutIfNeeded() on the main thread. |
| **Metric** | time |
| **Hardware** | iPhone 16; iPhone 13 Pro (LinkedIn's original: iPhone 6) |
| **OS** | iOS 18.6 (iPhone 13 Pro); iPhone 16 OS not stated; LinkedIn's original iOS 9.3.2 |
| **Toolchain** | Release mode per LayoutFrameworkBenchmark README; LinkedIn ran 'with Swift optimization turned on' |
| **Measured** | 2025-08 |
| **Adoption** | 3.1k stars |
| **Last commit** | 2021-02-17 |
| **Platforms** | iOS, macOS, tvOS (last release targets Swift 4-era toolchains) |
| **Install** | CocoaPods, Carthage, Swift Package Manager |
| **Links** | [repository](https://github.com/LinkedInAttic/LayoutKit) · [benchmark](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/edit#gid=1032991425) |

## Verdict

LinkedIn's claim that LayoutKit matches manual layout and beats Auto Layout still holds on current hardware: an independent 2025 run puts it 3.8x-3.9x ahead of Auto Layout and slightly ahead of manual frame code. The project itself has been archived since 2021.

**Why tier A:** Numbers come from layoutBox's public LayoutFrameworkBenchmark (not LinkedIn), with device, iOS version and Release mode stated; LinkedIn's own benchmark page is chart-only.

## Use it when

- Studying or forking a proven background-thread layout design for feed cells
- Legacy codebases that already depend on it

## Skip it when

- New projects: the repository is archived and receives no fixes for new Swift or iOS releases
- SwiftUI views

## How it is fast

Layouts are immutable value descriptions that compute frames directly, without a constraint solver. Because the result is plain data, it can be computed on a background thread and cached, then applied to views on the main thread.

## What it costs

- Views are described through LayoutKit's own layout types rather than UIKit constraints.
- No maintenance: future Swift language modes and SDKs may break the build.

## Problems with the evidence

- LinkedIn's own benchmark page is chart-only and dates from iOS 9.3.2 on an iPhone 6.
- The independent numbers measure main-thread layout of one synthetic feed cell, not LayoutKit's background precomputation.
- Archived by LinkedIn (now under LinkedInAttic); last commit 2021-02-17.

## Evidence

<details>
<summary>10 quotes from the sources, checked 2026-10-28</summary>

> LayoutKit is as fast as manual layout code and is [significantly faster than Auto Layout]
>
> — [github.com/LinkedInAttic/LayoutKit/blob/master/README.md](https://github.com/LinkedInAttic/LayoutKit/blob/master/README.md)

> Benchmarks were run on an iPhone 6 running iOS 9.3.2 with Swift optimization turned on.
>
> — [github.com/LinkedInAttic/LayoutKit/blob/master/docs/benchmarks.md](https://github.com/LinkedInAttic/LayoutKit/blob/master/docs/benchmarks.md)

> Number of Cells in a UICollectionView ,10,20,30,40,50,60,70,80,90,100
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1326117825)

> ,iPhone16,iPhone 13 Pro (iOS 18.6),iPhone XS/ iOS 12
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1032991425)

> LayoutKit 10.1,0.0035,0.0048,0.0062,0.0076,0.0089,0.0103,0.0118,0.013,0.0145,0.0156
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1326117825)

> Auto Layout,0.0094,0.0146,0.02,0.0261,0.031,0.0378,0.0421,0.047,0.0538,0.0595
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1326117825)

> Manual Layout ,0.0039,0.0059,0.0077,0.0096,0.0116,0.0132,0.0151,0.0172,0.0189,0.0208
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1326117825)

> LayoutKit 10.1,0.0036,0.0047,0.0061,0.0077,0.0093,0.0109,0.0122,0.0137,0.015,0.0165
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=70868672)

> Auto Layout,0.0094,0.0152,0.0212,0.0273,0.0333,0.0397,0.0457,0.0517,0.0582,0.064
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=70868672)

> Manual Layout ,0.0038,0.0055,0.0075,0.0094,0.0114,0.0136,0.0153,0.0175,0.0197,0.0216
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=70868672)

</details>
