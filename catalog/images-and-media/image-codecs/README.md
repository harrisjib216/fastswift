# Image codecs

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Images and media](../README.md)</sub>

**The default:** ImageIO and UIImage(data:).

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**MetalBlurHash**](lukilabs-metalblurhash.md) | Metal port of BlurHash; decodes a 3840 x 2560 placeholder 250x faster than Wolt's CPU code on an M1 Max. | A | 🟡 Holds up in part |
| [**libjpeg-turbo (on iOS)**](libjpeg-turbo-libjpeg-turbo.md) | SIMD JPEG codec 2-6x faster than libjpeg, but measured no faster than ImageIO's AppleJPEG on iPhone. | B | ❌ Doesn't hold up |
