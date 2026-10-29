# swift-collections (OrderedSet)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Collections](../README.md) › [Ordered and sorted collections](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Open source · `Swift` · `Apache-2.0` · 🟢 active

> Apple's ordered hashed set: Array order with constant-time membership, replacing contains() scans over arrays.

| | |
|---|---|
| **Beats** | Swift Array used as a unique ordered list, checked with Array.contains before insert |
| **Claimed result** | Looking up every element once: at 57344 items the fastest run took 0.789 s with Array.contains vs 0.00156 s with OrderedSet.contains, about 505x (derived from page data); at 1024 items 0.00024 s vs 0.0000218 s, about 11x (derived from page data). Cost: Set.contains took 0.000843 s at 57344 items, so OrderedSet lookups are about 1.85x slower than Set (derived from page data), and appending 1048576 items took 0.0859 s vs 0.0296 s for Set.insert, about 2.9x slower (derived from page data). Times rounded to three significant figures from the raw results. |
| **Workload** | Int elements; build the collection, then look up every element once in shuffled order (successful contains); separately append n unique Ints with capacity reserved; sizes up to 16M (Array lookups stop at 65,536 because they are quadratic). |
| **Metric** | time |
| **Hardware** | 2017 iMac Pro |
| **Toolchain** | Release build (swift run -c release via Utils/run-benchmarks.sh); Swift version not stated (April 2021, Swift 5.4 era) |
| **Measured** | 2021-04-05 |
| **Adoption** | 4.5k stars |
| **Last commit** | 2026-10-27 |
| **Platforms** | All Swift platforms: iOS, macOS, tvOS, watchOS, visionOS, Linux, Windows |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/apple/swift-collections) · [benchmark](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json) |

## Verdict

OrderedSet beats Array.contains by 11x at 1,024 items and about 500x at 57,344 items, which is the published comparison. It is slower than a plain Set for both lookups and inserts, and nothing published compares it with an Array plus Set kept in sync or with NSOrderedSet, the patterns people actually use when they need order and uniqueness.

**Why tier A:** Benchmark definitions, run script with release flags, raw results and the stated machine are all public; first-party and toolchain version unstated.

## Use it when

- An Array is deduplicated with contains() before every append and grows past a few hundred elements
- Order matters and lookups are frequent: recent-items lists, tag lists, ordered unique IDs
- Replacing a hand-maintained Array plus Set pair, mainly for correctness and memory (elements stored once)

## Skip it when

- Order does not matter: Set is about 1.85x faster to query and about 2.9x faster to fill in the same data
- Frequent inserts or removals in the middle or front: those are linear, like Array
- Elements are not Hashable

## How it is fast

OrderedSet keeps elements in a plain Array and builds a compact open-addressing hash table that stores only integer offsets into that array. Membership tests hash once and probe the table instead of scanning the array. Small sets skip the hash table and scan linearly, which is faster below a few dozen elements.

## What it costs

- Slower than Set for lookup and insertion because of the extra indirection through the element array
- Insertion or removal at arbitrary positions is O(n)
- Not a MutableCollection or RangeReplaceableCollection (swaps and sorts are provided as methods)

## Problems with the evidence

- Chart-only in the announcement; numbers are the fastest runs from the raw results.json, while the charts show the 90th percentile.
- The OrderedSet rows in results.json hold only 1 or 2 samples per size, while the Array and Set rows hold 11 to 281, so the OrderedSet figures are less stable.
- The baseline is a linear Array scan, which is the weakest possible competitor; no published comparison with Array plus Set kept in sync, or with NSOrderedSet.
- Measured in 2021 on an Intel iMac Pro; first-party.

## Evidence

<details>
<summary>9 quotes from the sources, checked 2026-10-28</summary>

> "title":"OrderedSet<Int> successful contains"
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> "57344":[0.78925788600000002
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> "57344":[0.001561219
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> "57344":[0.00084319399999999969
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> "1024":[0.00023982100000000001
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> "1024":[2.1804999999999999e-05
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> "1048576":[0.085868664999999983
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> "1048576":[0.029597386
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> were run on my 2017 iMac Pro.
>
> — [swift.org/blog/swift-collections/](https://www.swift.org/blog/swift-collections/)

</details>
