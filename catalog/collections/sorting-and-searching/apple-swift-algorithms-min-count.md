# swift-algorithms (min(count:), max(count:))

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Collections](../README.md) › [Sorting and searching](README.md)</sub>

**Tier D** (directional only) · ✅ Holds up · Open source · `Swift` · `Apache-2.0` · 🟢 active

> Apple's partial selection: the k smallest or largest elements in about O(n) for small k instead of sorting everything.

| | |
|---|---|
| **Beats** | sorted().prefix(k) (sorting the whole collection to take the k smallest) |
| **Claimed result** | No numbers in text. Complexity O(k log k + nk), close to O(n) for small k; falls back to sorting when k is more than 10% of the collection. |
| **Workload** | Taking the k smallest elements of an Int collection for growing k, comparing a priority queue, the shipped SmallestM approach, a quicksort-based partial sort and Stdlib sort+prefix (charts, sizes unstated). |
| **Metric** | time |
| **Measured** | 2021-04 |
| **Adoption** | 6.3k stars |
| **Last commit** | 2026-07-22 |
| **Platforms** | All Swift platforms: iOS, macOS, tvOS, watchOS, visionOS, Linux, Windows |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/apple/swift-algorithms) · [benchmark](https://github.com/apple/swift-algorithms/blob/main/Guides/MinMax.md) |

## Verdict

The guide claims a speedup only when k is small and falls back to a full sort when k exceeds 10% of the collection, and its charts are consistent with that. The evidence is weak: the numbers exist only as chart images, collection size and machine are unstated, and the charts predate the fallback.

**Why tier D:** Numbers exist only in two chart images; the text gives complexity and the 10% cutoff, with no timings, hardware or toolchain.

## Use it when

- Top-N queries (top 10 scores, nearest 20 results) over large arrays
- Code that calls sorted().prefix(k) or sorted().suffix(k) with k much smaller than n
- Single-pass sequences, where sorting would need the whole sequence in memory anyway

## Skip it when

- k is a large fraction of n: the function falls back to sorting anyway
- You need the whole collection sorted later

## How it is fast

min(count:) keeps a sorted buffer of the best k elements seen so far and skips any element larger than the current k-th, so most elements cost one comparison. That gives O(k log k + nk), which is near-linear when k is small, instead of O(n log n) for a full sort. Above 10% of the collection it switches to a full sort.

## What it costs

- Returns a new Array of k elements; no in-place partial sort
- Worst case remains O(n log n) via the fallback

## Problems with the evidence

- Chart-only evidence (Guides/Resources/SortedPrefix/FewElements.png and ManyElements.png) with no stated collection size, hardware, build mode or Swift version.
- The charts were made before the 10% fallback was added, so they show the shipped algorithm losing at large k.
- Based on Soroush Khanlou's 2018 analysis, whose own speedup figures are theoretical or relative to his naive version, not to a full sort.

## Evidence

<details>
<summary>2 quotes from the sources, checked 2026-10-28</summary>

> The total complexity is `O(k log k + nk)`, which will result in a runtime close to `O(n)` if *k* is a small amount. If *k* is a large amount (more than 10% of the collection), we fall back to sorting the entire array.
>
> — [github.com/apple/swift-algorithms/blob/main/Guides/MinMax.md](https://github.com/apple/swift-algorithms/blob/main/Guides/MinMax.md)

> Here are some benchmarks we made that demonstrates how this implementation (SmallestM) behaves when *k* increases (before implementing the fallback):
>
> — [github.com/apple/swift-algorithms/blob/main/Guides/MinMax.md](https://github.com/apple/swift-algorithms/blob/main/Guides/MinMax.md)

</details>
