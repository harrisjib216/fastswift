# DeepDiff

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Collections](../README.md) › [Diffing](README.md)</sub>

**Tier C** (first-party numbers) · 🟡 Holds up in part · Open source · `Swift` · `NOASSERTION` · 🔴 abandoned

> Heckel-based Swift diff for table and collection views; faster than Myers libraries, but its own benchmark overstates the gap.

| | |
|---|---|
| **Beats** | Other Swift diffing libraries (Differ, Dwifft, Changeset, ListDiff); the standard library's difference(from:) did not exist yet |
| **Claimed result** | 2000 to 2100 UUID strings (100 deletions, 200 insertions): DeepDiff 0.0451 s, Differ 0.2 s, ListDiff 0.106 s, Changeset 77.6 s, Dwifft 150 s. Independent release-build check (DifferenceKit, 5,000 UUIDs): DeepDiff 0.0373 s vs 0.0620 s for Swift.CollectionDifference. Times rounded to three significant figures from the raw results. |
| **Workload** | Arrays of 36-character UUID strings; 2,000 old items, new array with 100 deletions and 200 insertions; one timed call per library. |
| **Metric** | time |
| **Hardware** | iPhone 6 |
| **Toolchain** | Not stated (Swift 4-5 era; benchmark project has no shared scheme, so Xcode's default Run uses the Debug configuration) |
| **Measured** | 2018-01 |
| **Adoption** | 2.0k stars |
| **Last commit** | 2021-05-08 |
| **Platforms** | iOS, tvOS, macOS |
| **Install** | Swift Package Manager, CocoaPods, Carthage |
| **Links** | [repository](https://github.com/onmyway133/DeepDiff) · [benchmark](https://github.com/onmyway133/DeepDiff/blob/master/README.md) |

## Verdict

The ranking holds: in DifferenceKit's later release-build run DeepDiff still beats the Myers-based libraries and the standard library. The size of the gap does not: the README's Dwifft and Changeset timings of 77-150 seconds come from single Date()-timed runs in a project with no shared scheme, which most likely means a debug build, and in a release build Dwifft took 0.47 s on a larger input. DeepDiff also only tied IGListKit and ran about 20x slower than DifferenceKit.

**Why tier C:** First-party, single-shot timings on an iPhone 6 with no build configuration stated; benchmark code is public.

## Use it when

- Existing code already depends on it and lists are moderate in size

## Skip it when

- New code: the repository is archived, and DifferenceKit measured about 20x faster in the same release build
- You need sectioned diffs

## How it is fast

DeepDiff uses Heckel's linear-time algorithm with a hashable diffId per element, plus a move reducer adapted from HeckelDiff. Earlier versions used Wagner-Fischer, which is O(mn) and only suitable for small lists.

## What it costs

- Elements must conform to DiffAware (diffId plus content comparison)
- Archived: no fixes for newer Swift versions

## Problems with the evidence

- Each library was timed once with Date() inside viewWillAppear, with no warm-up or repetition.
- The Benchmark project ships no shared scheme, so a default Run uses Debug (-Onone) for the app and its CocoaPods; Dwifft's 149.6 s here versus 0.4732 s for a larger input in DifferenceKit's -O run points to an unoptimized build.
- iPhone 6 in early 2018 with library versions of that time (Dwifft 0.8, Differ 1.0.3, Changeset 3.0, ListDiff 0.1.0).
- GitHub reports the license as NOASSERTION; LICENSE.md contains MIT text.
- Repository archived; last commit May 2021.

## Evidence

<details>
<summary>7 quotes from the sources, checked 2026-10-28</summary>

> Benchmarking is done on real device iPhone 6, with random items made of UUID strings (36 characters including hyphens), just to make comparisons more difficult.
>
> — [github.com/onmyway133/DeepDiff/blob/master/README.md](https://github.com/onmyway133/DeepDiff/blob/master/README.md)

> DeepDiff: 0.0450611114501953s Differ: 0.199673891067505s Dwifft: 149.603884935379s Changeset: 77.5895738601685s ListDiff: 0.105544805526733s
>
> — [github.com/onmyway133/DeepDiff/blob/master/README.md](https://github.com/onmyway133/DeepDiff/blob/master/README.md)

> From 2000 items to 2100 items (100 deletions, 200 insertions)
>
> — [github.com/onmyway133/DeepDiff/blob/master/README.md](https://github.com/onmyway133/DeepDiff/blob/master/README.md)

> let start = Date() closure() let end = Date()
>
> — [github.com/onmyway133/DeepDiff/blob/master/Example/Benchmark/Benchm…](https://github.com/onmyway133/DeepDiff/blob/master/Example/Benchmark/Benchmark/ViewController.swift)

> Performance was mesured by code compiled using `Xcode11.1` and `Swift 5.1` with `-O` optimization and run on `iPhone11 Pro simulator`. Use `Foundation.UUID` as an element of collections.
>
> — [github.com/ra1028/DifferenceKit/blob/master/README.md](https://github.com/ra1028/DifferenceKit/blob/master/README.md)

> From 5,000 elements to 1,000 deleted, 1,000 inserted and 200 shuffled
>
> — [github.com/ra1028/DifferenceKit/blob/master/README.md](https://github.com/ra1028/DifferenceKit/blob/master/README.md)

> |DifferenceKit |`0.0019` | |RxDataSources |`0.0074` | |IGListKit |`0.0346` | |FlexibleDiff |`0.0161` | |DeepDiff |`0.0373` | |Differ |`1.0581` | |Dwifft |`0.4732` | |Swift.CollectionDifference|`0.0620` |
>
> — [github.com/ra1028/DifferenceKit/blob/master/README.md](https://github.com/ra1028/DifferenceKit/blob/master/README.md)

</details>
