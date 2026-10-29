# Differ

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Collections](../README.md) › [Diffing](README.md)</sub>

**Tier C** (first-party numbers) · ❌ Doesn't hold up · Open source · `Swift` · `MIT` · 🔴 abandoned

> Myers O((N+M)D) diff with UIKit helpers; its speed claim is against early Dwifft, and the stdlib diff now beats it.

| | |
|---|---|
| **Beats** | Dwifft 0.x (O(n*m) longest-common-subsequence diff), as chosen by the README |
| **Claimed result** | Mean of 10 runs on an iPhone 6: identical arrays 0.0213 s vs 52.3642 s for Dwifft; general diff 0.1320 s vs 63.4084 s; but Dwifft was faster for created (0.0033 vs 0.0188 s) and deleted (0.0050 vs 0.0184 s) cases. |
| **Workload** | Four cases (same, created, deleted, diff) from DiffPerformanceSuite; element count not stated in the README. |
| **Metric** | time |
| **Hardware** | iPhone 6 |
| **Adoption** | 676 stars |
| **Last commit** | 2022-03-13 |
| **Platforms** | iOS, macOS, tvOS |
| **Install** | Swift Package Manager, CocoaPods, Carthage |
| **Links** | [repository](https://github.com/tonyarnold/Differ) · [benchmark](https://github.com/tonyarnold/Differ/blob/main/README.md) |

## Verdict

The README's baseline is an early Dwifft, not a default anyone would reach for today. In DifferenceKit's release build, Differ took 1.0581 s on 5,000 elements, 17x slower than the standard library's difference(from:) and also slower than Dwifft 0.9, so it is not a faster choice than the default.

**Why tier C:** First-party means of 10 runs on an iPhone 6, with no build configuration, data size or date stated in the README.

## Use it when

- Existing code already depends on its patch ordering or UIKit extensions

## Skip it when

- Choosing a diff for speed: the standard library's difference(from:) was 17x faster and DifferenceKit about 550x faster in DifferenceKit's 5,000-element run
- Collections with many changes, where Myers' cost grows with the edit distance

## How it is fast

Differ implements Myers' O((N+M)D) algorithm, which is fast when the two collections differ in few places and slows as the edit distance D grows. It was faster than the O(n*m) table that early Dwifft built for every pair of elements.

## What it costs

- Cost grows with the number of differences
- Sorted patch generation is O(D^2), per the README

## Problems with the evidence

- The README does not say how many elements were diffed, which build configuration was used, or when it was measured.
- Dwifft 0.9 outperformed Differ in DifferenceKit's 5,000-element release-build run (0.4732 s vs 1.0581 s).
- No commits since March 2022.

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> Each measurement is the mean time in seconds it takes to calculate a diff, over 10 runs on an iPhone 6.
>
> — [github.com/tonyarnold/Differ/blob/main/README.md](https://github.com/tonyarnold/Differ/blob/main/README.md)

> | same | 0.0213 | 52.3642 | | created | 0.0188 | 0.0033 | | deleted | 0.0184 | 0.0050 | | diff | 0.1320 | 63.4084 |
>
> — [github.com/tonyarnold/Differ/blob/main/README.md](https://github.com/tonyarnold/Differ/blob/main/README.md)

> Performance was mesured by code compiled using `Xcode11.1` and `Swift 5.1` with `-O` optimization and run on `iPhone11 Pro simulator`. Use `Foundation.UUID` as an element of collections.
>
> — [github.com/ra1028/DifferenceKit/blob/master/README.md](https://github.com/ra1028/DifferenceKit/blob/master/README.md)

> |DifferenceKit |`0.0019` | |RxDataSources |`0.0074` | |IGListKit |`0.0346` | |FlexibleDiff |`0.0161` | |DeepDiff |`0.0373` | |Differ |`1.0581` | |Dwifft |`0.4732` | |Swift.CollectionDifference|`0.0620` |
>
> — [github.com/ra1028/DifferenceKit/blob/master/README.md](https://github.com/ra1028/DifferenceKit/blob/master/README.md)

</details>
