# Tuist (module cache)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md) › [Build systems and caching](README.md)</sub>

**Tier A** (reproducible public benchmark) · ✅ Holds up · Open source · `Swift` · `MIT` · 🟢 active

> Xcode project generator whose module cache swaps unchanged targets for prebuilt binaries, cutting clean builds 2-3x in its benchmarks.

| | |
|---|---|
| **Beats** | xcodebuild clean build with no cache |
| **Claimed result** | Tuist CLI 110.141 s to 34.936 s, Tuist App 68.049 s to 28.080 s, Mastodon (generated) 51.485 s to 24.999 s mean clean build (3.2x, 2.4x and 2.1x, derived from page data) |
| **Workload** | Clean builds of the Tuist CLI, the Tuist app and Mastodon iOS (as a Tuist-generated project), 5 runs each, module cache including generation and binary fetch |
| **Metric** | build time |
| **Hardware** | Namespace M4 Pro CI runners |
| **OS** | macOS |
| **Toolchain** | Xcode 26.0.1; Tuist 4.88 |
| **Measured** | 2025-10 |
| **Adoption** | 5.9k stars |
| **Last commit** | 2026-10-28 |
| **Platforms** | macOS (Xcode projects for Apple platforms) |
| **Install** | mise or Homebrew; project generation with tuist generate |
| **Links** | [repository](https://github.com/tuist/tuist) · [benchmark](https://github.com/tuist/cache-benchmark) |

## Verdict

In Tuist's public hyperfine runs, replacing unchanged modules with cached binaries cut clean builds 2-3x on three projects, and matched or beat Xcode 26's local compilation cache. The numbers hold for Tuist-generated projects; they are Tuist's own measurements of its own product.

**Why tier A:** Public benchmark repository with workflow runs and hyperfine output; the accompanying post names Namespace M4 Pro runners and Xcode 26.0.1.

## Use it when

- Projects already generated with Tuist, or willing to move to generated projects
- Modular apps where most modules are unchanged between builds
- CI and local clean builds where a shared cache can be populated

## Skip it when

- Projects that must stay hand-maintained .xcodeproj files
- Plain SwiftPM-integrated projects: Tuist's own numbers show smaller gains there

## How it is fast

Before generating the Xcode project, Tuist fetches prebuilt frameworks and libraries for every module whose inputs are unchanged and links against them instead of including their sources. The build system then compiles only what changed, and the generated project has fewer targets for Xcode to load. Caching whole modules removes more work than caching individual compiler invocations.

## What it costs

- Requires adopting Tuist's manifest-based project generation
- The remote cache needs Tuist's server (hosted, or self-hosted under MPL-2.0); the CLI is MIT, but GitHub reports the repository license as NOASSERTION because of the mixed licensing
- Debugging into cached binaries is harder than into source targets

## Problems with the evidence

- First-party benchmark: Tuist measuring its own product, which it sells as a hosted service
- Only 5 runs per configuration; the README itself omits hardware, which is in the blog post
- All three module-cache projects are Tuist-generated; no hand-written Xcode project was tested with the module cache

## Evidence

<details>
<summary>8 quotes from the sources, checked 2026-10-28</summary>

> ### Tuist CLI #### Clean build without caching https://github.com/tuist/cache-benchmark/actions/runs/18661637531/job/53203264755 ``` Time (mean ± σ): 110.141 s ± 3.191 s
>
> — [github.com/tuist/cache-benchmark](https://github.com/tuist/cache-benchmark)

> #### Module cache using generated projects https://github.com/tuist/cache-benchmark/actions/runs/18661639514/job/53203270084 ``` Time (mean ± σ): 34.936 s ± 3.437 s
>
> — [github.com/tuist/cache-benchmark](https://github.com/tuist/cache-benchmark)

> ### Tuist App #### Clean build without caching https://github.com/tuist/cache-benchmark/actions/runs/18677113072/job/53249420000 ``` Time (mean ± σ): 68.049 s ± 1.212 s
>
> — [github.com/tuist/cache-benchmark](https://github.com/tuist/cache-benchmark)

> #### Module cache https://github.com/tuist/cache-benchmark/actions/runs/18676750661/job/53248258692 ``` Time (mean ± σ): 28.080 s ± 1.936 s
>
> — [github.com/tuist/cache-benchmark](https://github.com/tuist/cache-benchmark)

> Mastodon using generated projects. #### Clean build without caching https://github.com/tuist/cache-benchmark/actions/runs/18678254368/job/53253116480 ``` Time (mean ± σ): 51.485 s ± 2.292 s
>
> — [github.com/tuist/cache-benchmark](https://github.com/tuist/cache-benchmark)

> #### Clean build with module cache https://github.com/tuist/cache-benchmark/actions/runs/18662844442/job/53207204836 ``` Time (mean ± σ): 24.999 s ± 0.542 s
>
> — [github.com/tuist/cache-benchmark](https://github.com/tuist/cache-benchmark)

> M4 Pro runners on 20th and 21st October 2025 using Xcode 26.0.1.
>
> — [github.com/tuist/tuist/blob/main/server/priv/marketing/blog/2025/10…](https://github.com/tuist/tuist/blob/main/server/priv/marketing/blog/2025/10/22/xcode-cache.md)

> achieving better or similar build times (including generation and fetching of binaries) as the _local_ compilation cache
>
> — [github.com/tuist/tuist/blob/main/server/priv/marketing/blog/2025/10…](https://github.com/tuist/tuist/blob/main/server/priv/marketing/blog/2025/10/22/xcode-cache.md)

</details>
