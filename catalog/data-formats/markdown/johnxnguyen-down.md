# Down

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md) › [Markdown](README.md)</sub>

**Tier C** (first-party numbers) · ❌ Doesn't hold up · Open source · `Swift + C` · `MIT` · 🔴 abandoned

> Swift wrapper over cmark 0.29; its speed figures are cmark versus Markdown.pl and show no gain over Swift's cmark-based defaults.

| | |
|---|---|
| **Beats** | Markdown.pl (the original Perl implementation); no Swift parser measured |
| **Claimed result** | cmark renders War and Peace in 127 milliseconds on a ten year old laptop; cmark is 10,000 times faster than Markdown.pl |
| **Workload** | Rendering a Markdown version of War and Peace (cmark's benchmark, quoted in Down's README) |
| **Metric** | time |
| **Adoption** | 2.5k stars |
| **Last commit** | 2021-10-18 |
| **Platforms** | iOS, macOS, tvOS, Linux (README badges) |
| **Install** | CocoaPods, Carthage, Swift Package Manager |
| **Links** | [repository](https://github.com/johnxnguyen/Down) · [benchmark](https://github.com/johnxnguyen/Down/blob/master/README.md) |

## Verdict

The README's numbers are upstream cmark's own C benchmarks against Markdown.pl, not a measurement of Down against any Swift default. Apple's swift-markdown, the usual Swift choice, is itself built on cmark-gfm, so the figures show no advantage over it.

**Why tier C:** Numbers quoted from cmark's README with no Swift-side measurement, hardware or version details.

## Use it when

- You need its output formats (NSAttributedString, LaTeX, groff) from one call

## Skip it when

- Choosing for speed: swift-markdown also parses with cmark (cmark-gfm)
- You need GitHub-flavored Markdown tables or task lists: Down bundles plain cmark
- You need maintained code: no commits since 2021

## How it is fast

Parsing and rendering happen in the cmark C library (v0.29.0), which parses in linear time; the Swift layer converts the result to HTML, XML, LaTeX, groff, CommonMark or NSAttributedString.

## What it costs

- Old cmark (v0.29.0) without GitHub-flavored Markdown extensions

## Problems with the evidence

- No measurement of Down itself; the numbers belong to cmark and compare it with a Perl script.
- Bundles cmark v0.29.0, an old release.
- No commits since October 2021.

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> can render a Markdown version of War and Peace in the blink of an eye (127 milliseconds on a ten year old laptop, vs. 100-400 milliseconds for an eye blink).
>
> — [github.com/johnxnguyen/Down/blob/master/README.md](https://github.com/johnxnguyen/Down/blob/master/README.md)

> cmark is 10,000 times faster than the original Markdown.pl, and on par with the very fastest available Markdown processors.
>
> — [github.com/johnxnguyen/Down/blob/master/README.md](https://github.com/johnxnguyen/Down/blob/master/README.md)

> Blazing fast Markdown (CommonMark) rendering in Swift, built upon [cmark v0.29.0]
>
> — [github.com/johnxnguyen/Down/blob/master/README.md](https://github.com/johnxnguyen/Down/blob/master/README.md)

> The parser is powered by GitHub-flavored Markdown's [cmark-gfm](https://github.com/github/cmark-gfm) implementation
>
> — [github.com/swiftlang/swift-markdown/blob/main/README.md](https://github.com/swiftlang/swift-markdown/blob/main/README.md)

</details>
