# TextKit 2 (NSTextLayoutManager)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [UI and rendering](../README.md) › [Text rendering](README.md)</sub>

**Tier D** (directional only) · 🟡 Holds up in part · Ships with Apple's SDKs · `Objective-C` · `Apple SDK` · 🟢 active

> Apple's viewport-based text engine; pitched as faster than TextKit 1 for large documents, but no published numbers and mixed field reports.

| | |
|---|---|
| **Beats** | TextKit 1 (NSLayoutManager) in UITextView and NSTextView |
| **Claimed result** | No numbers. Apple: 'TextKit 2 is extremely fast'. ChimeHQ TextViewBenchmark: TextKit 2 'even a small amount faster' than TextKit 1 on a macOS 14 beta; TextKit 2 was 'basically unusable' on macOS 12. |
| **Workload** | Apple: scrolling and laying out large documents. ChimeHQ: automated XCTest UI performance tests of NSTextView on macOS. |
| **Metric** | time (directional) |
| **OS** | macOS 12 to 14 (ChimeHQ); iOS 15+ and macOS 12+ (Apple) |
| **Measured** | 2023 |
| **Platforms** | iOS 15+, macOS 12+ |
| **Install** | built into iOS 15+ and macOS 12+ |
| **Links** | [documentation](https://developer.apple.com/documentation/uikit/nstextlayoutmanager) · [benchmark](https://github.com/ChimeHQ/TextViewBenchmark) |

## Verdict

Apple presents TextKit 2's viewport-based, always noncontiguous layout as fast for documents of hundreds of megabytes but publishes no numbers. The one public benchmark suite found it only 'a small amount faster' than TextKit 1 on a macOS 14 beta, and a long-time TextKit 2 editor author reports unstable height estimates and scrolling jumps.

**Why tier D:** Directional statements only: Apple gives no figures and the third-party benchmark README reports results in words.

## Use it when

- Very large documents where TextKit 1's contiguous layout causes hangs on open or jump-to-line
- New text views on iOS 16+ or macOS 13+ that avoid TextKit 1 compatibility mode

## Skip it when

- Editors that need stable total document height or exact scroll positions, where estimated heights cause scrollbar jumps
- Code that touches layoutManager, which silently switches the view back to TextKit 1

## How it is fast

TextKit 2 lays out only the viewport plus an overscroll region and estimates the rest, so opening or jumping into a large document does not lay out all preceding text. TextKit 1 lays out contiguously from the start unless noncontiguous layout is turned on.

## What it costs

- Estimated layout outside the viewport makes total height and scroll offsets unstable.
- Falling back to TextKit 1 compatibility mode is one-way and costly.

## Problems with the evidence

- No Apple numbers; the WWDC21 claims are qualitative.
- ChimeHQ's benchmark README states results in words only and ran on a macOS 14 beta.
- Marcin Krzyzanowski (STTextView) reports, after four years on TextKit 2, that viewport height estimates change as more text is laid out and that TextEdit shows the same problems.

## Evidence

<details>
<summary>6 quotes from the sources, checked 2026-10-28</summary>

> TextKit 2 is extremely fast
>
> — [developer.apple.com/videos/play/wwdc2021/10061/](https://developer.apple.com/videos/play/wwdc2021/10061/)

> Based on these tests, TextKit 1 is extremely fast and TextKit 2 actually even a small amount faster!
>
> — [github.com/ChimeHQ/TextViewBenchmark/blob/main/README.md](https://github.com/ChimeHQ/TextViewBenchmark/blob/main/README.md)

> I'm using macOS 14 beta, so that may be a factor.
>
> — [github.com/ChimeHQ/TextViewBenchmark/blob/main/README.md](https://github.com/ChimeHQ/TextViewBenchmark/blob/main/README.md)

> It was introduced in macOS 12, and I found it basically unusable.
>
> — [github.com/ChimeHQ/TextViewBenchmark/blob/main/README.md](https://github.com/ChimeHQ/TextViewBenchmark/blob/main/README.md)

> The estimation changes frequently as I lay out more/different parts of the document.
>
> — [mjtsai.com/blog/?p=48928](https://mjtsai.com/blog/?p=48928)

> TextEdit app from macOS suffers from the very same issues I do in my implementations.
>
> — [mjtsai.com/blog/?p=48928](https://mjtsai.com/blog/?p=48928)

</details>
