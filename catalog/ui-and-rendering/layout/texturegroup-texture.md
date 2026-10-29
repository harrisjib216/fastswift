# Texture (ASDisplayNode, ASCollectionNode)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [UI and rendering](../README.md) › [Layout](README.md)</sub>

**Tier A** (reproducible public benchmark) · ✅ Holds up · Open source · `Objective-C++` · `NOASSERTION` · 🟢 active

> Node-based UI framework (ex-AsyncDisplayKit) that cut main-thread cell layout time 5.4x vs Auto Layout in an independent 2025 run.

| | |
|---|---|
| **Beats** | Auto Layout and manual frame layout of UICollectionView cells on the main thread |
| **Claimed result** | Main-thread time, 100 cells: iPhone 16 0.011 s (Texture 3.1) vs 0.0595 s Auto Layout (5.4x, derived from page data) and 0.0208 s manual layout (1.9x, derived from page data); iPhone 13 Pro iOS 18.6 0.0109 s (Texture 3.2) vs 0.064 s Auto Layout (5.9x, derived from page data) and 0.0216 s manual (2.0x, derived from page data). |
| **Workload** | Same feed cell built as an ASCellNode in an ASCollectionNode; benchmark times vc.view.layoutIfNeeded() on the main thread for 10 to 100 cells. |
| **Metric** | time (main thread) |
| **Hardware** | iPhone 16; iPhone 13 Pro |
| **OS** | iOS 18.6 (iPhone 13 Pro); iPhone 16 OS not stated |
| **Toolchain** | Release mode per LayoutFrameworkBenchmark README; exact Swift and Xcode version not stated |
| **Measured** | 2025-08 |
| **Adoption** | 8.2k stars |
| **Last commit** | 2026-07-29 |
| **Platforms** | iOS 14+, tvOS 14+ |
| **Install** | CocoaPods, Carthage |
| **Links** | [repository](https://github.com/TextureGroup/Texture) · [benchmark](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/edit#gid=1032991425) |

## Verdict

Texture says it moves layout and text sizing off the main thread. In an independent 2025 benchmark its main-thread layout time for 100 cells is 5.4x-5.9x lower than Auto Layout and about half that of manual frame code. The comparison counts main-thread time only, which is the quantity Texture claims to reduce.

**Why tier A:** Public LayoutFrameworkBenchmark app run by a third party (layoutBox) with device, iOS version and Release mode stated; Texture's own README gives no numbers.

## Use it when

- Long, image- and text-heavy feeds where main-thread layout and text measurement cause dropped frames
- Teams able to adopt a whole parallel view hierarchy (nodes) for those screens

## Skip it when

- SwiftUI apps or small screens where UIKit is already fast enough
- Teams that cannot absorb a large Objective-C++ dependency and its node API

## How it is fast

Texture's nodes are thread-safe wrappers around views and layers, so measurement, text sizing, image decoding and layout run on background queues. ASCollectionNode prepares cell nodes ahead of display, leaving the main thread to commit finished frames.

## What it costs

- Large dependency with its own node hierarchy, layout specs and threading rules.
- Total CPU work is moved, not removed; background layout competes with other background tasks.

## Problems with the evidence

- The benchmark times only main-thread work inside layoutIfNeeded(); Texture measures cell nodes on background queues, so part of its total CPU cost falls outside the timed window.
- Texture's own README gives no numbers.
- GitHub reports the license as NOASSERTION; the LICENSE file states that all code is under the Apache License 2.0.
- Single synthetic feed cell; visual output differs slightly between frameworks per the benchmark README.

## Evidence

<details>
<summary>10 quotes from the sources, checked 2026-10-28</summary>

> Texture lets you move image decoding, text sizing and rendering, layout, and other expensive UI operations off the main thread, to keep the main thread available to respond to user interaction.
>
> — [github.com/TextureGroup/Texture/blob/master/README.md](https://github.com/TextureGroup/Texture/blob/master/README.md)

> ,iPhone16,iPhone 13 Pro (iOS 18.6),iPhone XS/ iOS 12
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1032991425)

> Number of Cells in a UICollectionView ,10,20,30,40,50,60,70,80,90,100
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1326117825)

> Texture 3.1,0.0018,0.0032,0.0044,0.0074,0.0083,0.007,0.0081,0.0089,0.0099,0.011
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1326117825)

> Auto Layout,0.0094,0.0146,0.02,0.0261,0.031,0.0378,0.0421,0.047,0.0538,0.0595
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1326117825)

> Manual Layout ,0.0039,0.0059,0.0077,0.0096,0.0116,0.0132,0.0151,0.0172,0.0189,0.0208
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1326117825)

> Texture 3.2,0.0013,0.0025,0.0037,0.0052,0.0056,0.0066,0.0077,0.0088,0.01,0.0109
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=70868672)

> Auto Layout,0.0094,0.0152,0.0212,0.0273,0.0333,0.0397,0.0457,0.0517,0.0582,0.064
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=70868672)

> Manual Layout ,0.0038,0.0055,0.0075,0.0094,0.0114,0.0136,0.0153,0.0175,0.0197,0.0216
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=70868672)

> vc?.view.layoutIfNeeded()
>
> — [github.com/layoutBox/LayoutFrameworkBenchmark/blob/master/LayoutFra…](https://github.com/layoutBox/LayoutFrameworkBenchmark/blob/master/LayoutFrameworkBenchmark/Benchmarks/BenchmarkViewController.swift)

</details>
