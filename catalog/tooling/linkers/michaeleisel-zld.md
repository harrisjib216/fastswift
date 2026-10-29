# zld

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md) › [Linkers](README.md)</sub>

**Tier C** (first-party numbers) · ❌ Doesn't hold up · Open source · `C++` · `MIT` · 🔴 abandoned

> Archived fork of ld64 that linked about 40% faster in 2020; lld and then Xcode 15's ld-prime overtook it.

| | |
|---|---|
| **Beats** | ld64 from Xcode 11-13 |
| **Claimed result** | Linking at least 40% faster than ld64; Mozilla XUL 5.2s vs 2.20s, Signal 390 vs 250 ms, Firefox Storage.framework 495 vs 340 ms on a high-end Mac desktop (about 2.4x, 1.6x and 1.5x, derived from page data) |
| **Workload** | Linking Signal-iOS's app binary, Firefox's XUL framework and firefox-ios's Storage.framework, debug-style link commands |
| **Metric** | time |
| **Hardware** | 'High-end mac desktop' (unspecified); a 2014 MacBook Pro for a second set of runs |
| **Toolchain** | Xcode 11-era ld64 (iPhoneSimulator13.2 and MacOSX10.14 SDKs in the commands) |
| **Measured** | 2020 |
| **Adoption** | 1.2k stars |
| **Last commit** | 2023-02-15 |
| **Platforms** | macOS |
| **Install** | Prebuilt binary from GitHub releases; -fuse-ld in Other Linker Flags |
| **Links** | [repository](https://github.com/michaeleisel/zld) · [benchmark](https://github.com/michaeleisel/zld/blob/master/misc/benchmarks.md) |

## Verdict

zld was about 40% faster than the ld64 of 2019-2020, but it is archived, never supported an Xcode 14 change, and its author says better-funded linkers caught up and surpassed it in 2022. ld-prime, the default since Xcode 15, is now faster than LLD, which had already passed zld. The default caught up.

**Why tier C:** First-party numbers with the linker command lines published, but only 'a high-end mac desktop' as hardware, columns unlabeled in the text, and Xcode 11-era SDKs.

## Use it when

- Only for historical comparison; there is no current toolchain where it is the fastest working option

## Skip it when

- Xcode 14 and later: the author did not add support for an Xcode 14 change and archived the project
- Release builds: the README says it was only intended for debug builds

## How it is fast

zld kept ld64's code but swapped STL hash maps for Swiss Tables, parallelized library parsing, sorting and output writing, and cached string hashes. It also stored file metadata in /tmp to reuse across links.

## What it costs

- Lags Apple's linker features because it forks the last open-sourced ld64
- Silently falls back to Apple's ld for some targets such as arm64_32 and Catalyst

## Problems with the evidence

- misc/benchmarks.md lists two numbers per project without saying which is ld64 and which is zld; the smaller is presumably zld
- Benchmarks used Xcode 11-era SDKs, before Apple's Xcode 14 ld64 speedups and the Xcode 15 rewrite
- Hardware is described only as 'a high-end mac desktop'; the README's chart is an image

## Evidence

<details>
<summary>6 quotes from the sources, checked 2026-10-28</summary>

> zld is now archived, consider using lld instead.
>
> — [github.com/michaeleisel/zld](https://github.com/michaeleisel/zld)

> Feel free to file an issue if you find that linking is not at least 40% faster for your case
>
> — [github.com/michaeleisel/zld](https://github.com/michaeleisel/zld)

> high-end mac desktop numbers (ms): signal: 390, 250 mozilla XUL: 5.2s, 2.20s mozilla's storage.framework: 495, 340
>
> — [github.com/michaeleisel/zld/blob/master/misc/benchmarks.md](https://github.com/michaeleisel/zld/blob/master/misc/benchmarks.md)

> it ended up being about 40% faster than ld64
>
> — [eisel.me/lld](https://eisel.me/lld)

> better-funded projects had caught up and surpassed it in 2022
>
> — [eisel.me/lld](https://eisel.me/lld)

> Recent benchmarks show that Apple's new linker (ld-prime) is faster than LLD for local macOS development
>
> — [github.com/chromium/chromium/blob/13b8fd8fc88ffeea53b0ae5d07d82c5cf…](https://github.com/chromium/chromium/blob/13b8fd8fc88ffeea53b0ae5d07d82c5cfd2f03df/docs/apple_platform_linkers.md)

</details>
