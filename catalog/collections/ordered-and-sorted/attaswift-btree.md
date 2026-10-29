# BTree (attaswift)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Collections](../README.md) › [Ordered and sorted collections](README.md)</sub>

**Tier D** (directional only) · 🟡 Holds up in part · Open source · `Swift` · `MIT` · 🔴 abandoned

> In-memory B-tree giving sorted lists, sets and maps with O(log n) insert; beats a sorted Array only at large counts.

| | |
|---|---|
| **Beats** | A sorted Swift Array kept in order with binary-search insertion |
| **Claimed result** | No B-tree numbers in text. The README says a sorted Array is about 6-7 times faster than a red-black tree up to about eighteen thousand items, that the B-tree's main benefits come at element counts well over a hundred thousand, and that cross-module generics cost a 10-200x slowdown on the Swift versions it targeted. |
| **Workload** | Inserting random Int keys one at a time into a sorted Array, an Array-backed red-black tree, and an Array-backed B-tree of order 1024; 128 to 262,144 keys (chart). |
| **Metric** | time |
| **Measured** | 2016 |
| **Adoption** | 1.3k stars |
| **Last commit** | 2019-03-26 |
| **Platforms** | macOS, iOS, watchOS, tvOS |
| **Install** | Swift Package Manager, CocoaPods, Carthage |
| **Links** | [repository](https://github.com/attaswift/BTree) · [benchmark](https://github.com/attaswift/BTree/blob/master/README.md) |

## Verdict

The README's own chart shows the B-tree level with a sorted Array up to tens of thousands of keys and pulling ahead only past roughly 30,000; the author says the interesting benefits start well over a hundred thousand items. The measurement is from the Swift 2-3 era, chart-only, and the library has had no commits since 2019.

**Why tier D:** No B-tree timings appear in text; the comparison exists only as a chart image, with no hardware, toolchain or date stated.

## Use it when

- Sorted collections of hundreds of thousands of elements with frequent inserts and removals
- Sorted data that is copied and then mutated, where Array copies everything
- Positional (rank) access into large sorted sets

## Skip it when

- Fewer than tens of thousands of elements: a sorted Array was as fast or faster in the README's chart
- New projects needing maintenance: no commits since 2019, written for Swift 3-4
- Hot loops over simple value types, unless the code is compiled into your module or cross-module optimization specializes it

## How it is fast

Each node is a small contiguous array of up to about 16 KiB of elements, so lookups binary-search cache-friendly memory and the tree stays a few levels deep. Inserting shifts elements within one node instead of the whole collection, turning the sorted Array's O(n) insertion into O(log n). Nodes are individually copy-on-write, so mutating a copy duplicates only one path.

## What it costs

- More code and memory overhead than a sorted Array for small collections
- Unmaintained; swift-collections' SortedSet/SortedDictionary (also B-tree based) are not yet in its stable public API

## Problems with the evidence

- Chart-only evidence; no hardware, Swift version or date stated, and the chart predates Swift 4.2.
- The '10-200x' cross-module generics penalty described in the README predates @inlinable (Swift 4.2) and cross-module optimization; the library does not use @inlinable, so modern behavior depends on compiler settings and is unmeasured.
- The deeper benchmarks live in the paid Optimizing Collections book, which was not checked.

## Evidence

<details>
<summary>3 quotes from the sources, checked 2026-10-28</summary>

> Near the beginning of the curve, up to about *eighteen thousand items*, a sorted array implementation imported from an external module is very consistently about 6-7 times faster than a red-black tree
>
> — [github.com/attaswift/BTree/blob/master/README.md](https://github.com/attaswift/BTree/blob/master/README.md)

> The most interesting benefits of B-trees often occur at element counts well over a hundred thousand.
>
> — [github.com/attaswift/BTree/blob/master/README.md](https://github.com/attaswift/BTree/blob/master/README.md)

> Relying on `import` will incur a *10-200x slowdown* when your collection is holding these most basic value types.
>
> — [github.com/attaswift/BTree/blob/master/README.md](https://github.com/attaswift/BTree/blob/master/README.md)

</details>
