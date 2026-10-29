# Explicitly built modules (Xcode 16+)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md) › [Build systems and caching](README.md)</sub>

**Tier B** (independent measurement) · 🟡 Holds up in part · Ships with Apple's SDKs · `Xcode toolchain` · `Apple SDK` · 🟢 active

> Xcode 16's explicit module builds: faster LLDB startup is measured, but independent tests found clean builds slower.

| | |
|---|---|
| **Beats** | Implicitly built Clang and Swift modules (Xcode 15 and earlier) |
| **Claimed result** | Apple: no build-time figure. Measured: clean builds 50.1s vs 57.8s (Tuist codebase), 21s vs 30s (BackyardBirds), 119s vs 121s (pocketcasts-ios), default vs explicit, all slower with explicit modules; first LLDB po from 25 seconds to 0.8 seconds |
| **Workload** | Clean builds of three projects (Bitrise); a large synthetic workspace mirroring a production app's dependency graph (forum report); first po expression in LLDB after cleaning the module cache |
| **Metric** | build time |
| **Hardware** | Apple M1 Pro, 32GB (Bitrise); Apple M3 Max, 64GB (forum report) |
| **OS** | macOS 15.2 (forum report) |
| **Toolchain** | Xcode 16 beta 1 (Bitrise); Xcode 16.1, WMO (forum report) |
| **Measured** | 2025-01 |
| **Platforms** | Xcode 16+ (C and Objective-C by default; Swift opt-in in Xcode 16, default in Xcode 26) |
| **Install** | built into Xcode 16+; SWIFT_ENABLE_EXPLICIT_MODULES |
| **Links** | [documentation](https://developer.apple.com/videos/play/wwdc2024/10171/) · [benchmark](https://www.bitrise.io/blog/post/demystifying-explicitly-built-modules-for-xcode) |

## Verdict

Apple pitched improved parallelism, better diagnostics and faster debugging. Independent measurements found clean builds slower, not faster (three projects on Xcode 16 beta 1, a large regression at scale on Xcode 16.1), while the debugger win held: the first LLDB po fell from 25 seconds to 0.8 seconds.

**Why tier B:** Third-party measurements from Bitrise and a Swift Forums report with hardware and Xcode version stated; Apple gives no numbers.

## Use it when

- Debugging sessions where LLDB's first expression evaluation is slow
- Projects that want module build failures reported as separate tasks with clearer diagnostics

## Skip it when

- Expecting shorter clean builds: measurements so far show equal or longer times
- Very large graphs of small targets with many module variants, where the forum report saw a large regression

## How it is fast

Xcode scans dependencies up front and schedules each Clang and Swift module as its own build task, instead of having compiler invocations build modules on demand and wait on each other. The debugger can reuse those prebuilt modules rather than rebuilding them, which is where the measured win is.

## What it costs

- Module variants (from differing build settings or macros) multiply module builds
- An extra dependency-scanning step before compilation

## Problems with the evidence

- Bitrise's numbers are from Xcode 16 beta 1 and may not reflect later releases
- The forum regression was on a synthetic workspace; an Apple engineer confirmed similar behavior but said it is not representative of typical projects
- The 25 s to 0.8 s po result is from a sample reproducer, averaged over 3 runs

## Evidence

<details>
<summary>6 quotes from the sources, checked 2026-10-28</summary>

> Xcode 16 supercharges your builds with Explicit Modules. This feature provides improved parallelism, better diagnostics, and faster debugging, all without changing a single line of code.
>
> — [developer.apple.com/videos/play/wwdc2024/10135/](https://developer.apple.com/videos/play/wwdc2024/10135/)

> The following benchmarks were run with Xcode 16 Beta 1, and as of this release, explicit module building is actually slightly slower than the old system.
>
> — [bitrise.io/blog/post/demystifying-explicitly-built-modules-for-xcode](https://www.bitrise.io/blog/post/demystifying-explicitly-built-modules-for-xcode)

> Xcode 16 default (C and Objective-C yes, Swift no): 50.1s Explicit everything: 57.8s BackyardBirds : a multi-target sample app from WWDC 2023. Xcode 16 default (C and Objective-C yes, Swift no): 21s Explicit everything: 30s pocketcasts-ios : a reasonably large real-world project Xcode 16 default (C and Objective-C yes, Swift no): 119s Explicit everything: 121s Notes: tested on Apple Silicon M1 Pro…
>
> — [bitrise.io/blog/post/demystifying-explicitly-built-modules-for-xcode](https://www.bitrise.io/blog/post/demystifying-explicitly-built-modules-for-xcode)

> Enabling the feature resulted in a significant build time regression
>
> — [forums.swift.org/t/build-times-regression-with-explicitly-built-mod…](https://forums.swift.org/t/build-times-regression-with-explicitly-built-modules/77073)

> Xcode 16.1, Tuist version: 4.20.0, WMO, Apple M3 Max, macOS 15.2, 64GB
>
> — [forums.swift.org/t/build-times-regression-with-explicitly-built-mod…](https://forums.swift.org/t/build-times-regression-with-explicitly-built-modules/77073)

> reduced the time for the first po in LLDB from an average of 25 seconds (over 3 runs) to just 0.8 seconds
>
> — [forums.swift.org/t/build-times-regression-with-explicitly-built-mod…](https://forums.swift.org/t/build-times-regression-with-explicitly-built-modules/77073)

</details>
