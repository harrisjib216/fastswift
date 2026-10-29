# ld-prime (Xcode 15+ linker)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md) › [Linkers](README.md)</sub>

**Tier B** (independent measurement) · ✅ Holds up · Ships with Apple's SDKs · `Xcode toolchain` · `Apple SDK` · 🟢 active

> Apple's rewritten linker, default since Xcode 15: up to 5x faster than ld64 per Apple, and 4-6x faster than LLD in Chromium's builds.

| | |
|---|---|
| **Beats** | ld64, Apple's linker in Xcode 14 and earlier (Chromium's comparison is against LLD, which beat ld64) |
| **Claimed result** | Linking up to five times faster than ld64 and debug binaries up to 30% smaller (Apple); up to a 4-6x speedup over LLD for local arm64 macOS Chromium builds (Chromium's current linker doc) |
| **Workload** | Apple: unspecified app links. Chromium: linking Chromium in local, non-cross, non-ThinLTO macOS builds on arm64 Macs. |
| **Metric** | time |
| **Hardware** | Apple silicon Macs (Chromium: arm64 Macs only) |
| **OS** | macOS |
| **Toolchain** | Xcode 15 and later |
| **Measured** | 2026-06 |
| **Platforms** | macOS host; links binaries for iOS, macOS, tvOS, watchOS and visionOS |
| **Install** | built into Xcode 15+ |
| **Links** | [documentation](https://developer.apple.com/documentation/xcode-release-notes/xcode-15-release-notes) · [benchmark](https://github.com/chromium/chromium/blob/13b8fd8fc88ffeea53b0ae5d07d82c5cfd2f03df/docs/apple_platform_linkers.md) |

## Verdict

Apple claims linking up to 5x faster than ld64. Chromium, which has no stake in Apple's linker and defaults to LLD, now documents ld-prime as faster than LLD with up to a 4-6x speedup on arm64 Macs, and LLD was itself about 2x faster than post-Xcode 14.1 ld64.

**Why tier B:** Chromium's build documentation gives an independent ratio; Apple's own 5x figure comes with no project, workload or hardware.

## Use it when

- Any Xcode 15+ project: it is already the default, so there is nothing to adopt
- Teams that switched to lld or zld for link speed under Xcode 14: re-measure, because ld-prime now beats LLD on Apple silicon in Chromium's builds
- Large debug builds where link time dominates the incremental build

## Skip it when

- Cross-compiling Apple binaries from Linux: ld-prime only runs on macOS
- Build setups that need the linker and compiler at the same LLVM revision for LTO; Chromium keeps LLD for this reason

## How it is fast

Apple describes it only as redesigned from the ground up and has not published a design. The Xcode 14 work on ld64 that came just before it focused on using more cores and hardware-accelerated hashing for the binary UUID. ld-prime is also the linker that made mergeable libraries possible.

## What it costs

- Closed source and shipped only with Xcode, so fixes wait for Xcode releases
- LTO goes through a linker plugin rather than sharing libraries with the compiler, which Chromium calls a more complex setup

## Problems with the evidence

- Apple's 'up to five times faster' is from the WWDC23 Platforms State of the Union with no project, workload or hardware named
- Chromium's 4-6x is a ratio against LLD, not ld64, with no raw timings or machine listed in the doc; it covers only local arm64 macOS builds without ThinLTO
- Chromium still defaults to LLD for control and toolchain uniformity, so speed was not the deciding factor there

## Evidence

<details>
<summary>5 quotes from the sources, checked 2026-10-28</summary>

> The linker has been redesigned from the ground up, bringing massive improvements in link speed. Linking is up to five times faster! The new linker also reduces the size of debug binaries by up to 30%.
>
> — [developer.apple.com/videos/play/wwdc2023/102/](https://developer.apple.com/videos/play/wwdc2023/102/)

> Recent benchmarks show that Apple's new linker (ld-prime) is faster than LLD for local macOS development
>
> — [github.com/chromium/chromium/blob/13b8fd8fc88ffeea53b0ae5d07d82c5cf…](https://github.com/chromium/chromium/blob/13b8fd8fc88ffeea53b0ae5d07d82c5cfd2f03df/docs/apple_platform_linkers.md)

> Supported only for local non-cross arm64 macOS builds (ARM Mac) to improve link speed (yielding up to a 4-6x speedup depending on configuration).
>
> — [github.com/chromium/chromium/blob/13b8fd8fc88ffeea53b0ae5d07d82c5cf…](https://github.com/chromium/chromium/blob/13b8fd8fc88ffeea53b0ae5d07d82c5cfd2f03df/docs/apple_platform_linkers.md)

> LLD is currently twice as fast as ld64, the macOS system linker, at linking
>
> — [github.com/chromium/chromium/blob/9d31eda35a6ef73546d8607f2592519ef…](https://github.com/chromium/chromium/blob/9d31eda35a6ef73546d8607f2592519efbc6d9b8/docs/mac_lld.md)

> We now make better use of the cores
>
> — [developer.apple.com/videos/play/wwdc2022/110362/](https://developer.apple.com/videos/play/wwdc2022/110362/)

</details>
