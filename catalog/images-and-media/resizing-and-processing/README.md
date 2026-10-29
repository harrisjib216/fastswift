# Resizing and processing

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Images and media](../README.md)</sub>

**The default:** UIGraphicsImageRenderer and UIImage.draw(in:).

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Image I/O (CGImageSourceCreateThumbnailAtIndex)**](apple-imageio-cgimagesourcecreatethumbnailatindex.md) | ImageIO's thumbnail call cuts decode memory by about 10x, but timed no faster than UIGraphicsImageRenderer in an iPhone 7 test. | B | 🟡 Holds up in part |
| [**GPUImage (OpenGL ES)**](bradlarson-gpuimage.md) | OpenGL ES filter framework that beat iOS 5 Core Image by 40x on an iPhone 4 and 4x on a 4S; unmaintained since 2016. | C | 🟡 Holds up in part |
| [**Core Image (CILanczosScaleTransform)**](apple-coreimage-cilanczosscaletransform.md) | Core Image's Lanczos scale filter; resizing a JPEG from disk was about 17.6x slower than UIGraphicsImageRenderer on an iPhone 7. | B | ❌ Doesn't hold up |
| [**vImage (vImageScale_ARGB8888)**](apple-accelerate-vimagescale.md) | Accelerate's SIMD image scaler; resizing a JPEG from disk was 16x slower than UIGraphicsImageRenderer in an iPhone 7 test. | B | ❌ Doesn't hold up |
