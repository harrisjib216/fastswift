# Image I/O (CGImageSourceCreateThumbnailAtIndex)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Images and media](../README.md) › [Resizing and processing](README.md)</sub>

**Tier B** (independent measurement) · 🟡 Holds up in part · Ships with Apple's SDKs · `C` · `Apple SDK` · 🟢 active

> ImageIO's thumbnail call cuts decode memory by about 10x, but timed no faster than UIGraphicsImageRenderer in an iPhone 7 test.

| | |
|---|---|
| **Beats** | UIGraphicsImageRenderer drawing a full UIImage(contentsOfFile:) into a smaller context |
| **Claimed result** | NSHipster (iPhone 7, iOS 12.2): Image I/O 0.1616 s vs UIKit 0.1420 s (UIKit about 12% faster, derived from page data). Nuke: thumbnail decoding 'up to 4x faster' than its Resize processor for high-resolution images. Downsampling in general: 23.7 MB vs 220.2 MB memory. |
| **Workload** | Load a 12,000 px square, 20 MB JPEG from disk, scale it to 100 x 100 and return a UIImage; average of XCTest measure() iterations. |
| **Metric** | time (memory for the downsampling comparison) |
| **Hardware** | iPhone 7 |
| **OS** | iOS 12.2 |
| **Toolchain** | Swift 5.0; Debug test configuration in the example project's scheme |
| **Measured** | 2019-05-06 |
| **Platforms** | iOS, macOS, tvOS, watchOS, visionOS |
| **Install** | built into iOS and macOS |
| **Links** | [documentation](https://developer.apple.com/documentation/imageio/cgimagesourcecreatethumbnailatindex(_:_:_:)) · [benchmark](https://nshipster.com/image-resizing/) |

## Verdict

The common advice to resize with ImageIO thumbnails is about memory, not time: NSHipster's iPhone 7 test timed ImageIO at 0.1616 s against 0.1420 s for UIGraphicsImageRenderer. Nuke's docs report thumbnails up to 4x faster than its own resize processor, but only for high-resolution images and without published data.

**Why tier B:** Independent measurement (NSHipster) with public code and the device and OS stated, run in the Debug test configuration.

## Use it when

- Memory matters: downsampling a 12,000 px image cut memory from 220.2 MB to 23.7 MB in NSHipster's test
- Making thumbnails off the main thread straight from a file URL or Data without creating a UIImage first
- Camera JPEGs with embedded thumbnails, where Nuke reports its largest gains

## Skip it when

- Expecting a speed win over UIGraphicsImageRenderer for ordinary resizing: the independent test showed none
- You need an exact output size or crop; the API fits the image within a maximum pixel size

## How it is fast

CGImageSourceCreateThumbnailAtIndex decodes to a requested maximum pixel size, using an embedded thumbnail when the file has one, so a full-size bitmap need not be kept. Drawing with UIGraphicsImageRenderer creates an image from the full file and rasterizes it into the small context; in NSHipster's test that was not slower, and the article does not say why.

## What it costs

- CoreFoundation-style API configured through option dictionaries
- Output is bounded by a maximum pixel size rather than an exact target size

## Problems with the evidence

- NSHipster ran its XCTest benchmarks in the Debug configuration; the timed work is almost all inside Apple's compiled frameworks, so the effect is likely small, but it is still a debug build
- iPhone 7 with iOS 12.2 (2019); no newer device measurement found
- Nuke's 'up to 4x' comes with no data, device or image set
- The memory table is for downsampling in general, not for the ImageIO technique alone
- Apple's WWDC 2018 session 219 on downsampling, cited by NSHipster, now redirects to the WWDC18 index

## Evidence

<details>
<summary>7 quotes from the sources, checked 2026-10-28</summary>

> performed on an iPhone 7 running iOS 12.2,
>
> — [github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md](https://github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md)

> | Technique #1: `UIKit` | 0.1420 |
>
> — [github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md](https://github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md)

> | Technique #3: `Image I/O` | 0.1616 |
>
> — [github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md](https://github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md)

> | Without Downsampling | 220.2 |
>
> — [github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md](https://github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md)

> | With Downsampling | 23.7 |
>
> — [github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md](https://github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md)

> this image measures 12,000 px square and weighs in at a whopping 20 MB.
>
> — [github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md](https://github.com/NSHipster/articles/blob/master/2019-05-06-image-resizing.md)

> It can be up to 4x faster than using ``ImageProcessors/Resize`` for high-resolution images.
>
> — [github.com/kean/Nuke/blob/main/Documentation/Nuke.docc/Performance/…](https://github.com/kean/Nuke/blob/main/Documentation/Nuke.docc/Performance/performance-guide.md)

</details>
