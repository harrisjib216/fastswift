# Ordered and sorted collections

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Collections](../README.md)</sub>

**The default:** An Array and a Set kept in sync, NSOrderedSet, or a sorted Array with binary-search insertion.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**swift-collections (OrderedSet)**](apple-swift-collections-orderedset.md) | Apple's ordered hashed set: Array order with constant-time membership, replacing contains() scans over arrays. | A | 🟡 Holds up in part |
| [**BTree (attaswift)**](attaswift-btree.md) | In-memory B-tree giving sorted lists, sets and maps with O(log n) insert; beats a sorted Array only at large counts. | D | 🟡 Holds up in part |
