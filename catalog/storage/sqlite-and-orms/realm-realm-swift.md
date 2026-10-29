# Realm Swift

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Storage](../README.md) › [SQLite and object stores](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Open source · `Swift + C++` · `Apache-2.0` · 🟢 active

> Embedded object database with its own engine; 3-6x faster than SwiftData on large writes but over 10x slower on relationship queries.

| | |
|---|---|
| **Beats** | SwiftData (iOS 17) and Core Data |
| **Claimed result** | Against SwiftData: writes 'about 3-6x faster beyond write volumes exceededing 1,000 objects'; SwiftData objects took 'around 10x longer to instantiate'; Realm used 'about 1/3 as much memory' at high volume; SwiftData was 'usually more than 10x faster' on relationship queries. Against Core Data (GRDB harness, macOS): fetch 0.10 vs 0.45 (4.5x, derived from page data), insert 0.46 vs 0.40 (Core Data 15% faster, derived from page data). |
| **Workload** | Emerge: create, write, query, update and delete simple User objects (4 fields) and Student objects with School and Grade relationships, from small counts up to 1-2 million simple or ~200,000 complex objects. GRDB: fetch 200,000 and insert 50,000 objects of 10 integer properties. |
| **Metric** | time, memory |
| **Hardware** | iPhone 15 Pro (Emerge); MacBookPro18,1 (GRDB harness) |
| **Toolchain** | -Os (Emerge); Xcode 16.2, Release test configuration (GRDB harness) |
| **Measured** | 2024-06-19 |
| **Adoption** | 16.6k stars |
| **Last commit** | 2026-09-26 |
| **Platforms** | iOS, macOS, tvOS, watchOS |
| **Install** | Swift Package Manager, CocoaPods |
| **Links** | [repository](https://github.com/realm/realm-swift) · [benchmark](https://www.emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison) |

## Verdict

An independent iPhone 15 Pro test found Realm 3-6x faster than SwiftData for writes above 1,000 objects and using about a third of the memory at high volume, but SwiftData was usually more than 10x faster for queries across relationships and faster for updates at 10,000 items or fewer. GRDB's harness shows the same split against Core Data: Realm fetched faster (0.10 vs 0.45) but inserted slower (0.46 vs 0.40).

**Why tier A:** Third-party benchmark with public code (jacobsapps/RealmVsSwiftData) and raw results, run on an iPhone 15 Pro at the -Os optimization level.

## Use it when

- Writing thousands to millions of simple objects at once
- Memory-constrained work on large data sets, where Realm used about a third of SwiftData's peak memory
- Supporting iOS versions older than 17, which SwiftData does not

## Skip it when

- Queries that filter across relationships, where SwiftData was usually more than 10x faster
- Small writes of 1,000 objects or fewer, where SwiftData won

## How it is fast

Realm uses its own storage engine instead of SQLite and memory-maps the file, so reads return live objects backed directly by the mapped data without copying rows into new objects. Objects are light to create compared with SwiftData @Model instances, which carry backing data and observation state. Queries that traverse relationships do not benefit as much, which is where SwiftData's Core Data base wins.

## What it costs

- About 2.2 MB of Realm libraries in the app binary, per Emerge's size analysis
- Every modification must happen inside a write transaction; objects are tied to their thread or actor
- Proprietary file format that SQLite tools cannot open

## Problems with the evidence

- Most per-size results are in charts; the article text gives ratios, with raw numbers in a linked spreadsheet
- Neither the iOS version nor the Xcode version is stated
- Peak memory was read by eye from Xcode's memory gauge
- The object initializers do random generation that the author calls inefficient, inflating instantiation times on both sides
- Core Data itself is not measured by Emerge; the Core Data numbers come from GRDB's macOS harness

## Evidence

<details>
<summary>10 quotes from the sources, checked 2026-10-28</summary>

> Experiments are run live on an iPhone 15 Pro with -Os optimisation level to create a production-like environment.
>
> — [emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison](https://www.emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison)

> Realm was about 3-6x faster beyond write volumes exceededing 1,000 objects.
>
> — [emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison](https://www.emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison)

> These show that the SwiftData objects took around 10x longer to instantiate.
>
> — [emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison](https://www.emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison)

> We observed the opposite effect: SwiftData was usually more than 10x faster than Realm.
>
> — [emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison](https://www.emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison)

> SwiftData appeared to have a lower memory baseline, however at higher volume, Realm took up about 1/3 as much memory as SwiftData.
>
> — [emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison](https://www.emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison)

> Realm was a lot quicker than SwiftData in most instances, however, with smaller numbers of objects (≤1000), SwiftData won.
>
> — [emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison](https://www.emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison)

> At smaller volumes (≤10,000 items, which covers the vast majority of mobile use cases), SwiftData was also a lot faster when updating existing data.
>
> — [emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison](https://www.emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison)

> the majority of storage space taken up by 2.2MB of Realm libraries
>
> — [emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison](https://www.emergetools.com/blog/posts/swiftdata-vs-realm-performance-comparison)

> | Fetch | 0.24 | ¹ | ¹ | ¹ | 0.45 | 0.10 |
>
> — [raw.githubusercontent.com/wiki/groue/GRDB.swift/Performance.md](https://raw.githubusercontent.com/wiki/groue/GRDB.swift/Performance.md)

> | Insert | 0.36 | ¹ | ¹ | ¹ | 0.40 | 0.46 |
>
> — [raw.githubusercontent.com/wiki/groue/GRDB.swift/Performance.md](https://raw.githubusercontent.com/wiki/groue/GRDB.swift/Performance.md)

</details>
