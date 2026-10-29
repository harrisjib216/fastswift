# Bodega (SQLiteStorageEngine)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Storage](../README.md) › [Caches and key-value stores](README.md)</sub>

**Tier C** (first-party numbers) · ✅ Holds up · Open source · `Swift` · `MIT` · 🟢 active

> Key-value store whose SQLite engine loads 1,000 objects in about 0.1 s against 0.25 s for one-file-per-object storage.

| | |
|---|---|
| **Beats** | One file per object on disk (Bodega's DiskStorageEngine, the plain FileManager write pattern) |
| **Claimed result** | Loading 1,000 objects: about 0.1 seconds with SQLiteStorageEngine vs about 0.25 seconds with DiskStorageEngine (2.5x, derived from page data); larger counts appear only in charts. |
| **Workload** | Reading (initializing from storage) and writing 1,000 to 10,000 small objects stored as Data blobs keyed by CacheKey. |
| **Metric** | time |
| **Adoption** | 377 stars |
| **Last commit** | 2026-06-24 |
| **Platforms** | iOS 13+, macOS 11+, tvOS 13+ |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/mergesort/Bodega) · [benchmark](https://mergesort.github.io/Bodega/documentation/bodega/using-storageengines) |

## Verdict

The docs give about 0.1 s against 0.25 s to load 1,000 objects and say the gap grows with object count, which the charts show widening into the thousands. The result matches the known cost of per-file system calls, though it is the author's own comparison of two of his engines.

**Why tier C:** First-party figures stated as a rule of thumb, with charts but no device, OS or build configuration.

## Use it when

- Persisting thousands of small Codable objects or blobs (API responses, app state) with a simple key-value API
- Replacing hand-rolled one-file-per-object caches whose launch time grows with object count

## Skip it when

- Large blobs such as full-size images, where individual files avoid SQLite page overhead
- You need to inspect or sync the stored files with ordinary file tools

## How it is fast

SQLiteStorageEngine keeps every object as a row in one SQLite database (through SQLite.swift), so a batch read or write is a few statements in one transaction. One-file-per-object storage pays an open, read or write, and close (plus directory updates) for every object, and that cost grows with the number of files.

## What it costs

- Adds SQLite.swift as a dependency
- Stored data is opaque without an SQLite viewer

## Problems with the evidence

- A comparison between Bodega's own two engines, not against hand-written FileManager code
- The text figures are an approximate 'rule of thumb'; per-count values are only in charts
- No device, OS or build configuration given

## Evidence

<details>
<summary>2 quotes from the sources, checked 2026-10-28</summary>

> a rule of thumb is that loading 1,000 objects from disk takes about 0.25 seconds
>
> — [github.com/mergesort/Bodega/blob/main/Sources/Bodega/Documentation.…](https://github.com/mergesort/Bodega/blob/main/Sources/Bodega/Documentation.docc/Articles/Fundamentals/Using%20StorageEngines.md)

> By comparison if you're using ``SQLiteStorageEngine`` it only takes about 0.1 seconds to load 1,000 objects, the difference only growing more the more objects you have.
>
> — [github.com/mergesort/Bodega/blob/main/Sources/Bodega/Documentation.…](https://github.com/mergesort/Bodega/blob/main/Sources/Bodega/Documentation.docc/Articles/Fundamentals/Using%20StorageEngines.md)

</details>
