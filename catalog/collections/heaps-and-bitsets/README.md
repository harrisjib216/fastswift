# Heaps and bit sets

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Collections](../README.md)</sub>

**The default:** Re-sorting an Array for its minimum or maximum, and Set<Int> for dense integers.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**SwiftBitset**](lemire-swiftbitset.md) | Daniel Lemire's word-array bitset for integer sets; much faster than IndexSet on scattered values, slower at count. | C | 🟡 Holds up in part |
| [**swift-collections (Heap)**](apple-swift-collections-heap.md) | Apple's array-backed min-max heap for priority queues; O(log n) push and pop instead of re-sorting an Array. | D | 🟡 Holds up in part |
