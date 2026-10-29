# FLAnimatedImage

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Images and media](../README.md) › [Animated images](README.md)</sub>

**Tier D** (directional only) · 🟡 Holds up in part · Open source · `Objective-C` · `MIT` · 🔴 abandoned

> GIF player that decodes frames just in time instead of holding all of them; its memory savings were never published as measurements.

| | |
|---|---|
| **Beats** | UIImage.animatedImage(with:duration:) or UIImageView animationImages holding every decoded frame |
| **Claimed result** | No measured speedup. Baseline cost example: 'A 1MB GIF for example turns into 55MB of uncompressed data! (800x600 pixels * 4 bytes per pixel for RGBA * 30 frames)'. |
| **Workload** | Playing several animated GIFs at once in a feed (described, not measured). |
| **Metric** | memory |
| **Measured** | 2014-05 |
| **Adoption** | 7.9k stars |
| **Last commit** | 2022-07-27 |
| **Platforms** | iOS |
| **Install** | CocoaPods, Carthage, Swift Package Manager |
| **Links** | [repository](https://github.com/Flipboard/FLAnimatedImage) · [benchmark](https://engineering.flipboard.com/2014/05/animated-gif) |

## Verdict

Flipboard's 2014 post explains why the UIKit approach uses so much memory, with a worked example of a 1 MB GIF expanding to 55 MB of bitmaps, but publishes no measurement of FLAnimatedImage against it. The design is sound, yet the claim has never been measured in public and the project has had no commits since 2022.

**Why tier D:** No measured comparison; the only number is an arithmetic estimate of the baseline's memory cost.

## Use it when

- Maintaining an app that already uses it for GIFs

## Skip it when

- Formats other than GIF, such as APNG or animated WebP
- New code that can use ImageIO's CGAnimateImageAtURLWithBlock (iOS 13+) or a maintained loader with animated image views

## How it is fast

FLAnimatedImage decodes frames on a background queue shortly before they are shown and sizes its frame cache to the GIF and to memory conditions: small GIFs stay fully decoded, large ones buffer a few frames ahead. On memory warnings it drops buffered frames and decodes on demand, instead of keeping every decoded frame alive as animationImages does.

## What it costs

- Objective-C, GIF only
- Re-decoding frames for large GIFs trades memory for CPU

## Problems with the evidence

- No benchmark numbers; the 55 MB figure is arithmetic, not a measurement
- Written for iOS 7 in 2014
- No independent comparison found

## Evidence

<details>
<summary>2 quotes from the sources, checked 2026-10-28</summary>

> A 1MB GIF for example turns into 55MB of uncompressed data! (800x600 pixels * 4 bytes per pixel for RGBA * 30 frames)
>
> — [engineering.flipboard.com/2014/05/animated-gif](https://engineering.flipboard.com/2014/05/animated-gif)

> but only using a fraction of the memory.
>
> — [engineering.flipboard.com/2014/05/animated-gif](https://engineering.flipboard.com/2014/05/animated-gif)

</details>
