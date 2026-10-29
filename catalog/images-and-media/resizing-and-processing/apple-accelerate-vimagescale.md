# vImage (vImageScale_ARGB8888)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Images and media](../README.md) › [Resizing and processing](README.md)</sub>

**Tier B** (independent measurement) · ❌ Doesn't hold up · Ships with Apple's SDKs · `C` · `Apple SDK` · 🟢 active

> Accelerate's SIMD image scaler; resizing a JPEG from disk was 16x slower than UIGraphicsImageRenderer in an iPhone 7 test.

| | |
|---|---|
| **Beats** | UIGraphicsImageRenderer drawing a UIImage(contentsOfFile:) into a smaller context |
| **Claimed result** | No speedup measured: vImage 2.3126 s vs UIKit 0.1420 s (16.3x slower, derived from page data). |
| **Workload** | Load a 12,000 px square, 20 MB JPEG from disk, scale it to 100 x 100 and return a UIImage; average of XCTest measure() iterations. |
| **Metric** | time |
| **Hardware** | iPhone 7 |
| **OS** | iOS 12.2 |
| **Toolchain** | Swift 5.0; Debug test configuration in the example project's scheme |
| **Measured** | 2019-05-06 |
| **Platforms** | iOS, macOS, tvOS, watchOS, visionOS |
| **Install** | built into iOS and macOS (Accelerate) |
| **Links** | [documentation](https://developer.apple.com/documentation/accelerate/vimage) · [benchmark](https://nshipster.com/image-resizing/) |

## Verdict

In the only end-to-end published comparison found, resizing a 12,000 px JPEG from disk took 2.3126 s with vImage against 0.1420 s with UIGraphicsImageRenderer, about 16x slower, because the vImage path decodes the full-resolution image into a buffer before scaling. The result says nothing about already-decoded pixel buffers.

**Why tier B:** Independent measurement (NSHipster) with public code and the device and OS stated, run in the Debug test configuration.

## Use it when

- You already hold decoded pixel buffers (camera frames, editing pipelines) and need high-quality resampling
- Batch processing inside a pipeline already built on Accelerate

## Skip it when

- Making thumbnails from encoded JPEG, HEIC or PNG files: UIKit and Image I/O were 14x to 16x faster in the published test

## How it is fast

vImageScale_ARGB8888 is a SIMD-vectorized CPU resampler. In this test its speed is beside the point: the vImage path calls CGImageSourceCreateImageAtIndex and vImageBuffer_InitWithCGImage, which decode and copy all 144 million source pixels before scaling begins, while the UIKit path does not pay that full cost.

## What it costs

- Verbose C API: buffer allocation, pixel formats and error codes by hand
- Needs the whole decoded image in memory first

## Problems with the evidence

- Debug test configuration; the timed work is mostly inside Accelerate and ImageIO
- iPhone 7 with iOS 12.2 (2019)
- Decode and scale are timed together; the scaling step alone was not measured

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> performed on an iPhone 7 running iOS 12.2,
>
> — [github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md](https://github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md)

> | Technique #1: `UIKit` | 0.1420 |
>
> — [github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md](https://github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md)

> | Technique #5: `vImage` | 2.3126 |
>
> — [github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md](https://github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md)

> the extra work necessary to use the low-level Accelerate APIs probably isn't justified in most circumstances.
>
> — [github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md](https://github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md)

</details>
