# swift-collections (Deque)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Collections](../README.md) › [Deques and queues](README.md)</sub>

**Tier A** (reproducible public benchmark) · ✅ Holds up · Open source · `Swift` · `Apache-2.0` · 🟢 active

> Apple's ring-buffer double-ended queue; constant-time prepend and popFirst where Array.insert(at: 0) and removeFirst are linear.

| | |
|---|---|
| **Beats** | Swift Array used as a queue, inserting at the front with insert(_:at: 0) (capacity reserved up front) |
| **Claimed result** | Prepending Ints one at a time: at 131072 items the fastest run took 0.89 s for Array vs 0.000508 s for Deque, about 1,750x (derived from page data); at 1024 items 0.0000375 s vs 0.00000401 s, about 9.4x (derived from page data). Cost: random-offset reads over 1048576 items took 0.00546 s on Deque vs 0.00533 s on Array, about 2% slower (derived from page data). Times rounded to three significant figures from the raw results. |
| **Workload** | Int elements; n prepends into an empty collection with capacity reserved (Array uses insert(i, at: 0)), and n subscript reads at random offsets; sizes 1 to 16M, 20 cycles; values above are the fastest recorded run per size, total seconds for the whole task. |
| **Metric** | time |
| **Hardware** | 2017 iMac Pro |
| **Toolchain** | Release build (swift run -c release via Utils/run-benchmarks.sh); Swift version not stated (results committed April 2021, Swift 5.4 era) |
| **Measured** | 2021-04-05 |
| **Adoption** | 4.5k stars |
| **Last commit** | 2026-10-27 |
| **Platforms** | All Swift platforms: iOS, macOS, tvOS, watchOS, visionOS, Linux, Windows |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/apple/swift-collections) · [benchmark](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json) |

## Verdict

In Apple's published raw data, prepending to a Deque stays flat per element while Array.insert(at: 0) grows linearly, reaching a gap of about 1,750x at 131,072 items. The cost is also in the data: random-access reads on a Deque are a few percent slower than on an Array at large sizes.

**Why tier A:** The benchmark library definition, run script (release build flags in Utils/run-benchmarks.sh) and raw results are in the repository, and the announcement post states the machine; only the Swift toolchain version is unstated.

## Use it when

- FIFO queues or work lists where elements are added at one end and removed at the other (BFS, schedulers, sliding windows)
- Any loop that calls insert(_:at: 0) or removeFirst() on an Array of more than a few hundred elements
- Undo/redo or history buffers that trim from the front

## Skip it when

- The collection is only appended to and read: Array is a little faster for random access and is contiguous
- Code needs withUnsafeBufferPointer or contiguous storage for C or SIMD APIs; Deque storage can wrap around
- Queues of a handful of elements, where the measured gap at 28 items is small

## How it is fast

Deque stores elements in a circular buffer with a movable start index, so inserting or removing at the front only moves the start index instead of shifting every element. Array keeps elements contiguous from index 0, so every insert(at: 0) or removeFirst() moves the whole array. Deque keeps Array-style copy-on-write value semantics and integer indices.

## What it costs

- Storage is discontiguous, so there is no contiguous-buffer access and random reads cost a few percent more than Array
- Adds a package dependency (DequeModule)

## Problems with the evidence

- The announcement charts are images; the numbers here come from the raw results.json committed alongside them, using the fastest of the recorded runs per size, while the charts plot the 90th percentile.
- Measured in 2021 on an Intel iMac Pro with an unstated Swift 5.x toolchain; Apple Silicon and newer compilers were not measured.
- The Array baseline is insert(at: 0); Array.removeFirst(), the other common queue pattern, was not benchmarked here but has the same linear cost.
- First-party benchmark by the library's authors.

## Evidence

<details>
<summary>11 quotes from the sources, checked 2026-10-28</summary>

> "title":"Array<Int> prepend, reserving capacity"
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> "131072":[0.89034683400000003
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> "131072":[0.00050841700000000027
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> "1024":[3.7537999999999999e-05
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> "1024":[4.0102600000000001e-06
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> "title":"Deque<Int> subscript get, random offsets (discontiguous)"
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> "1048576":[0.0054579769999999984
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> "1048576":[0.0053294390000000001
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Announce…](https://github.com/apple/swift-collections/blob/main/Documentation/Announcement-benchmarks/results.json)

> were run on my 2017 iMac Pro.
>
> — [swift.org/blog/swift-collections/](https://www.swift.org/blog/swift-collections/)

> This tends to make them work slightly slower than arrays for use cases that don’t call for inserting/removing elements at the front – so it’s probably not a good idea to blindly replace all your arrays with deques.
>
> — [swift.org/blog/swift-collections/](https://www.swift.org/blog/swift-collections/)

> Mutations near the front are expected to be significantly faster in deques, but arrays may measure slightly faster for general random-access lookups.
>
> — [github.com/apple/swift-collections/blob/main/Documentation/Deque.md](https://github.com/apple/swift-collections/blob/main/Documentation/Deque.md)

</details>
