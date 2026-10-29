# swift-collections (TreeSet, TreeDictionary)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Collections](../README.md) › [Persistent and tree collections](README.md)</sub>

**Tier C** (first-party numbers) · ✅ Holds up · Open source · `Swift` · `Apache-2.0` · 🟢 active

> Persistent hashed set and dictionary (CHAMP tries) that make mutating shared copies logarithmic instead of a full copy.

| | |
|---|---|
| **Beats** | Swift Set and Dictionary when a copy is kept and then mutated (copy-on-write duplicates the whole hash table) |
| **Claimed result** | Insert-then-diff loop up to a million Ints: Set would have taken roughly five hours, the tree-based set about two seconds; per iteration Set goes from 100ns to >10ms across the size range while the tree set grows by an 8-10x factor. Cost: insertions into a uniquely held tree set are 2-8 times slower than into Set. |
| **Workload** | Toy UI-model loop: insert Int i into a set, then compute insertions and removals against the previous snapshot with subtracting(), keeping the snapshot; 1 to 1,000,000 items. Unique-insertion cost measured separately (chart). |
| **Metric** | time |
| **Measured** | 2022-11 |
| **Adoption** | 4.5k stars |
| **Last commit** | 2026-10-27 |
| **Platforms** | All Swift platforms: iOS, macOS, tvOS, watchOS, visionOS, Linux, Windows |
| **Install** | Swift Package Manager (HashTreeCollections module, swift-collections 1.1+) |
| **Links** | [repository](https://github.com/apple/swift-collections) · [benchmark](https://github.com/apple/swift-collections/blob/main/Documentation/Reviews/2022-10-31.ShareableHashedCollections/ShareableHashedCollections.md) |

## Verdict

When copies are kept and mutated, a CHAMP tree copies only the path to the changed item, so the per-step cost grows logarithmically instead of linearly; the authors' model-diffing test shows Set taking roughly five hours against about two seconds. The same authors state plainly that without shared copies the trees are 2-8 times slower to insert into than Set, and the record carries that limit.

**Why tier C:** First-party numbers in the API review document and forum thread, with the test code shown but no hardware, OS or toolchain stated and the Set figure partly extrapolated.

## Use it when

- State snapshots: undo stacks, Redux/TCA-style stores or CRDTs that keep old versions of a large dictionary or set
- Repeatedly diffing a large set against its previous version
- Passing large dictionaries across actors or threads and mutating the copies

## Skip it when

- The collection is mutated in place and never copied: Set and Dictionary insert 2-8 times faster
- Small collections, where copying a flat table is already cheap
- Iteration-heavy or lookup-heavy code without copies: the tree walk adds a constant factor

## How it is fast

Elements live in a compressed hash-array mapped prefix tree whose nodes hold up to 32 items and are reference counted individually. Mutating a shared copy copies only the nodes on the path to the changed item, and set operations between related versions skip shared subtrees without visiting their items. The design is Michael Steindorfer's CHAMP, contributed to the package by him and finished by Karoy Lorentey.

## What it costs

- 2-8x slower inserts than Set when not sharing storage; more memory than Set at large counts according to the authors
- Indices are invalidated by every mutation, even value-only updates
- Values view is not a MutableCollection

## Problems with the evidence

- The five-hour Set figure is phrased as 'would have taken', which suggests it was extrapolated from the per-iteration chart rather than run to completion.
- Detailed numbers are in chart images (model diffing, sequential iteration, insert); hardware, OS and Swift version are not stated.
- Measured in November 2022 on the pre-release ShareableSet code (later renamed TreeSet) before the 1.1.0 release; the authors expected 30-40% insertion improvements after that.
- The workload is chosen to show the benefit; the authors say so and publish the counter-case.

## Evidence

<details>
<summary>5 quotes from the sources, checked 2026-10-28</summary>

> For a million items, the code that uses `Set` would have taken roughly five hours to run; the variant that uses `ShareableCode` runs in about two seconds!
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Reviews/…](https://github.com/apple/swift-collections/blob/main/Documentation/Reviews/2022-10-31.ShareableHashedCollections/ShareableHashedCollections.md)

> Over the entire spread of item counts from 1 to a million, `Set` goes from 100ns to >10ms spent in each iteration -- an increase of five orders of magnitude, corresponding to a linear growth rate. Meanwhile `PeristentSet`'s growth is kept nicely logarithmic: its 8-10x growth factor is far removed from the growth rate of its input data.
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Reviews/…](https://github.com/apple/swift-collections/blob/main/Documentation/Reviews/2022-10-31.ShareableHashedCollections/ShareableHashedCollections.md)

> This boosts the performance of shared mutations from linear to logarithmic time
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Reviews/…](https://github.com/apple/swift-collections/blob/main/Documentation/Reviews/2022-10-31.ShareableHashedCollections/ShareableHashedCollections.md)

> 2-8 times slower
>
> — [forums.swift.org/t/api-review-for-1-1-hash-array-mapped-prefix-tree…](https://forums.swift.org/t/api-review-for-1-1-hash-array-mapped-prefix-trees/61151?page=3)

> I expect a uniquely held flat hash table with pre-reserved capacity will win an insertion race against any persistent data structure, and it won't even break much sweat doing it.
>
> — [forums.swift.org/t/api-review-for-1-1-hash-array-mapped-prefix-tree…](https://forums.swift.org/t/api-review-for-1-1-hash-array-mapped-prefix-trees/61151?page=3)

</details>
