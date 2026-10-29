# Fast Image Cache

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Images and media](../README.md) › [Image loading](README.md)</sub>

**Tier C** (first-party numbers) · 🟡 Holds up in part · Open source · `Objective-C` · `MIT` · 🔴 abandoned

> Stores pre-decoded, byte-aligned thumbnails in memory-mapped image tables; 59 vs 35 FPS scrolling on iOS 7-era hardware.

| | |
|---|---|
| **Beats** | Loading individual JPEG files with UIImage(contentsOfFile:) and letting Core Animation decode them on the main thread |
| **Claimed result** | Scrolling ~59FPS vs ~35FPS for the conventional method; extra memory 0.09MB vs 1.34MB above baseline; at the cost of 2.2MB vs 568KB on disk. |
| **Workload** | Scrolling a table of JPEG thumbnails in the bundled demo app; RPRVT measured for one screen of thumbnails. |
| **Metric** | frame rate, memory |
| **Adoption** | 8.0k stars |
| **Last commit** | 2016-09-13 |
| **Platforms** | iOS 6+ |
| **Install** | CocoaPods, Carthage |
| **Links** | [repository](https://github.com/path/FastImageCache) · [benchmark](https://github.com/path/FastImageCache#statistics) |

## Verdict

Path's demo measured ~59 FPS against ~35 FPS while scrolling, but on the iOS 7 platform the README describes, where third-party apps got only a software JPEG decoder and no background-decoding API. Current iOS offers UIImage.preparingForDisplay() and ImageIO thumbnails, and the library has had no commits since 2016, so the baseline it beat is no longer today's.

**Why tier C:** First-party demo app in the repository; device, OS version and build configuration are not stated.

## Use it when

- Maintaining an older app that already uses it for many same-sized thumbnails

## Skip it when

- New code: use UIImage.preparingForDisplay() or byPreparingThumbnail(ofSize:) (iOS 15+) or an image loader that decodes off the main thread
- Images that do not share a small set of fixed sizes
- Disk space matters: the demo used about 4x the disk of the source JPEGs

## How it is fast

Images of one format are decoded once into uncompressed, correctly aligned bitmaps and stored together in a memory-mapped 'image table' file. Displaying one wraps the mapped bytes in a CGImage that Core Animation can use without copying or decoding, so scrolling does no JPEG work on the main thread.

## What it costs

- About 4x the disk usage of the compressed images
- Every image format must declare fixed pixel dimensions and style up front
- Objective-C only and unmaintained

## Problems with the evidence

- Measured in the iOS 7 era (README: 'As of iOS 7'); device not named
- A single run of the demo app, with no build configuration stated
- Baseline decodes on the main thread; any modern loader that decodes in the background would close much of the gap

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> | Conventional | `~35FPS` | `568KB` | `2.40MB`: `1.06MB` + `1.34MB` |
>
> — [github.com/path/FastImageCache/blob/master/README.md](https://github.com/path/FastImageCache/blob/master/README.md)

> | Fast Image Cache | `~59FPS` | `2.2MB` | `1.15MB`: `1.06MB` + `0.09MB` |
>
> — [github.com/path/FastImageCache/blob/master/README.md](https://github.com/path/FastImageCache/blob/master/README.md)

> The takeaway is that Fast Image Cache sacrifices disk usage to achieve a faster framerate and overall less memory usage.
>
> — [github.com/path/FastImageCache/blob/master/README.md](https://github.com/path/FastImageCache/blob/master/README.md)

> As of iOS 7, Apple does not make their hardware JPEG decoder available for third-party applications to use. As a result, only a slower, software decoder is used for this step.
>
> — [github.com/path/FastImageCache/blob/master/README.md](https://github.com/path/FastImageCache/blob/master/README.md)

</details>
