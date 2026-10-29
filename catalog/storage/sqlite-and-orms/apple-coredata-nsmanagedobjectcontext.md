# Core Data (used directly instead of SwiftData)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Storage](../README.md) › [SQLite and object stores](README.md)</sub>

**Tier D** (directional only) · 🟡 Holds up in part · Ships with Apple's SDKs · `Objective-C` · `Apple SDK` · 🟢 active

> Using Core Data directly skips SwiftData's model layer; developers report fetches about 20x faster, but only anecdotally.

| | |
|---|---|
| **Beats** | SwiftData @Model objects (iOS 17) |
| **Claimed result** | Fetch/query: 'around 1ms in CoreData' vs 'around 20ms' in SwiftData; creating ~30,000 @Model instances: '90+ seconds' vs 3 seconds without the @Model macro and in the earlier Core Data version; iOS 18 beta: SwiftData 'memory usage was still double that of CoreData'. |
| **Workload** | Instantiating @Model objects (15 scalar properties) from a ~30,000-line CSV; fetch/query calls profiled with Instruments in an app migrating from Core Data. |
| **Metric** | time, memory |
| **Measured** | 2023-11-29 |
| **Platforms** | iOS, macOS, tvOS, watchOS, visionOS |
| **Install** | built into iOS and macOS |
| **Links** | [documentation](https://developer.apple.com/documentation/coredata) · [benchmark](https://forums.swift.org/t/creating-instances-of-swiftdata-models-very-slow/68680) |

## Verdict

Developer reports from late 2023 put SwiftData far behind Core Data: fetches of about 1 ms in Core Data taking about 20 ms, and a 30,000-row import taking 90+ seconds against 3 seconds. These are anecdotes without code or build settings, and one developer saw much less lag on the iOS 18 beta, though memory stayed at double Core Data's.

**Why tier D:** Forum and blog reports with numbers but no published code, device, OS build or compiler settings.

## Use it when

- Bulk imports or tight fetch loops where per-object model overhead shows up in profiles
- Apps that still support iOS 16 or earlier
- Work that suits NSBatchInsertRequest and other batch requests

## Skip it when

- Small data sets where the per-object overhead is not measurable
- Teams that value SwiftData's macro models and @Query more than raw speed

## How it is fast

SwiftData sits on top of Core Data: every @Model instance carries macro-generated accessors, a backing-data object and an observation registrar, and a reply in the same thread says its in-memory storage keeps values in a Dictionary. NSManagedObject subclasses skip that layer, and Core Data adds batch insert, update and delete requests that write without creating objects at all.

## What it costs

- Older API: NSManagedObject subclasses, contexts and threading rules
- More boilerplate in SwiftUI than @Model and @Query

## Problems with the evidence

- No device, OS build or Debug/Release setting is given; a reply asks whether the poster used a Release build
- Reports date from iOS 17.x; SwiftData internals changed in later releases and one developer reports much less lag on the iOS 18 beta
- No controlled, reproducible SwiftData vs Core Data benchmark was found

## Evidence

<details>
<summary>5 quotes from the sources, checked 2026-10-28</summary>

> This takes around 90+ seconds to complete.
>
> — [forums.swift.org/t/creating-instances-of-swiftdata-models-very-slow…](https://forums.swift.org/t/creating-instances-of-swiftdata-models-very-slow/68680)

> The loop takes 3 seconds.
>
> — [forums.swift.org/t/creating-instances-of-swiftdata-models-very-slow…](https://forums.swift.org/t/creating-instances-of-swiftdata-models-very-slow/68680)

> In previous version of my app using core data loop took 3 seconds also.
>
> — [forums.swift.org/t/creating-instances-of-swiftdata-models-very-slow…](https://forums.swift.org/t/creating-instances-of-swiftdata-models-very-slow/68680)

> Profiling with the instrument showed that operations (e.g. Fetch/Query) that took around 1ms in CoreData take around 20ms now.
>
> — [forums.swift.org/t/creating-instances-of-swiftdata-models-very-slow…](https://forums.swift.org/t/creating-instances-of-swiftdata-models-very-slow/68680)

> I did, and while there was much less lag, memory usage was still double that of CoreData.
>
> — [mjtsai.com/blog/2024/10/16/returning-to-core-data/](https://mjtsai.com/blog/2024/10/16/returning-to-core-data/)

</details>
