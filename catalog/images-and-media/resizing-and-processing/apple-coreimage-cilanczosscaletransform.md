# Core Image (CILanczosScaleTransform)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Images and media](../README.md) › [Resizing and processing](README.md)</sub>

**Tier B** (independent measurement) · ❌ Doesn't hold up · Ships with Apple's SDKs · `Objective-C` · `Apple SDK` · 🟢 active

> Core Image's Lanczos scale filter; resizing a JPEG from disk was about 17.6x slower than UIGraphicsImageRenderer on an iPhone 7.

| | |
|---|---|
| **Beats** | UIGraphicsImageRenderer drawing a UIImage(contentsOfFile:) into a smaller context |
| **Claimed result** | No speedup measured: Core Image 2.4983 s vs UIKit 0.1420 s (17.6x slower, derived from page data); the software renderer was 'an order of magnitude slower' still. |
| **Workload** | Load a 12,000 px square, 20 MB JPEG from disk, scale it to 100 x 100 with CILanczosScaleTransform through a shared GPU CIContext and return a UIImage; average of XCTest measure() iterations. |
| **Metric** | time |
| **Hardware** | iPhone 7 |
| **OS** | iOS 12.2 |
| **Toolchain** | Swift 5.0; Debug test configuration in the example project's scheme |
| **Measured** | 2019-05-06 |
| **Platforms** | iOS, macOS, tvOS, visionOS |
| **Install** | built into iOS and macOS |
| **Links** | [documentation](https://developer.apple.com/documentation/coreimage) · [benchmark](https://nshipster.com/image-resizing/) |

## Verdict

NSHipster measured 2.4983 s against 0.1420 s for UIKit (about 17.6x slower) with a shared GPU CIContext on an iPhone 7, and the article points to Apple's own Core Image performance guidance to crop and downsample with Core Graphics or Image I/O instead. Forcing the software renderer was an order of magnitude slower again.

**Why tier B:** Independent measurement (NSHipster) with public code and the device and OS stated, run in the Debug test configuration.

## Use it when

- Resizing is one step in a longer Core Image filter chain that stays on the GPU, such as photo or video effects
- You need Lanczos quality and already render through a shared CIContext

## Skip it when

- One-off resizing of images loaded from disk or the network
- Creating a CIContext per call, or using the software renderer

## How it is fast

Core Image builds a filter graph and renders it on the GPU through a CIContext, applying a Lanczos kernel. For a one-off resize that means decoding the full image, uploading it, rendering and reading back, which outweighs the GPU's arithmetic advantage.

## What it costs

- Needs a long-lived CIContext and GPU access
- Full-resolution decode before filtering

## Problems with the evidence

- Debug test configuration; the timed work is mostly inside Apple's frameworks
- iPhone 7 with iOS 12.2 (2019); Core Image's Metal backend has changed since
- Decode, render and readback are timed together

## Evidence

<details>
<summary>5 quotes from the sources, checked 2026-10-28</summary>

> performed on an iPhone 7 running iOS 12.2,
>
> — [github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md](https://github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md)

> | Technique #1: `UIKit` | 0.1420 |
>
> — [github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md](https://github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md)

> | Technique #4: `Core Image` <sup>2</sup> | 2.4983 |
>
> — [github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md](https://github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md)

> yielded results an order of magnitude slower than base results.
>
> — [github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md](https://github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md)

> you should use Core Graphics or Image I/O functions to crop and downsample images instead of Core Image.
>
> — [github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md](https://github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md)

</details>
