# SwiftBitset

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Collections](../README.md) › [Heaps and bit sets](README.md)</sub>

**Tier C** (first-party numbers) · 🟡 Holds up in part · Open source · `Swift` · `Apache-2.0` · 🔴 abandoned

> Daniel Lemire's word-array bitset for integer sets; much faster than IndexSet on scattered values, slower at count.

| | |
|---|---|
| **Beats** | Foundation IndexSet |
| **Claimed result** | Add: 10.7 ms vs 232 ms for IndexSet, about 22x (derived from page data); iterate: 5.5 ms vs 234 ms, about 43x (derived from page data); intersection: 3.16 ms vs 2775 ms, about 880x (derived from page data). Count: 0.617 ms vs 0.00748 ms, IndexSet about 82x faster (derived from page data). Times rounded to three significant figures from the raw results. |
| **Workload** | One million integers at stride 100 in 0..<100,000,000 (1% density); intersection against a second set at stride 10; each operation timed once. |
| **Metric** | time |
| **Toolchain** | swift build -Xcc -march=native --configuration release; Swift version not stated (README badge says Swift 4) |
| **Measured** | 2019 |
| **Adoption** | 39 stars |
| **Last commit** | 2019-07-09 |
| **Platforms** | macOS, Linux |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/lemire/SwiftBitset) · [benchmark](https://github.com/lemire/SwiftBitset/blob/master/README.md) |

## Verdict

The bitset is 22-880x faster than IndexSet for add, iteration and intersection in the published run, but the input (every 100th integer) gives IndexSet no contiguous ranges, its worst case, and IndexSet was 82x faster at count. The numbers are from Swift 4-era Foundation, before IndexSet's implementation changed, and the library has been idle since 2019.

**Why tier C:** Public benchmark code with release build flags, by the library's author, but hardware, OS and Swift version are not stated and each operation is timed once.

## Use it when

- Dense or moderately dense sets of small non-negative integers
- Heavy intersection and union work over integer sets
- Replacing Set<Int> or IndexSet for scattered values below a known maximum

## Skip it when

- Values are mostly long contiguous runs: IndexSet's range storage is built for that case
- Values are sparse over a huge range: memory scales with the largest value
- You need count often without caching: IndexSet answered count about 82x faster here
- You want a maintained dependency: swift-collections' BitSet covers the same ground

## How it is fast

Bitset stores one bit per possible integer in an array of 64-bit words, so insert and membership are a shift and a mask, and intersection is a word-by-word AND that the compiler can vectorize. IndexSet stores sorted ranges, which is compact for runs but needs a range search and splitting for scattered values.

## What it costs

- Memory proportional to the largest value stored, not to the count
- Bitset is a class (reference semantics), unlike IndexSet and Set
- Only non-negative Int values

## Problems with the evidence

- IndexSet worst case: no two inserted values are adjacent, so every value is its own range.
- Single timed run per operation; no repetition or warm-up.
- Measured against pre-2023 Foundation; IndexSet's implementation has changed since, and no newer numbers exist.
- Hardware and OS not stated.

## Evidence

<details>
<summary>6 quotes from the sources, checked 2026-10-28</summary>

> testAddPerformance 10.693318 ms testIndexSetAddPerformance 231.737616 ms
>
> — [github.com/lemire/SwiftBitset/blob/master/README.md](https://github.com/lemire/SwiftBitset/blob/master/README.md)

> testCountPerformance 0.617098 ms testIndexSetCountPerformance 0.007483 ms
>
> — [github.com/lemire/SwiftBitset/blob/master/README.md](https://github.com/lemire/SwiftBitset/blob/master/README.md)

> testIteratorPerformance 5.503873 ms testIndexSetIteratorPerformance 234.289692 ms
>
> — [github.com/lemire/SwiftBitset/blob/master/README.md](https://github.com/lemire/SwiftBitset/blob/master/README.md)

> testIntersectionPerformance 3.157883 ms testIndexSetIntersectionPerformance 2774.959423 ms
>
> — [github.com/lemire/SwiftBitset/blob/master/README.md](https://github.com/lemire/SwiftBitset/blob/master/README.md)

> $ swift build -Xcc -march=native --configuration release
>
> — [github.com/lemire/SwiftBitset/blob/master/README.md](https://github.com/lemire/SwiftBitset/blob/master/README.md)

> for i in stride(from: 0, to: 100_000_000, by: 100) {
>
> — [github.com/lemire/SwiftBitsetBenchmark/blob/master/Sources/SwiftBit…](https://github.com/lemire/SwiftBitsetBenchmark/blob/master/Sources/SwiftBitsetBenchmark/main.swift)

</details>
