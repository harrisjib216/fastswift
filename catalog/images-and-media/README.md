# Images and media

<sub>[fastswift](../../README.md) › [Catalog](../README.md)</sub>

## [Image loading](image-loading/README.md)

**The default:** AsyncImage, or URLSession and UIImage(data:).

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Fast Image Cache**](image-loading/path-fastimagecache.md) | Stores pre-decoded, byte-aligned thumbnails in memory-mapped image tables; 59 vs 35 FPS scrolling on iOS 7-era hardware. | C | 🟡 Holds up in part |

## [Image codecs](image-codecs/README.md)

**The default:** ImageIO and UIImage(data:).

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**MetalBlurHash**](image-codecs/lukilabs-metalblurhash.md) | Metal port of BlurHash; decodes a 3840 x 2560 placeholder 250x faster than Wolt's CPU code on an M1 Max. | A | 🟡 Holds up in part |
| [**libjpeg-turbo (on iOS)**](image-codecs/libjpeg-turbo-libjpeg-turbo.md) | SIMD JPEG codec 2-6x faster than libjpeg, but measured no faster than ImageIO's AppleJPEG on iPhone. | B | ❌ Doesn't hold up |

## [Resizing and processing](resizing-and-processing/README.md)

**The default:** UIGraphicsImageRenderer and UIImage.draw(in:).

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Image I/O (CGImageSourceCreateThumbnailAtIndex)**](resizing-and-processing/apple-imageio-cgimagesourcecreatethumbnailatindex.md) | ImageIO's thumbnail call cuts decode memory by about 10x, but timed no faster than UIGraphicsImageRenderer in an iPhone 7 test. | B | 🟡 Holds up in part |
| [**GPUImage (OpenGL ES)**](resizing-and-processing/bradlarson-gpuimage.md) | OpenGL ES filter framework that beat iOS 5 Core Image by 40x on an iPhone 4 and 4x on a 4S; unmaintained since 2016. | C | 🟡 Holds up in part |
| [**Core Image (CILanczosScaleTransform)**](resizing-and-processing/apple-coreimage-cilanczosscaletransform.md) | Core Image's Lanczos scale filter; resizing a JPEG from disk was about 17.6x slower than UIGraphicsImageRenderer on an iPhone 7. | B | ❌ Doesn't hold up |
| [**vImage (vImageScale_ARGB8888)**](resizing-and-processing/apple-accelerate-vimagescale.md) | Accelerate's SIMD image scaler; resizing a JPEG from disk was 16x slower than UIGraphicsImageRenderer in an iPhone 7 test. | B | ❌ Doesn't hold up |

## [Animated images](animated-images/README.md)

**The default:** UIImage.animatedImage(with:) and UIImageView's animationImages.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**FLAnimatedImage**](animated-images/flipboard-flanimatedimage.md) | GIF player that decodes frames just in time instead of holding all of them; its memory savings were never published as measurements. | D | 🟡 Holds up in part |
