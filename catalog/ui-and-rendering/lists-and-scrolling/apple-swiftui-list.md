# SwiftUI List (macOS 26)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [UI and rendering](../README.md) › [Lists and scrolling](README.md)</sub>

**Tier C** (first-party numbers) · ✅ Holds up · Ships with Apple's SDKs · `Swift` · `Apple SDK` · 🟢 active

> Apple says SwiftUI List on macOS 26 loads 100,000+ item lists 6x faster and updates them up to 16x faster than before.

| | |
|---|---|
| **Beats** | SwiftUI List on macOS 15 and earlier |
| **Claimed result** | On macOS, lists of over 100,000 items load 6x faster and update up to 16x faster; 'improvements to all platforms' not quantified. |
| **Workload** | SwiftUI List with more than 100,000 rows: initial load and updates. No further detail given. |
| **Metric** | time |
| **OS** | macOS 26 vs earlier macOS |
| **Measured** | 2025-06 |
| **Platforms** | macOS 26+ (smaller unquantified gains on other platforms) |
| **Install** | built into macOS 26+ |
| **Links** | [documentation](https://developer.apple.com/documentation/swiftui/list) · [benchmark](https://developer.apple.com/videos/play/wwdc2025/256/) |

## Verdict

Apple states that macOS 26 loads lists of more than 100,000 items 6x faster and updates them up to 16x faster. No independent measurement was found to contradict it, but none confirms it either.

**Why tier C:** First-party WWDC claim with no workload detail, hardware or published benchmark.

## Use it when

- Mac apps showing very large tables or outlines in SwiftUI List
- Apps that previously wrapped NSTableView only because List was slow at this scale

## Skip it when

- Apps that must support macOS 15 or earlier, where the old behaviour remains

## How it is fast

Apple did not describe the mechanism for the macOS list gains. The same session describes improved scheduling of UI updates on iOS and macOS so more work is prepared ahead of upcoming frames, and lazy loading for lazy stacks nested in scroll views.

## What it costs

- None to adopt beyond requiring macOS 26 for the gain.

## Problems with the evidence

- First-party figures only; no device, dataset shape or method published.
- The figures are for macOS; iOS, iPadOS and other platforms were described only as improved.
- The session does not say whether the gain needs the macOS 26 SDK or only the macOS 26 runtime.

## Evidence

<details>
<summary>2 quotes from the sources, checked 2026-10-28</summary>

> On macOS, lists of over 100,000 items now load 6x faster.
>
> — [developer.apple.com/videos/play/wwdc2025/256/](https://developer.apple.com/videos/play/wwdc2025/256/)

> And these lists update up to 16x faster.
>
> — [developer.apple.com/videos/play/wwdc2025/256/](https://developer.apple.com/videos/play/wwdc2025/256/)

</details>
