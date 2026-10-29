# DifferenceKit

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Collections](../README.md) › [Diffing](README.md)</sub>

**Tier C** (first-party numbers) · ✅ Holds up · Open source · `Swift` · `Apache-2.0` · 🔴 abandoned

> Linear-time Heckel diff for table and collection views, measured 33-144x faster than the standard library's difference(from:).

| | |
|---|---|
| **Beats** | Swift standard library difference(from:).inferringMoves() (CollectionDifference, Myers algorithm), Swift 5.1 |
| **Claimed result** | 5,000 UUIDs (1,000 deleted, 1,000 inserted, 200 shuffled): 0.0019 s vs 0.0620 s for Swift.CollectionDifference, about 33x (derived from page data). 100,000 UUIDs (10,000 deleted, 10,000 inserted, 2,000 shuffled): 0.0348 s vs 5.0281 s, about 144x (derived from page data). Next fastest library: RxDataSources at 0.0074 s and 0.1024 s. |
| **Workload** | Arrays of Foundation.UUID; a source of 5,000 or 100,000 elements and a target with a block deleted, a block inserted and a prefix shuffled; one diff computation (StagedChangeset for DifferenceKit, difference(from:).inferringMoves() for the standard library). |
| **Metric** | time |
| **Hardware** | iPhone 11 Pro simulator (host Mac not stated) |
| **Toolchain** | Xcode 11.1, Swift 5.1, -O |
| **Measured** | 2019-10 |
| **Adoption** | 3.7k stars |
| **Last commit** | 2022-06-24 |
| **Platforms** | iOS 9+, tvOS 9+, macOS 10.9+, watchOS 2+ (algorithm only) |
| **Install** | Swift Package Manager, CocoaPods, Carthage |
| **Links** | [repository](https://github.com/ra1028/DifferenceKit) · [benchmark](https://github.com/ra1028/DifferenceKit/blob/master/README.md) |

## Verdict

In its published release-build benchmark DifferenceKit computes UUID-array diffs 33x faster than the standard library at 5,000 elements and about 144x faster at 100,000, and it leads every other Swift diffing library in the table. The numbers come from a simulator in 2019, so treat the size of the gap as approximate.

**Why tier C:** Public benchmark code, Xcode 11.1, Swift 5.1 and -O are stated, but it ran on the iPhone 11 Pro simulator on an unstated Mac, by the library's own author.

## Use it when

- Animating UITableView or UICollectionView updates from large arrays with many changes
- Sectioned data, or data with duplicates, where you need moves and reloads
- Supporting iOS versions before 13, where diffable data sources are unavailable

## Skip it when

- You need a minimal edit script (text diffs, patches): Heckel's result is not guaranteed minimal
- Small lists with few changes, where the standard library diff costs well under a millisecond
- You already use UICollectionViewDiffableDataSource, which does its own diffing (not measured here)

## How it is fast

DifferenceKit uses Paul Heckel's 1978 algorithm: it hashes each element's identifier into a symbol table, matches unique occurrences between old and new arrays, and derives deletes, inserts, moves and updates in O(n). Myers-based diffs such as the standard library's cost O(ND), which grows quickly when many elements change or move. It also splits the result into stages that UIKit's batch updates can apply without crashing.

## What it costs

- Elements must conform to Differentiable (identifier plus content equality)
- Output is not a minimal edit script
- Hashing every identifier costs memory proportional to the collection

## Problems with the evidence

- Run on the iOS simulator, which uses the host Mac's CPU; the host is not named.
- Swift 5.1 and Xcode 11.1 (2019); standard library and compiler changes since then are not reflected.
- Benchmark written and published by DifferenceKit's author; each case is a single workload with UUID elements.
- The standard library baseline includes .inferringMoves(), which adds work but is needed to produce moves comparable to DifferenceKit's output.
- Unmaintained: no commits since June 2022.

## Evidence

<details>
<summary>6 quotes from the sources, checked 2026-10-28</summary>

> Performance was mesured by code compiled using `Xcode11.1` and `Swift 5.1` with `-O` optimization and run on `iPhone11 Pro simulator`. Use `Foundation.UUID` as an element of collections.
>
> — [github.com/ra1028/DifferenceKit/blob/master/README.md](https://github.com/ra1028/DifferenceKit/blob/master/README.md)

> From 5,000 elements to 1,000 deleted, 1,000 inserted and 200 shuffled
>
> — [github.com/ra1028/DifferenceKit/blob/master/README.md](https://github.com/ra1028/DifferenceKit/blob/master/README.md)

> |DifferenceKit |`0.0019` | |RxDataSources |`0.0074` | |IGListKit |`0.0346` | |FlexibleDiff |`0.0161` | |DeepDiff |`0.0373` | |Differ |`1.0581` | |Dwifft |`0.4732` | |Swift.CollectionDifference|`0.0620` |
>
> — [github.com/ra1028/DifferenceKit/blob/master/README.md](https://github.com/ra1028/DifferenceKit/blob/master/README.md)

> From 100,000 elements to 10,000 deleted, 10,000 inserted and 2,000 shuffled
>
> — [github.com/ra1028/DifferenceKit/blob/master/README.md](https://github.com/ra1028/DifferenceKit/blob/master/README.md)

> |DifferenceKit |`0.0348` | |RxDataSources |`0.1024` | |IGListKit |`0.7002` | |FlexibleDiff |`0.2189` | |DeepDiff |`0.5537` | |Differ |`153.8007` | |Dwifft |`187.1341` | |Swift.CollectionDifference|`5.0281` |
>
> — [github.com/ra1028/DifferenceKit/blob/master/README.md](https://github.com/ra1028/DifferenceKit/blob/master/README.md)

> _ = data.target.difference(from: data.source).inferringMoves()
>
> — [github.com/ra1028/DifferenceKit/blob/master/Benchmark/Sources/main.…](https://github.com/ra1028/DifferenceKit/blob/master/Benchmark/Sources/main.swift)

</details>
