# XCRemoteCache

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md) › [Build systems and caching](README.md)</sub>

**Tier C** (first-party numbers) · 🟡 Holds up in part · Open source · `Swift` · `Apache-2.0` · 🟡 stale

> Spotify's remote cache for Xcode builds; cut median clean builds 70% at Spotify, but needs old driver settings and has stalled.

| | |
|---|---|
| **Beats** | xcodebuild / Xcode builds with no remote cache |
| **Claimed result** | Median clean build times down 70% and incremental build times down 6% in a one-week rollout to 50% of developers |
| **Workload** | Spotify's main iOS app, more than 400 modules as separate Xcode targets; a build counts as clean when at least 50% of targets compile at least one file |
| **Metric** | build time |
| **Measured** | 2021-11 |
| **Adoption** | 872 stars |
| **Last commit** | 2024-07-10 |
| **Platforms** | macOS, Xcode 11.4+ |
| **Install** | Release binaries plus build-setting wrappers via xcprepare; CocoaPods plugin (cocoapods-xcremotecache) |
| **Links** | [repository](https://github.com/spotify/XCRemoteCache) · [benchmark](https://engineering.atspotify.com/introducing-xcremotecache-the-ios-remote-caching-tool-that-cut-our-clean-build-times-by-70/) |

## Verdict

The 70% cut is real for Spotify's clean builds, but incremental builds improved only 6%, the measurement is from the Xcode 12-13 era, the tool needs the integrated Swift driver turned off and does not support SwiftPM dependencies, and it has had no commits since July 2024 while an Xcode 26 compatibility pull request is still open.

**Why tier C:** First-party A/B rollout numbers from Spotify with no hardware, Xcode version or raw timings.

## Use it when

- Large, heavily modularized Xcode projects (hundreds of targets) built from a shared primary branch
- CI already builds every primary-branch commit and can upload artifacts

## Skip it when

- Projects with Swift Package Manager dependencies, which it cannot cache
- Xcode 26 and later until compatibility lands; consider Xcode's own compilation cache instead
- Small projects or branches far from the primary branch, where the hit rate is low

## How it is fast

It wraps clang and swiftc with fake compilers that check whether a target's inputs match artifacts produced on CI for the same primary-branch commit. On a hit it downloads the target's build products instead of compiling, so only targets that changed locally are compiled. It caches per target, trading hit rate against network overhead.

## What it costs

- Requires a cache server (S3, GCS or the bundled Docker server) and a CI producer
- Must run xcprepare after each merge or rebase or the hit rate drops

## Problems with the evidence

- Numbers are Spotify's own, measured on one app around 2020-2021 and published November 2021
- No raw timings, hardware or Xcode version
- The README says the integrated Swift driver (default since Xcode 14) must be disabled, which removes some of Xcode's own build parallelism

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> median clean build and incremental build times decreased by 70% and 6%, respectively. We classify builds as clean when at least 50% of all targets compile at least one file.
>
> — [engineering.atspotify.com/introducing-xcremotecache-the-ios-remote-…](https://engineering.atspotify.com/introducing-xcremotecache-the-ios-remote-caching-tool-that-cut-our-clean-build-times-by-70/)

> rolled out the remote cache to 50% of our developers for a week and compared all build metrics
>
> — [engineering.atspotify.com/introducing-xcremotecache-the-ios-remote-…](https://engineering.atspotify.com/introducing-xcremotecache-the-ios-remote-caching-tool-that-cut-our-clean-build-times-by-70/)

> The new Swift driver (introduced by default in Xcode 14.0) is not supported and has to be disabled when using XCRemoteCache
>
> — [github.com/spotify/XCRemoteCache](https://github.com/spotify/XCRemoteCache)

> Swift Package Manager (SPM) dependencies are not supported.
>
> — [github.com/spotify/XCRemoteCache](https://github.com/spotify/XCRemoteCache)

</details>
