# swift-collections (Heap)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Collections](../README.md) › [Heaps and bit sets](README.md)</sub>

**Tier D** (directional only) · 🟡 Holds up in part · Open source · `Swift` · `Apache-2.0` · 🟢 active

> Apple's array-backed min-max heap for priority queues; O(log n) push and pop instead of re-sorting an Array.

| | |
|---|---|
| **Beats** | Re-sorting an Array (or scanning it with min()/max()) to get the smallest or largest element |
| **Claimed result** | No comparative numbers. Documented complexity is O(log n) insert and removal and O(1) min and max; the chart of absolute per-element times was generated in release mode on a 16-inch 2019 MacBook Pro with a 2.3 GHz 8-Core Intel Core i9. |
| **Workload** | Heap<Int>: init from range, insert, insert(contentsOf:), popMin, popMax; 1 to 1M elements (chart). |
| **Metric** | time |
| **Hardware** | MacBook Pro (16-inch, 2019), 2.3 GHz 8-core Intel Core i9 |
| **Toolchain** | Release mode; Swift version not stated |
| **Measured** | 2021-08 |
| **Adoption** | 4.5k stars |
| **Last commit** | 2026-10-27 |
| **Platforms** | All Swift platforms: iOS, macOS, tvOS, watchOS, visionOS, Linux, Windows |
| **Install** | Swift Package Manager (HeapModule, swift-collections 1.1+) |
| **Links** | [repository](https://github.com/apple/swift-collections) · [benchmark](https://github.com/apple/swift-collections/blob/main/Documentation/Heap.md) |

## Verdict

The documentation publishes only absolute per-operation timings for Heap itself, as a chart image, with no comparison against sorting an Array or against another priority queue. The advantage over re-sorting follows from O(log n) versus O(n log n) complexity, but no published number measures it.

**Why tier D:** Numbers exist only in a chart image with no baseline series; text gives complexities and the test machine.

## Use it when

- Priority queues, schedulers, Dijkstra or A* open sets
- Code that appends and then re-sorts an Array, or calls min() on every step, to pull the next item
- You need both ends: popMin and popMax on one structure

## Skip it when

- You need all elements in sorted order once: a single sort() is simpler and usually faster
- Very small queues where a linear min() scan is already cheap
- You need stable ordering among equal priorities: heaps do not preserve insertion order

## How it is fast

Heap is an implicit min-max heap stored in a single contiguous array: even levels are min levels, odd levels are max levels. Insert and removal walk one root-to-leaf path, so they cost O(log n), and both the minimum and the maximum are readable in O(1).

## What it costs

- Not a Sequence: iteration order is not sorted unless you pop elements
- Min-max levels make each operation do a little more comparison work than a plain binary heap

## Problems with the evidence

- Numbers exist only in a chart image (Documentation/Images/Heap Performance.png) with no comparison series.
- Measured in 2021 on an Intel MacBook Pro; Swift version not stated.
- The PR history shows reference benchmarks against CFBinaryHeap and std::priority_queue were added to the benchmark suite, but their results are not published in text.

## Evidence

<details>
<summary>2 quotes from the sources, checked 2026-10-28</summary>

> | Insert | O(log n) | | Get smallest element | O(1) | | Get largest element | O(1) | | Remove smallest element | O(log n) | | Remove largest element | O(log n) |
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Heap.md](https://github.com/apple/swift-collections/blob/main/Documentation/Heap.md)

> The above graph was generated in release mode on a MacBook Pro (16-inch, 2019) with a 2.3 GHz 8-Core Intel Core i9 using the benchmarks defined in the `swift-collections-benchmark` target.
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Heap.md](https://github.com/apple/swift-collections/blob/main/Documentation/Heap.md)

</details>
