# Image loading

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Images and media](../README.md)</sub>

**The default:** AsyncImage, or URLSession and UIImage(data:).

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Fast Image Cache**](path-fastimagecache.md) | Stores pre-decoded, byte-aligned thumbnails in memory-mapped image tables; 59 vs 35 FPS scrolling on iOS 7-era hardware. | C | 🟡 Holds up in part |
