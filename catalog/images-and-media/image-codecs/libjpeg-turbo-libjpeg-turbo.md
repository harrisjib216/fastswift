# libjpeg-turbo (on iOS)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Images and media](../README.md) › [Image codecs](README.md)</sub>

**Tier B** (independent measurement) · ❌ Doesn't hold up · Open source · `C` · `NOASSERTION` · 🟢 active

> SIMD JPEG codec 2-6x faster than libjpeg, but measured no faster than ImageIO's AppleJPEG on iPhone.

| | |
|---|---|
| **Beats** | ImageIO JPEG decoding (Apple's AppleJPEG path) behind UIImage(data:) |
| **Claimed result** | libjpeg-turbo: 'generally 2-6x as fast as libjpeg'. On iOS (iPhone 6): AppleJPEG encode/decode speed usually 1~2 倍 (1-2x) that of libjpeg-turbo, so libjpeg-turbo is at best equal to the default. |
| **Workload** | Encoding and decoding test photos on an iPhone 6 with ImageIO (AppleJPEG) and with libjpeg-turbo. |
| **Metric** | time |
| **Hardware** | iPhone 6 |
| **Measured** | 2015-11-02 |
| **Adoption** | 4.5k stars |
| **Last commit** | 2026-10-26 |
| **Platforms** | iOS, macOS, Linux, Windows, Android |
| **Install** | Build from source with CMake |
| **Links** | [repository](https://github.com/libjpeg-turbo/libjpeg-turbo) · [benchmark](https://blog.ibireme.com/2015/11/02/mobile_image_benchmark/) |

## Verdict

libjpeg-turbo's 2-6x claim is against libjpeg, which is not what iOS uses for JPEG. On an iPhone 6 an independent test found Apple's AppleJPEG path in ImageIO usually 1-2x the speed of libjpeg-turbo, so bundling it to decode JPEG faster than the system is not supported.

**Why tier B:** Independent measurement by a third-party developer with public test code, but from 2015 on an iPhone 6 with no OS or build details.

## Use it when

- You need JPEG features ImageIO lacks, such as lossless transforms (jpegtran) or exact control of encoder parameters
- Cross-platform C code that must behave identically on iOS, Android and servers

## Skip it when

- Speeding up JPEG decoding in an iOS app: the only iOS measurement found puts ImageIO ahead
- You want hardware-assisted decoding and lower battery use

## How it is fast

libjpeg-turbo rewrites libjpeg's color conversion, IDCT and upsampling with SIMD (NEON on ARM) and speeds up Huffman coding. That beats libjpeg's scalar C, but ImageIO on iOS routes JPEG through Apple's AppleJPEG, which the benchmark author says uses the chip's hardware codec and falls back to libjpeg only when that fails.

## What it costs

- Adds a C library and a CMake build to the app
- CPU-only decoding
- GitHub does not detect the license (NOASSERTION); the code is under the IJG, BSD 3-Clause and zlib licenses

## Problems with the evidence

- 2015 iPhone 6 measurement; no newer iOS comparison was found
- The 1-2x figure is a summary sentence; per-image numbers are in chart images
- The 2-6x claim is relative to libjpeg on desktop and server CPUs, not to ImageIO
- The '1~2' text spans two HTML elements on the blog page

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> libjpeg-turbo is generally 2-6x as fast as libjpeg, all else being equal.
>
> — [github.com/libjpeg-turbo/libjpeg-turbo/blob/main/README.md](https://github.com/libjpeg-turbo/libjpeg-turbo/blob/main/README.md)

> 在我的测试中，其编解码速度通常是 libjpeg-turbo 的 1~2 倍。
>
> — [blog.ibireme.com/2015/11/02/mobile_image_benchmark/](https://blog.ibireme.com/2015/11/02/mobile_image_benchmark/)

> 除了上面这三个库，苹果自己也开发了一个 AppleJPEG，但并没有开源。其调用了芯片提供的 DSP 硬编码和硬解码的功能。
>
> — [blog.ibireme.com/2015/11/02/mobile_image_benchmark/](https://blog.ibireme.com/2015/11/02/mobile_image_benchmark/)

> 下面是 ImageIO (AppleJPEG/libpng) 在 iPhone 6 上的编解码性能：
>
> — [blog.ibireme.com/2015/11/02/mobile_image_benchmark/](https://blog.ibireme.com/2015/11/02/mobile_image_benchmark/)

</details>
