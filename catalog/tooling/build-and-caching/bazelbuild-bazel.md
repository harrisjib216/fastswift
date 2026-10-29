# Bazel (with rules_swift, rules_apple and rules_xcodeproj)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md) › [Build systems and caching](README.md)</sub>

**Tier B** (independent measurement) · 🟡 Holds up in part · Open source · `Java` · `Apache-2.0` · 🟢 active

> Google's build system with Swift and Apple rules; Spotify cut iOS CI waits 4x, mostly through remote caching and remote execution.

| | |
|---|---|
| **Beats** | xcodebuild / the Xcode build system with no remote cache |
| **Claimed result** | Spotify: CI feedback loop from 80 minutes to 20 minutes (factor of four); one 800-test-target configuration from more than 45 minutes to less than 10 minutes. Allegro: clean build from 260s to 85s (over threefold) |
| **Workload** | Spotify: pre-merge CI for the iOS monorepo (75th percentile wait); one configuration with 800+ test targets and close to 3 million lines of code. Allegro: clean build of the Allegro iOS app (300k+ lines of Objective-C and Swift) with modules served from a shared remote cache |
| **Metric** | build time |
| **Measured** | 2023-10 |
| **Adoption** | 26.0k stars |
| **Last commit** | 2026-10-28 |
| **Platforms** | macOS and Linux hosts; Apple targets through rules_apple and rules_swift |
| **Install** | Bazelisk or Homebrew; BUILD files per module; rules_xcodeproj for the Xcode IDE |
| **Links** | [repository](https://github.com/bazelbuild/bazel) · [benchmark](https://engineering.atspotify.com/2023/10/switching-build-systems-seamlessly) |

## Verdict

Spotify and Allegro both report large wins, but most of it comes from a shared remote cache, remote execution and test selection with bazel-diff rather than from Bazel compiling Swift faster. Allegro's 2020 setup wrapped xcodebuild in custom rules instead of using rules_swift, and both migrations took a dedicated team.

**Why tier B:** Engineering posts from two companies independent of the Bazel and rules authors, with headline numbers but no hardware, Xcode versions or raw data.

## Use it when

- Large monorepos with hundreds of modules and many engineers
- Organizations that can run remote cache and remote execution infrastructure
- CI where test selection by dependency graph pays off

## Skip it when

- Small or mid-size apps where xcodebuild with Xcode 26's compilation cache or a module cache is enough
- Teams without people to maintain BUILD files, rules versions and Xcode integration

## How it is fast

Bazel hashes every action's inputs and reuses outputs from a shared remote cache, so CI and developers rarely compile the same code twice. Remote build execution spreads actions across many machines, and dependency queries such as bazel-diff limit CI to targets a change actually affects.

## What it costs

- Large migration cost: BUILD files, custom macros and a new Xcode integration (Spotify used rules_xcodeproj)
- Remote cache and RBE infrastructure to run and pay for
- Lag behind new Xcode features until the rules support them

## Problems with the evidence

- Spotify's 4x is a CI wait-time metric that also reflects remote execution and bazel-diff test selection, not compile speed alone
- Allegro's numbers are from 2020 and used a custom rule wrapping xcodebuild, not rules_swift
- Neither post gives hardware, Xcode versions or raw timings beyond the headline figures

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> in just a few months, the CI feedback loop improved by a factor of four, decreasing from 80 minutes to 20 minutes.
>
> — [engineering.atspotify.com/2023/10/switching-build-systems-seamlessly](https://engineering.atspotify.com/2023/10/switching-build-systems-seamlessly)

> One in particular, with more than 800 test targets containing close to 3 million lines of code, took more than 45 minutes when building with Xcode. After moving to Bazel, this time decreased to less than 10 minutes. The improvement was primarily attributed to using an efficient Bazel remote cache and parallelizing heavy
>
> — [engineering.atspotify.com/2023/10/switching-build-systems-seamlessly](https://engineering.atspotify.com/2023/10/switching-build-systems-seamlessly)

> After migrating all of our modules to Bazel we were able to significantly reduce our clean build time. It dropped over threefold, going from 260s to just 85s.
>
> — [blog.allegro.tech/2020/12/speeding-up-ios-builds-with-bazel.html](https://blog.allegro.tech/2020/12/speeding-up-ios-builds-with-bazel.html)

> Thanks to shared remote cache, most of the time instead of compiling it we would just download precompiled frameworks.
>
> — [blog.allegro.tech/2020/12/speeding-up-ios-builds-with-bazel.html](https://blog.allegro.tech/2020/12/speeding-up-ios-builds-with-bazel.html)

</details>
