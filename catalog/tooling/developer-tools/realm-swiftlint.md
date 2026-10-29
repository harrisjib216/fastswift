# SwiftLint (SwiftSyntax-based rules)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md) › [Developer tools](README.md)</sub>

**Tier C** (first-party numbers) · ✅ Holds up · Open source · `Swift` · `MIT` · 🟢 active

> The standard Swift linter; rewriting rules on SwiftSyntax made them 7-10x faster and whole runs 6-30% faster per release.

| | |
|---|---|
| **Beats** | Earlier SwiftLint releases with SourceKit-based rules (0.48 and earlier) |
| **Claimed result** | comma rule about 10x, colon about 7x, closure_spacing about 9x faster (0.49.0); lint times up to 15% faster (0.50.0); up to 6% (0.51.0); up to 30% faster (0.56.0); 10-15%, up to 3-4x at high concurrency (0.64.0) |
| **Workload** | Linting Swift projects; individual rule rewrites and whole-run lint times |
| **Metric** | time |
| **Measured** | 2026-06 |
| **Adoption** | 19.8k stars |
| **Last commit** | 2026-09-28 |
| **Platforms** | macOS, Linux, Windows |
| **Install** | Homebrew, Mint, Swift Package Manager plugin, CocoaPods, Bazel |
| **Links** | [repository](https://github.com/realm/SwiftLint) · [benchmark](https://github.com/realm/SwiftLint/blob/main/CHANGELOG.md) |

## Verdict

Release notes report rule rewrites on SwiftSyntax about 7-10x faster and whole-lint gains of 6-30% per release, plus 10-15% (up to 3-4x at high concurrency) from less cache-lock contention in 0.64.0. The claims are modest and specific; they are per-release, first-party and not cumulative measurements.

**Why tier C:** First-party changelog entries with no benchmark project, hardware or method.

## Use it when

- Projects on SwiftLint 0.48 or earlier: upgrading is the speedup
- Large codebases linted with many threads, where 0.64.0's cache-locking change helps most

## Skip it when

- Analyzer rules, which still need a compiler log and are slower; the changelog reported about 2x regressions for them with Swift 5.6

## How it is fast

Rules moved from SourceKit requests, which go through the compiler's service process, to SwiftSyntax tree visitors running in-process. Later releases picked up SwiftSyntax's own parser speedups and reduced lock contention on the results cache when linting with many threads.

## What it costs

- Newer releases require newer Swift toolchains to build

## Problems with the evidence

- Per-rule 7-10x figures do not translate into whole-lint speedups of that size
- No benchmark project or hardware is named in any entry
- Gains are relative to older SwiftLint, not to a different linter

## Evidence

<details>
<summary>13 quotes from the sources, checked 2026-10-28</summary>

> Make `comma` rule about 10x faster, finding some previously missed cases and fixing some previously wrong corrections.
>
> — [github.com/realm/SwiftLint/blob/main/CHANGELOG.md](https://github.com/realm/SwiftLint/blob/main/CHANGELOG.md)

> Make `colon` rule about 7x faster, finding some previously missed cases.
>
> — [github.com/realm/SwiftLint/blob/main/CHANGELOG.md](https://github.com/realm/SwiftLint/blob/main/CHANGELOG.md)

> Make `closure_spacing` rule about 9x faster
>
> — [github.com/realm/SwiftLint/blob/main/CHANGELOG.md](https://github.com/realm/SwiftLint/blob/main/CHANGELOG.md)

> We've also measured an improvement in lint times of up to 15%.
>
> — [github.com/realm/SwiftLint/blob/main/CHANGELOG.md](https://github.com/realm/SwiftLint/blob/main/CHANGELOG.md)

> Speed up linting by up to 6% updating to use a newer version of
>
> — [github.com/realm/SwiftLint/blob/main/CHANGELOG.md](https://github.com/realm/SwiftLint/blob/main/CHANGELOG.md)

> Linting got up to 30% faster due to the praiseworthy performance improvements done in the
>
> — [github.com/realm/SwiftLint/blob/main/CHANGELOG.md](https://github.com/realm/SwiftLint/blob/main/CHANGELOG.md)

> Improve linting performance by 10-15%, especially when running with many threads, by optimizing cache locking and reducing contention. Depending on the project and level of concurrency, the performance improvement can be even higher (3-4x).
>
> — [github.com/realm/SwiftLint/blob/main/CHANGELOG.md](https://github.com/realm/SwiftLint/blob/main/CHANGELOG.md)

> Note that we've measured performance regressions compared to Swift 5.5 on the order of about 2x.
>
> — [github.com/realm/SwiftLint/blob/main/CHANGELOG.md](https://github.com/realm/SwiftLint/blob/main/CHANGELOG.md)

> 0.49.0: Asynchronous Defuzzer
>
> — [github.com/realm/SwiftLint/blob/main/CHANGELOG.md](https://github.com/realm/SwiftLint/blob/main/CHANGELOG.md)

> 0.50.0: Artisanal Clothes Pegs
>
> — [github.com/realm/SwiftLint/blob/main/CHANGELOG.md](https://github.com/realm/SwiftLint/blob/main/CHANGELOG.md)

> 0.51.0: bzllint
>
> — [github.com/realm/SwiftLint/blob/main/CHANGELOG.md](https://github.com/realm/SwiftLint/blob/main/CHANGELOG.md)

> 0.56.0: Heat Pump Dryer
>
> — [github.com/realm/SwiftLint/blob/main/CHANGELOG.md](https://github.com/realm/SwiftLint/blob/main/CHANGELOG.md)

> 0.64.0: All Windows Opened
>
> — [github.com/realm/SwiftLint/blob/main/CHANGELOG.md](https://github.com/realm/SwiftLint/blob/main/CHANGELOG.md)

</details>
