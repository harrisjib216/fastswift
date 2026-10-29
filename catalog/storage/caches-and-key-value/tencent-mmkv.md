# MMKV

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Storage](../README.md) › [Caches and key-value stores](README.md)</sub>

**Tier D** (directional only) · 🟡 Holds up in part · Open source · `C++ + Objective-C` · `NOASSERTION` · 🟢 active

> mmap-backed key-value store from WeChat; much faster than NSUserDefaults for bulk writes in a vendor chart, on par for reads.

| | |
|---|---|
| **Beats** | NSUserDefaults (UserDefaults.standard) |
| **Claimed result** | Text: MMKV beats NSUserDefaults on writes and 'equals or outranges NSUserDefaults on reading values', each operation repeated 1w (10,000) times; the README's chart covers 'Writing random `int` for 10000 times'. Values appear only in the chart image. |
| **Workload** | 10,000 sequential writes, then reads, of random ints and of strings under distinct keys in the MMKVDemo app; the NSUserDefaults write loop calls synchronize once at the end. |
| **Metric** | time |
| **Hardware** | iPhone 11 Pro Max 64 GB |
| **OS** | iOS 13.3.1 |
| **Adoption** | 18.8k stars |
| **Last commit** | 2026-10-16 |
| **Platforms** | iOS, macOS, Android, Windows, POSIX, HarmonyOS NEXT |
| **Install** | CocoaPods |
| **Links** | [repository](https://github.com/Tencent/MMKV) · [benchmark](https://github.com/Tencent/MMKV/wiki/iOS_benchmark) |

## Verdict

Tencent's chart shows a large write advantage over NSUserDefaults for 10,000 writes, but the page itself says reads only equal or exceed NSUserDefaults, the figures exist only as chart labels, and the run is on iOS 13.3.1.

**Why tier D:** First-party results that appear only in a chart image; the page text is directional.

## Use it when

- Many small writes in loops or on hot paths, where NSUserDefaults' per-write cost dominates
- Sharing key-value data between an app and its extensions with MMKV's multi-process mode

## Skip it when

- Read-mostly settings: reads are published as on par with NSUserDefaults
- You need Settings.bundle, @AppStorage, key-value observation or managed app configuration, which are tied to UserDefaults

## How it is fast

MMKV memory-maps its file, so a write is an append into mapped memory that the kernel flushes later, with no round trip to the cfprefsd daemon and no property-list re-serialization. Values are protobuf-encoded and appended; the file is rewritten only when it fills and needs compaction.

## What it costs

- Adds a C++ library to the app
- Data in mapped pages that the kernel has not flushed can be lost on sudden power loss
- GitHub does not detect the license (NOASSERTION); the license file combines Tencent's BSD 3-Clause terms with notices for bundled code

## Problems with the evidence

- Numbers exist only in a chart image; read from its labels (not page text): write int 8 vs 3728.5 ms, write string 17.75 vs 4247.75 ms, read int 1.5 vs 9 ms, read string 3.5 vs 8.25 ms
- iOS 13.3.1 on an iPhone 11 Pro Max; no newer iOS measurement found
- Benchmark date not stated; build configuration not stated
- Vendor benchmark of a sequential microbenchmark; real apps rarely write 10,000 keys in a row

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> We test MMKV side-by-side with NSUserDefaults, repeating each operation 1w times.
>
> — [raw.githubusercontent.com/wiki/Tencent/MMKV/iOS_benchmark.md](https://raw.githubusercontent.com/wiki/Tencent/MMKV/iOS_benchmark.md)

> while equals or outranges NSUserDefaults on reading values.
>
> — [raw.githubusercontent.com/wiki/Tencent/MMKV/iOS_benchmark.md](https://raw.githubusercontent.com/wiki/Tencent/MMKV/iOS_benchmark.md)

> Running on iPhone 11 Pro Max 64G, iOS 13.3.1. Repeating each operation 1w times. Counting in milliseconds.
>
> — [raw.githubusercontent.com/wiki/Tencent/MMKV/iOS_benchmark.md](https://raw.githubusercontent.com/wiki/Tencent/MMKV/iOS_benchmark.md)

> Writing random `int` for 10000 times, we get this chart:
>
> — [github.com/Tencent/MMKV/blob/master/README.md](https://github.com/Tencent/MMKV/blob/master/README.md)

</details>
