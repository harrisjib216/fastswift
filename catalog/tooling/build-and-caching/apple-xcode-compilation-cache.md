# Xcode compilation cache (COMPILATION_CACHE_ENABLE_CACHING, Xcode 26)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md) › [Build systems and caching](README.md)</sub>

**Tier A** (reproducible public benchmark) · ✅ Holds up · Ships with Apple's SDKs · `Xcode toolchain` · `Apple SDK` · 🟢 active

> Xcode 26's opt-in content-addressed compilation cache; Tuist measured 18-77% shorter clean builds once the cache is warm.

| | |
|---|---|
| **Beats** | xcodebuild clean build with no cache |
| **Claimed result** | Local cache: Wikipedia 24%, Pocket Casts 36%, Tuist CLI 77% shorter clean builds; remote cache: 18%, 20% and 53%; Mastodon 19% (local) and 30% (remote) with SwiftPM, 55% and 69% as a Tuist-generated project. Wikipedia 69.328 s to 53.072 s and Pocket Casts 168.073 s to 108.634 s with the local cache |
| **Workload** | Clean builds with a pre-populated local or remote compilation cache of Wikipedia iOS, Pocket Casts iOS, Mastodon iOS and the Tuist CLI, 3-5 runs each |
| **Metric** | build time |
| **Hardware** | Namespace M4 Pro CI runners |
| **OS** | macOS |
| **Toolchain** | Xcode 26.0.1 |
| **Measured** | 2025-10 |
| **Platforms** | Xcode 26+ on macOS |
| **Install** | built into Xcode 26+; set COMPILATION_CACHE_ENABLE_CACHING = YES |
| **Links** | [documentation](https://developer.apple.com/documentation/xcode-release-notes/xcode-26-release-notes) · [benchmark](https://github.com/tuist/cache-benchmark) |

## Verdict

With a populated cache, clean builds were 18-77% faster across four real projects in Tuist's measurements. Apple publishes no figure of its own. The size of the win depends heavily on project structure: SwiftPM-heavy projects gained least because parts of package builds are not cacheable yet.

**Why tier A:** Public benchmark repository with hyperfine runs; the post names Namespace M4 Pro runners and Xcode 26.0.1, and the benchmarker is independent of Apple.

## Use it when

- Xcode 26+ projects with frequent clean builds, branch switches or derived-data wipes
- Projects whose code lives in Xcode targets rather than Swift packages

## Skip it when

- SwiftPM-heavy projects expecting large gains: package builds have uncacheable steps
- Teams without a remote cache server, who only get the local cache

## How it is fast

Xcode 26 keys each compilation on its inputs in an action cache and stores outputs in content-addressable storage, the same model Bazel and Gradle use. When the key matches, the compiler output is reused instead of recompiled. Xcode still plans and runs the rest of the build around those cache hits.

## What it costs

- Remote caching needs a server that speaks Xcode's cache protocol
- Disk usage for the local CAS
- Opt-in build setting; not on by default

## Problems with the evidence

- Measured by Tuist, which sells a remote cache server for this feature
- Only 3-5 runs per configuration on CI runners
- Measured on Xcode 26.0.1, the first release of the feature; later Xcode versions may differ

## Evidence

<details>
<summary>8 quotes from the sources, checked 2026-10-28</summary>

> For Wikipedia, the build time was reduced by 24% when using the local cache (simulating clean builds with local compilation cache already populated) and by 18% when using the remote cache (simulating clean builds with remote, not local, compilation cache already populated). For Pocket Casts, the build times were reduced by 36% for the local cache and by 20% for the remote cache.
>
> — [github.com/tuist/tuist/blob/main/server/priv/marketing/blog/2025/10…](https://github.com/tuist/tuist/blob/main/server/priv/marketing/blog/2025/10/22/xcode-cache.md)

> We've observed the biggest improvement in build times for Tuist CLI, where the build time was reduced by 77% when using the local cache and by 53% when using the remote cache.
>
> — [github.com/tuist/tuist/blob/main/server/priv/marketing/blog/2025/10…](https://github.com/tuist/tuist/blob/main/server/priv/marketing/blog/2025/10/22/xcode-cache.md)

> Whereas building Mastodon with the local cache and the remote cache with the default SwiftPM integration improved the build by 19% and 30%, respectively, the improvements were 55% and 69% for the Mastodon project generated with Tuist.
>
> — [github.com/tuist/tuist/blob/main/server/priv/marketing/blog/2025/10…](https://github.com/tuist/tuist/blob/main/server/priv/marketing/blog/2025/10/22/xcode-cache.md)

> M4 Pro runners on 20th and 21st October 2025 using Xcode 26.0.1.
>
> — [github.com/tuist/tuist/blob/main/server/priv/marketing/blog/2025/10…](https://github.com/tuist/tuist/blob/main/server/priv/marketing/blog/2025/10/22/xcode-cache.md)

> ### wikipedia-ios #### Clean build without caching https://github.com/tuist/cache-benchmark/actions/runs/18675431659/job/53244336304 ``` Time (mean ± σ): 69.328 s ± 2.320 s
>
> — [github.com/tuist/cache-benchmark](https://github.com/tuist/cache-benchmark)

> Time (mean ± σ): 53.072 s ± 1.253 s
>
> — [github.com/tuist/cache-benchmark](https://github.com/tuist/cache-benchmark)

> Time (mean ± σ): 168.073 s ± 11.333 s
>
> — [github.com/tuist/cache-benchmark](https://github.com/tuist/cache-benchmark)

> Time (mean ± σ): 108.634 s ± 4.827 s
>
> — [github.com/tuist/cache-benchmark](https://github.com/tuist/cache-benchmark)

</details>
