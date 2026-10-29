# Dwifft

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Collections](../README.md) › [Diffing](README.md)</sub>

**Tier D** (directional only) · ❌ Doesn't hold up · Open source · `Swift` · `MIT` · 🔴 abandoned

> LCS-based diff with UIKit bindings; claims speed with no numbers and measured 7.6x slower than the stdlib diff.

| | |
|---|---|
| **Beats** | A naive diff implementation (README); today's default is the standard library's difference(from:) |
| **Claimed result** | No numbers: 'considerably (many orders of magnitude) faster than a naïve implementation'. Third-party release build: 0.4732 s vs 0.0620 s for Swift.CollectionDifference at 5,000 elements, and 187.1341 s vs 5.0281 s at 100,000. |
| **Workload** | Third-party check: arrays of UUID, 5,000 or 100,000 elements with deletions, insertions and a shuffled prefix (DifferenceKit benchmark). |
| **Metric** | time |
| **Hardware** | iPhone 11 Pro simulator (host Mac not stated), for the third-party numbers |
| **Toolchain** | Xcode 11.1, Swift 5.1, -O; Dwifft 0.9 (third-party numbers) |
| **Measured** | 2019-10 |
| **Adoption** | 1.8k stars |
| **Last commit** | 2019-08-23 |
| **Platforms** | iOS |
| **Install** | CocoaPods, Carthage |
| **Links** | [repository](https://github.com/jflinter/Dwifft) · [benchmark](https://github.com/jflinter/Dwifft/blob/master/README.md) |

## Verdict

The README gives no numbers, only 'many orders of magnitude' faster than a naive implementation and 'almost certainly won't be the bottleneck'. In DifferenceKit's release build Dwifft 0.9 took 0.4732 s for 5,000 elements, 7.6x slower than the standard library's diff, and 187 s for 100,000, which would block a UI thread.

**Why tier D:** The library's own claim is directional with no numbers; the only measurements are third-party.

## Use it when

- Small tables in existing code that already use its UIKit diff calculators

## Skip it when

- Any list larger than a few hundred rows: 0.4732 s at 5,000 elements
- You need moves: Dwifft emits only inserts and deletes
- New code: last commit 2019

## How it is fast

Dwifft computes a longest common subsequence between the two arrays and turns it into insert and delete steps, with optimizations over a textbook LCS table. LCS needs work proportional to the product of both lengths in the worst case, so it scales poorly to large lists.

## What it costs

- No move detection
- Quadratic worst case

## Problems with the evidence

- Third-party numbers were measured on the iOS simulator in 2019 with Swift 5.1.
- The 149.6 s figure for Dwifft in DeepDiff's README is likely from a debug build and should not be cited.

## Evidence

<details>
<summary>6 quotes from the sources, checked 2026-10-28</summary>

> Dwifft is *fast* - a lot of time has been spent making Dwifft considerably (many orders of magnitude) faster than a naïve implementation. It almost certainly won't be the bottleneck in your UI code.
>
> — [github.com/jflinter/Dwifft/blob/master/README.md](https://github.com/jflinter/Dwifft/blob/master/README.md)

> [Dwifft](https://github.com/jflinter/Dwifft) - 0.9
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

</details>
