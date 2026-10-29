# IGListKit (IGListDiff)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Collections](../README.md) › [Diffing](README.md)</sub>

**Tier B** (independent measurement) · ✅ Holds up · Open source · `Objective-C++` · `MIT` · 🟢 active

> Instagram's list framework with a linear-time Heckel diff, measured 1.8-7.2x faster than the standard library's difference(from:).

| | |
|---|---|
| **Beats** | Swift standard library difference(from:).inferringMoves() (CollectionDifference, Myers algorithm), Swift 5.1 |
| **Claimed result** | 5,000 UUIDs: 0.0346 s vs 0.0620 s for Swift.CollectionDifference, about 1.8x (derived from page data). 100,000 UUIDs: 0.7002 s vs 5.0281 s, about 7.2x (derived from page data). |
| **Workload** | Arrays of NSUUID (bridged from UUID) diffed with ListDiff(oldArray:newArray:option: .equality); 5,000 or 100,000 elements with deletions, insertions and a shuffled prefix. |
| **Metric** | time |
| **Hardware** | iPhone 11 Pro simulator (host Mac not stated) |
| **Toolchain** | Xcode 11.1, Swift 5.1, -O; IGListKit 3.4.0 |
| **Measured** | 2019-10 |
| **Adoption** | 13.1k stars |
| **Last commit** | 2026-10-23 |
| **Platforms** | iOS 11+, tvOS 11+, macOS 10.13+ (diffing only) |
| **Install** | Swift Package Manager, CocoaPods, Carthage |
| **Links** | [repository](https://github.com/Instagram/IGListKit) · [benchmark](https://github.com/ra1028/DifferenceKit/blob/master/README.md) |

## Verdict

In a third-party release-build benchmark, IGListKit's linear-time diff beat the standard library by about 1.8x at 5,000 elements and 7.2x at 100,000. It was also 18-20x slower than DifferenceKit in the same run, so it is the right choice only if you want IGListKit's list framework, not for raw diff speed.

**Why tier B:** Numbers come from DifferenceKit's public benchmark, independent of IGListKit's authors, though run by a competing library on a simulator.

## Use it when

- You are building feeds with IGListKit's section controllers and want diffing included
- Large lists with many changes where the standard library diff becomes slow
- Objective-C or mixed codebases

## Skip it when

- You only need a fast diff in Swift: DifferenceKit measured 18-20x faster in the same run
- Swift value types that would need bridging to NSObject-based ListDiffable models
- You need sectioned diffs: ListDiff is linear only

## How it is fast

IGListDiff implements Heckel's linear-time algorithm in Objective-C++ using hash tables keyed by each object's diffIdentifier, so cost grows with element count rather than with the number of edits. The standard library's Myers diff is O(ND), which degrades as more elements change.

## What it costs

- Models must adopt ListDiffable (NSObject-based)
- A full UI framework, not just a diff function
- Linear (unsectioned) diff only

## Problems with the evidence

- Benchmark run by a competing library's author, on the simulator, with IGListKit 3.4.0 in 2019; IGListKit has changed since.
- Elements were bridged to NSUUID, adding Objective-C object overhead that a native Swift diff avoids.
- IGListKit's own README makes no numeric performance claim.

## Evidence

<details>
<summary>7 quotes from the sources, checked 2026-10-28</summary>

> Performance was mesured by code compiled using `Xcode11.1` and `Swift 5.1` with `-O` optimization and run on `iPhone11 Pro simulator`. Use `Foundation.UUID` as an element of collections.
>
> — [github.com/ra1028/DifferenceKit/blob/master/README.md](https://github.com/ra1028/DifferenceKit/blob/master/README.md)

> [IGListKit](https://github.com/Instagram/IGListKit) - 3.4.0
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

> _ = ListDiff(oldArray: oldArray, newArray: newArray, option: .equality)
>
> — [github.com/ra1028/DifferenceKit/blob/master/Benchmark/Sources/main.…](https://github.com/ra1028/DifferenceKit/blob/master/Benchmark/Sources/main.swift)

</details>
