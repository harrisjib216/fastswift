# YYCache (YYMemoryCache, YYDiskCache)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Storage](../README.md) › [Caches and key-value stores](README.md)</sub>

**Tier D** (directional only) · 🟡 Holds up in part · Open source · `Objective-C` · `MIT` · 🔴 abandoned

> Objective-C memory and SQLite-backed disk cache; 2015 charts show it ahead of NSCache and file caches, numbers chart-only.

| | |
|---|---|
| **Beats** | NSCache, PINCache, and one-file-per-value disk caches |
| **Claimed result** | Directional only: NSCache 的写入性能稍差，读取性能不错 (NSCache writes are somewhat slower, reads are good); for small values (NSNumber) YYDiskCache 的性能远远高出基于文件存储的库 (far faster than file-based caches); measured on an iPhone 6. |
| **Workload** | Single-threaded set, get and miss throughput for memory caches; reads and writes of small (NSNumber) and larger values for disk caches. |
| **Metric** | throughput (queries per second) |
| **Hardware** | iPhone 6 (64 GB) |
| **Measured** | 2015-10-26 |
| **Adoption** | 2.4k stars |
| **Last commit** | 2017-08-06 |
| **Platforms** | iOS 6+ |
| **Install** | CocoaPods, Carthage |
| **Links** | [repository](https://github.com/ibireme/YYCache) · [benchmark](https://blog.ibireme.com/2015/10/26/yycache/) |

## Verdict

The 2015 iPhone 6 charts show YYMemoryCache ahead of NSCache and PINMemoryCache, and YYDiskCache far ahead of file-based caches for small values. But the numbers are chart-only, the memory cache was measured while it used OSSpinLock (the current code uses pthread_mutex), and the project has had no commits since 2017.

**Why tier D:** First-party results only in chart images; the blog text is directional.

## Use it when

- Maintaining existing Objective-C code that already uses it
- Disk caches holding many small values, where the SQLite-backed store had its largest lead

## Skip it when

- New Swift code: unmaintained since 2017 and Objective-C only
- Large values: the author reports file-based and SQLite-based storage converge for larger data

## How it is fast

YYMemoryCache is an LRU cache built from a doubly linked list and a CFDictionary, accessed synchronously under one lock instead of through dispatch queues and async callbacks as in TMCache and PINCache. YYDiskCache keeps small values inline in SQLite and larger ones as files with their metadata in SQLite, so small reads and writes avoid per-file system calls.

## What it costs

- Objective-C API, CocoaPods or Carthage only
- Unmaintained: no fixes for current iOS releases

## Problems with the evidence

- Numbers exist only in chart images; read from the memory chart, YYMemoryCache's set rate is roughly twice NSCache's
- 2015 measurements on an iPhone 6 with the NSCache of that iOS era
- The measured YYMemoryCache used OSSpinLock, which Apple deprecated in iOS 10 because of priority inversion; the current code uses pthread_mutex and has not been re-measured
- In the same chart NSDictionary guarded by a lock beats every cache, YYMemoryCache included

## Evidence

<details>
<summary>3 quotes from the sources, checked 2026-10-28</summary>

> NSCache 的写入性能稍差，读取性能不错；
>
> — [blog.ibireme.com/2015/10/26/yycache/](https://blog.ibireme.com/2015/10/26/yycache/)

> 我的 YYDiskCache 也是采用的 SQLite 配合文件的存储方式，在 iPhone 6
>
> — [blog.ibireme.com/2015/10/26/yycache/](https://blog.ibireme.com/2015/10/26/yycache/)

> 在存取小数据 (NSNumber) 时，YYDiskCache 的性能远远高出基于文件存储的库；而较大数据的存取性能则比较接近了。
>
> — [blog.ibireme.com/2015/10/26/yycache/](https://blog.ibireme.com/2015/10/26/yycache/)

</details>
