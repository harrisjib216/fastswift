# Auto Layout (iOS 12 engine)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [UI and rendering](../README.md) › [Layout](README.md)</sub>

**Tier A** (reproducible public benchmark) · ✅ Holds up · Ships with Apple's SDKs · `Objective-C` · `Apple SDK` · 🟢 active

> The iOS 12 Auto Layout engine ran 1.22x faster than iOS 11's on the same iPhone 7, narrowing but not closing the gap to frame layout.

| | |
|---|---|
| **Beats** | Auto Layout on iOS 11 |
| **Claimed result** | Apple (WWDC): 'faster layouts in iOS 12', iOS 11 vs iOS 12 shown only as bars. Independent, iPhone 7, 100 cells: Auto Layout 0.223 s (iOS 11.3) vs 0.183 s (iOS 12.1), 1.22x (derived from page data); UIStackView 0.306 s vs 0.235 s, 1.30x (derived from page data). PinLayout's lead over Auto Layout on that phone: ratio 8.05 (iOS 11.3) vs 5.78 (iOS 12.1). Times rounded to three significant figures from the raw results. |
| **Workload** | Feed-style UICollectionView cells, 10 to 100 per pass; seconds for main-thread layoutIfNeeded(). |
| **Metric** | time |
| **Hardware** | iPhone 7 |
| **OS** | iOS 11.3 vs iOS 12.1 |
| **Toolchain** | Release mode per benchmark README; Xcode version not stated |
| **Measured** | 2018 |
| **Platforms** | iOS 12+ |
| **Install** | built into iOS 12+ |
| **Links** | [documentation](https://developer.apple.com/documentation/uikit/nslayoutconstraint) · [benchmark](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/edit#gid=1032991425) |

## Verdict

Apple said layouts got faster in iOS 12 but showed only bar charts. An independent benchmark run on the same iPhone 7 shows Auto Layout 1.22x faster and UIStackView 1.30x faster on iOS 12.1 than on iOS 11.3. The default narrowed the gap to frame-based libraries without closing it.

**Why tier A:** Public LayoutFrameworkBenchmark data on the same device across two iOS versions, Release mode; Apple's own WWDC 2018 figures exist only as charts.

## Use it when

- Any UIKit app: the gain is automatic on iOS 12 and later with no code change
- Screens where Auto Layout cost was borderline on iOS 11 and frame layout is not worth the rewrite

## Skip it when

- Feeds with complex self-sizing cells where Auto Layout still dominates Time Profiler; frame-based libraries remained about 5.8x faster on iOS 12.1 and about 3x faster on current iPhones in the same benchmark

## How it is fast

Apple described iOS 12 work across the constraint engine internals, UIKit, and how UIKit classes such as UICollectionView use Auto Layout for self-sizing cells. The session also stressed avoiding constraint churn in updateConstraints, which the engine cannot optimize away.

## What it costs

- None to adopt; constraint churn in updateConstraints still costs time on every iOS version.

## Problems with the evidence

- Apple's WWDC 2018 numbers were bar charts with no values in the transcript; the session video page is no longer on Apple's site, so the transcript is cited from an index mirror.
- Only one device (iPhone 7) was measured on both iOS versions, and the PinLayout version changed between runs (1.7 vs 1.8).
- The spreadsheet's 'Compare all' tab mixes 90-cell and 100-cell values; the figures here use the per-device tabs at 100 cells.

## Evidence

<details>
<summary>9 quotes from the sources, checked 2026-10-28</summary>

> have faster layouts in iOS 12 so
>
> — [nonstrict.eu/wwdcindex/wwdc2018/220/](https://nonstrict.eu/wwdcindex/wwdc2018/220/)

> that the gray bars are iOS 11.
>
> — [nonstrict.eu/wwdcindex/wwdc2018/220/](https://nonstrict.eu/wwdcindex/wwdc2018/220/)

> iPhone 7 (iOS 12.1),iPhone 7 (iOS 11.3)
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1032991425)

> PinLayout vs Autolayout Ratio,,,7.745748231,8.066571247,5.782034008,8.049055752,6.836422597,7.630711588,10.00596102
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=1032991425)

> Number of Cells in a UICollectionView ,10,20,30,40,50,60,70,80,90,100
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=920356400)

> Auto Layout,0.03259914921,0.05267890504,0.07226485014,0.09216000817,0.1163028081,0.1401895285,0.1602653095,0.1821324825,0.2028049946,0.2228762388
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=920356400)

> UIStackView,0.04388314745,0.0739740559,0.1113824315,0.1422013789,0.1738895575,0.2078489542,0.2328026056,0.2563153505,0.2825381756,0.305982399
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=920356400)

> Auto Layout,0.02855524421,0.04469026172,0.06217916573,0.07982269617,0.09704743732,0.114261455,0.1333239973,0.1488820144,0.1655301877,0.182660381
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=646442677)

> UIStackView,0.04046590328,0.05947275723,0.08058147247,0.1030758858,0.1254775375,0.1464221307,0.1692629854,0.1909775138,0.2128698111,0.2351623774
>
> — [docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIubl…](https://docs.google.com/spreadsheets/d/1sUNdGWBM-d_W13yC7VcfkRXC3owCVsnIublnfW-4xn4/export?format=csv&gid=646442677)

</details>
