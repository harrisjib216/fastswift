# SwiftUI List (vs ScrollView + LazyVStack)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [UI and rendering](../README.md) › [Lists and scrolling](README.md)</sub>

**Tier B** (independent measurement) · 🟡 Holds up in part · Ships with Apple's SDKs · `Swift` · `Apple SDK` · 🟢 active

> In a 1,000-row image stress test on iOS 17.5, SwiftUI List scrolled 9.5x faster than LazyVStack with far fewer hangs.

| | |
|---|---|
| **Beats** | SwiftUI ScrollView containing a LazyVStack |
| **Claimed result** | Scroll to bottom: 5.53 s (List) vs 52.3 s (LazyVStack), 9.5x (derived from page data); hangs 4.6 vs 78; memory after scrolling down 128.9 MB vs 149 MB, after scrolling back 118.2 MB vs 151.8 MB; at launch List used more, 114.4 MB vs 90.2 MB. |
| **Workload** | 1,000 rows; each row is a 20x20 grid of 10x10-point views drawing the same high-resolution image (400 images per row). Fast manual scroll from top to bottom, timed, with hangs counted in Instruments. |
| **Metric** | time, hangs, memory |
| **Hardware** | iPhone 15 Pro |
| **OS** | iOS 17.5.1 |
| **Measured** | 2025-01-24 |
| **Platforms** | iOS 13+ |
| **Install** | built into iOS 13+ |
| **Links** | [documentation](https://developer.apple.com/documentation/swiftui/list) · [benchmark](https://strv.com/blog/swiftui-list-vs-lazyvstack) |

## Verdict

In one stress test on iOS 17.5.1, List scrolled 1,000 heavy rows in 5.53 s against 52.3 s for LazyVStack, with 4.6 hangs against 78, and used less memory after scrolling. List also used more memory at launch. The workload is extreme, the build configuration is not stated, and iOS 26 changed lazy stack scheduling, so the size of the gap does not carry over to typical lists.

**Why tier B:** Third-party article (STRV) with numbers, device and OS stated; code given inline but no build configuration and manual scroll timing.

## Use it when

- Long, uniform, heavy rows where memory growth during scrolling matters
- Apps targeting iOS 17 and 18 where LazyVStack keeps off-screen rows alive

## Skip it when

- Small lists, or layouts that need custom spacing and no list styling, where LazyVStack's lower launch memory and flexibility win
- Making a decision for iOS 26+ without re-measuring, since Apple changed lazy stack and scroll scheduling there

## How it is fast

List is backed by a UIKit collection that reuses cells and releases rows that leave the screen. LazyVStack creates rows lazily but, in this test, kept them alive, so memory and work grew as the user scrolled.

## What it costs

- List brings platform list styling, separators and insets that can be awkward to remove.
- List used about 24 MB more memory at launch in this test.

## Problems with the evidence

- Single device and OS (iPhone 15 Pro, iOS 17.5.1); predates iOS 18 and iOS 26 SwiftUI performance work.
- Build configuration not stated; the app was 'rebuilt' from Xcode between runs, which suggests a Debug build.
- Scroll time depends on manual flicking; number of runs per variant is in images only.
- Pathological rows (400 high-resolution image views each), far heavier than typical list cells.
- The article says List is built on UITableView; it has been reported to use UICollectionView since iOS 16, though both reuse cells.

## Evidence

<details>
<summary>9 quotes from the sources, checked 2026-10-28</summary>

> Scrolling to the bottom took 5.53 seconds with the
>
> — [strv.com/blog/swiftui-list-vs-lazyvstack](https://strv.com/blog/swiftui-list-vs-lazyvstack)

> took a staggering 52.3 seconds
>
> — [strv.com/blog/swiftui-list-vs-lazyvstack](https://strv.com/blog/swiftui-list-vs-lazyvstack)

> experienced 4.6 hangs, while
>
> — [strv.com/blog/swiftui-list-vs-lazyvstack](https://strv.com/blog/swiftui-list-vs-lazyvstack)

> logged 78
>
> — [strv.com/blog/swiftui-list-vs-lazyvstack](https://strv.com/blog/swiftui-list-vs-lazyvstack)

> It starts with 114.4 MB allocated, compared to just 90.2 MB for
>
> — [strv.com/blog/swiftui-list-vs-lazyvstack](https://strv.com/blog/swiftui-list-vs-lazyvstack)

> consumes 128.9 MB of memory, less than the 149 MB used by
>
> — [strv.com/blog/swiftui-list-vs-lazyvstack](https://strv.com/blog/swiftui-list-vs-lazyvstack)

> reverts to a memory usage of 118.2 MB
>
> — [strv.com/blog/swiftui-list-vs-lazyvstack](https://strv.com/blog/swiftui-list-vs-lazyvstack)

> remains at 151.8 MB
>
> — [strv.com/blog/swiftui-list-vs-lazyvstack](https://strv.com/blog/swiftui-list-vs-lazyvstack)

> The testing was performed on an iPhone 15 Pro with iOS 17.5.1
>
> — [strv.com/blog/swiftui-list-vs-lazyvstack](https://strv.com/blog/swiftui-list-vs-lazyvstack)

</details>
