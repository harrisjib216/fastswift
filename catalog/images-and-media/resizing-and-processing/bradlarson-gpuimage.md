# GPUImage (OpenGL ES)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Images and media](../README.md) › [Resizing and processing](README.md)</sub>

**Tier C** (first-party numbers) · 🟡 Holds up in part · Open source · `Objective-C` · `BSD-3-Clause` · 🔴 abandoned

> OpenGL ES filter framework that beat iOS 5 Core Image by 40x on an iPhone 4 and 4x on a 4S; unmaintained since 2016.

| | |
|---|---|
| **Beats** | Core Image on iOS 5 for live camera filtering |
| **Claimed result** | iPhone 4: 2.5 ms per frame vs 106 ms with Core Image (40X) and 460 ms on the CPU (184X); iPhone 4S: 4X faster than Core Image and 102X faster than CPU-bound processing. |
| **Workload** | Upload a camera frame, apply a gamma filter and display it. |
| **Metric** | latency |
| **Hardware** | iPhone 4; iPhone 4S |
| **OS** | iOS 5 |
| **Adoption** | 20.3k stars |
| **Last commit** | 2016-05-26 |
| **Platforms** | iOS 4.1+ (OpenGL ES 2.0), macOS |
| **Install** | CocoaPods, static library |
| **Links** | [repository](https://github.com/BradLarson/GPUImage) · [benchmark](https://github.com/BradLarson/GPUImage#overview) |

## Verdict

The README's 40X figure is for an iPhone 4 against iOS 5 Core Image; on an iPhone 4S the same README reports only 4X, and it says Core Image was already faster for large-radius Gaussian blurs. GPUImage is built on OpenGL ES, deprecated by Apple in iOS 12, and has had no commits since 2016, so the result says nothing about today's Metal-backed Core Image.

**Why tier C:** First-party numbers naming the devices, with no OS build, toolchain or raw data; the benchmark app shows results only in-app.

## Use it when

- Maintaining legacy code that already depends on it

## Skip it when

- Any new code: OpenGL ES is deprecated and the project is unmaintained (its Metal successor, GPUImage3, publishes no benchmark numbers)
- Large-radius blurs, where the README says Core Image was already faster

## How it is fast

GPUImage uploads camera frames as OpenGL ES textures and runs each filter as a fragment shader, chaining filters through framebuffers so a frame stays on the GPU until it is displayed. In 2012 Core Image on iOS 5 carried more per-frame overhead for a simple filter like this.

## What it costs

- Built on OpenGL ES, which Apple deprecated in iOS 12
- Lacks Core Image features such as face detection (per the README)

## Problems with the evidence

- iPhone 4 and 4S against iOS 5-era Core Image; Core Image has since moved to Metal
- The README's own 4S figure shrinks the gap from 40X to 4X
- No build configuration or raw data published

## Evidence

<details>
<summary>5 quotes from the sources, checked 2026-10-28</summary>

> This framework compares favorably to Core Image when handling video, taking only 2.5 ms on an iPhone 4 to upload a frame from the camera, apply a gamma filter, and display, versus 106 ms for the same operation using Core Image.
>
> — [github.com/BradLarson/GPUImage/blob/master/README.md](https://github.com/BradLarson/GPUImage/blob/master/README.md)

> CPU-based processing takes 460 ms, making GPUImage 40X faster than Core Image for this operation on this hardware, and 184X faster than CPU-bound processing.
>
> — [github.com/BradLarson/GPUImage/blob/master/README.md](https://github.com/BradLarson/GPUImage/blob/master/README.md)

> On an iPhone 4S, GPUImage is only 4X faster than Core Image for this case, and 102X faster than CPU-bound processing.
>
> — [github.com/BradLarson/GPUImage/blob/master/README.md](https://github.com/BradLarson/GPUImage/blob/master/README.md)

> However, for more complex operations like Gaussian blurs at larger radii, Core Image currently outpaces GPUImage.
>
> — [github.com/BradLarson/GPUImage/blob/master/README.md](https://github.com/BradLarson/GPUImage/blob/master/README.md)

> In comparison to Core Image (part of iOS 5.0)
>
> — [github.com/BradLarson/GPUImage/blob/master/README.md](https://github.com/BradLarson/GPUImage/blob/master/README.md)

</details>
