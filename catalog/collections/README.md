# Collections

<sub>[fastswift](../../README.md) › [Catalog](../README.md)</sub>

## [Deques and queues](deques-and-queues/README.md)

**The default:** Array used as a FIFO queue.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**swift-collections (Deque)**](deques-and-queues/apple-swift-collections-deque.md) | Apple's ring-buffer double-ended queue; constant-time prepend and popFirst where Array.insert(at: 0) and removeFirst are linear. | A | ✅ Holds up |

## [Ordered and sorted collections](ordered-and-sorted/README.md)

**The default:** An Array and a Set kept in sync, NSOrderedSet, or a sorted Array with binary-search insertion.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**swift-collections (OrderedSet)**](ordered-and-sorted/apple-swift-collections-orderedset.md) | Apple's ordered hashed set: Array order with constant-time membership, replacing contains() scans over arrays. | A | 🟡 Holds up in part |
| [**BTree (attaswift)**](ordered-and-sorted/attaswift-btree.md) | In-memory B-tree giving sorted lists, sets and maps with O(log n) insert; beats a sorted Array only at large counts. | D | 🟡 Holds up in part |

## [Persistent and tree collections](persistent-and-tree/README.md)

**The default:** Dictionary and Set when copies get mutated.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**swift-collections (TreeSet, TreeDictionary)**](persistent-and-tree/apple-swift-collections-treeset.md) | Persistent hashed set and dictionary (CHAMP tries) that make mutating shared copies logarithmic instead of a full copy. | C | ✅ Holds up |

## [Heaps and bit sets](heaps-and-bitsets/README.md)

**The default:** Re-sorting an Array for its minimum or maximum, and Set<Int> for dense integers.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**SwiftBitset**](heaps-and-bitsets/lemire-swiftbitset.md) | Daniel Lemire's word-array bitset for integer sets; much faster than IndexSet on scattered values, slower at count. | C | 🟡 Holds up in part |
| [**swift-collections (Heap)**](heaps-and-bitsets/apple-swift-collections-heap.md) | Apple's array-backed min-max heap for priority queues; O(log n) push and pop instead of re-sorting an Array. | D | 🟡 Holds up in part |

## [Diffing](diffing/README.md)

**The default:** The standard library's difference(from:), reloadData, and diffable data sources.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**IGListKit (IGListDiff)**](diffing/instagram-iglistkit.md) | Instagram's list framework with a linear-time Heckel diff, measured 1.8-7.2x faster than the standard library's difference(from:). | B | ✅ Holds up |
| [**DifferenceKit**](diffing/ra1028-differencekit.md) | Linear-time Heckel diff for table and collection views, measured 33-144x faster than the standard library's difference(from:). | C | ✅ Holds up |
| [**DeepDiff**](diffing/onmyway133-deepdiff.md) | Heckel-based Swift diff for table and collection views; faster than Myers libraries, but its own benchmark overstates the gap. | C | 🟡 Holds up in part |
| [**Differ**](diffing/tonyarnold-differ.md) | Myers O((N+M)D) diff with UIKit helpers; its speed claim is against early Dwifft, and the stdlib diff now beats it. | C | ❌ Doesn't hold up |
| [**Dwifft**](diffing/jflinter-dwifft.md) | LCS-based diff with UIKit bindings; claims speed with no numbers and measured 7.6x slower than the stdlib diff. | D | ❌ Doesn't hold up |

## [Sorting and searching](sorting-and-searching/README.md)

**The default:** Array.sort, sorted().prefix(k), and firstIndex(of:).

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**swift-algorithms (min(count:), max(count:))**](sorting-and-searching/apple-swift-algorithms-min-count.md) | Apple's partial selection: the k smallest or largest elements in about O(n) for small k instead of sorting everything. | D | ✅ Holds up |
