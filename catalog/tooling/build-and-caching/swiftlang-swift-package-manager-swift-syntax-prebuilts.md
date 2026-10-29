# SwiftPM prebuilt swift-syntax for macros

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md) › [Build systems and caching](README.md)</sub>

**Tier B** (independent measurement) · ✅ Holds up · Ships with Apple's SDKs · `Swift` · `Apache-2.0` · 🟢 active

> SwiftPM downloads a release-built swift-syntax for macros instead of compiling it, cutting minutes from clean builds.

| | |
|---|---|
| **Beats** | Building swift-syntax from source for every package that uses macros (SwiftPM and Xcode before the prebuilts) |
| **Claimed result** | Clean build from around 180s to 120s (33%) on an M4 Pro MacBook Pro; nearly 3 minutes saved on a simple Linux build; macro incremental penalty from 40s to 16s; Apple: clean builds shorter 'by minutes' for some projects |
| **Workload** | Clean and incremental builds of apps and packages that depend on macro packages built on swift-syntax |
| **Metric** | build time |
| **Hardware** | M4 Pro MacBook Pro (one report); Linux (one report) |
| **OS** | macOS, Linux |
| **Toolchain** | Swift 6.1.1 with --enable-experimental-prebuilts, Xcode 16.4 with IDEPackageEnablePrebuilts; Swift 6.2 / Xcode 26 |
| **Measured** | 2025-06 |
| **Adoption** | 10.2k stars |
| **Last commit** | 2026-10-28 |
| **Platforms** | macOS and Linux hosts |
| **Install** | built into Swift 6.2 toolchains and Xcode 26 (opt-in preview in Swift 6.1.1 and Xcode 16.4) |
| **Links** | [repository](https://github.com/swiftlang/swift-package-manager) · [documentation](https://developer.apple.com/videos/play/wwdc2025/245/) · [benchmark](https://forums.swift.org/t/preview-swift-syntax-prebuilts-for-macros/80202?page=2) |

## Verdict

Apple says prebuilt swift-syntax cuts clean builds 'by minutes' for some projects, and independent users report 180 s to 120 s clean builds, nearly 3 minutes saved on Linux, and a macro build penalty down from 40 s to 16 s. The gain applies only to macro-using projects on swift-syntax versions with published prebuilts.

**Why tier B:** Numbers come from developers outside the SwiftPM team on the Swift Forums, but each is a single anecdotal report without a reproducible setup.

## Use it when

- Projects that depend on macro packages (swift-syntax based) and do frequent clean or CI builds
- Release-configuration builds, where compiling swift-syntax is slowest

## Skip it when

- swift-syntax versions or toolchains with no published prebuilt: SwiftPM builds from source as before
- Setups that hit SDK-mismatch errors with the prebuilt modules, as several preview users did

## How it is fast

Macro implementations depend on swift-syntax, a large Swift library that every clean build had to compile, which is slow in release mode and on small CI machines. SwiftPM now downloads a prebuilt binary matching the resolved swift-syntax version, the host platform and the compiler version, and falls back to building from source when none exists. The prebuilts are release builds, so macros can also run faster.

## What it costs

- Downloads binaries from download.swift.org during resolution
- Prebuilts exist only for specific swift-syntax releases, and the URL pattern is not a stable API

## Problems with the evidence

- All numbers are single forum reports without project details or repeated runs
- Apple's own claim ('by minutes') is directional
- Early previews had SDK-version mismatch errors and missing prebuilts for some toolchain versions

## Evidence

<details>
<summary>5 quotes from the sources, checked 2026-10-28</summary>

> To speed up your build, the latest releases of Swift PM and Xcode support pre-built swift-syntax dependencies. This completely eliminates an expensive build step, and for some projects, it reduces clean build times by minutes.
>
> — [developer.apple.com/videos/play/wwdc2025/245/](https://developer.apple.com/videos/play/wwdc2025/245/)

> On an M4 Pro MBP a clean build has gone down from around 180s to 120s, a 33% improvement!
>
> — [forums.swift.org/t/preview-swift-syntax-prebuilts-for-macros/80202?…](https://forums.swift.org/t/preview-swift-syntax-prebuilts-for-macros/80202?page=2)

> Saves nearly 3 minutes for a simple build on Linux!
>
> — [forums.swift.org/t/preview-swift-syntax-prebuilts-for-macros/80202](https://forums.swift.org/t/preview-swift-syntax-prebuilts-for-macros/80202)

> Looks like this knocks our incremental build penalty from 40s to 16s in the Emit Swift Module phase
>
> — [forums.swift.org/t/preview-swift-syntax-prebuilts-for-macros/80202](https://forums.swift.org/t/preview-swift-syntax-prebuilts-for-macros/80202)

> cannot load module 'SwiftSyntax' built with SDK 'macosx15.4' when using SDK 'macosx15.5'
>
> — [forums.swift.org/t/preview-swift-syntax-prebuilts-for-macros/80202?…](https://forums.swift.org/t/preview-swift-syntax-prebuilts-for-macros/80202?page=2)

</details>
