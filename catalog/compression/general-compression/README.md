# General-purpose compression

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Compression](../README.md)</sub>

**The default:** zlib, through the Compression framework or NSData.compressed(using:).

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Compression framework (LZFSE)**](apple-compression-lzfse.md) | Apple's LZFSE matches zlib's ratio while compressing 3.4x and decompressing 2.3x faster in an independent benchmark. | A | ✅ Holds up |
| [**SwiftZSTD (zstd)**](aperedera-swiftzstd.md) | Swift wrapper for zstd; the codec compresses 4.7-15x and decompresses about 4x faster than zlib at similar or better ratios. | A | ✅ Holds up |
| [**Compression framework (LZ4)**](apple-compression-lz4.md) | Apple's LZ4 codec; upstream LZ4 decompresses 12.9x and compresses 6.2x faster than zlib's fastest level, with larger output. | B | ✅ Holds up |
| [**Compression framework (LZMESH)**](apple-compression-lzmesh.md) | Apple's OS 27 general-purpose codec, documented as decoding 3.5x faster than zlib with a better ratio than zlib or LZFSE. | C | ✅ Holds up |
| [**Compression framework (LZRAVEN)**](apple-compression-lzraven.md) | Apple's OS 27 high-ratio codec, documented as decoding 3x faster than LZMA at a similar or slightly better ratio. | C | ✅ Holds up |
| [**SWCompression**](tsolomko-swcompression.md) | Pure-Swift decompressors for Deflate, LZ4, LZMA, BZip2 and archive formats; roughly 23-74x slower than the C codecs. | A | ❌ Doesn't hold up |
