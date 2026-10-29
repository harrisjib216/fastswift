# ZIPFoundation

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Compression](../README.md) › [ZIP archives](README.md)</sub>

**Tier D** (directional only) · 🟡 Holds up in part · Open source · `Swift` · `MIT` · 🟢 active

> Pure-Swift ZIP library on Apple's libcompression; its 2017 charts show faster extraction than macOS unzip, with no SSZipArchive comparison.

| | |
|---|---|
| **Beats** | SSZipArchive (ZipArchive, minizip-based); the published test actually used macOS's zip/unzip command-line tools |
| **Claimed result** | Extraction faster than macOS unzip (chart only); the author credits Apple's libcompression with making zlib decoding 60% faster |
| **Workload** | Extract, add and remove ZIP entries of various sizes, 10 runs each, average milliseconds |
| **Metric** | time |
| **OS** | macOS Sierra 10.12.5 |
| **Toolchain** | -Ofast with whole-module optimization |
| **Measured** | 2017-07 |
| **Adoption** | 2.7k stars |
| **Last commit** | 2026-09-12 |
| **Platforms** | macOS 10.11+, iOS 9+, tvOS 9+, watchOS 2+, Linux |
| **Install** | Swift Package Manager, CocoaPods, Carthage |
| **Links** | [repository](https://github.com/weichsel/ZIPFoundation) · [benchmark](https://thomas.zoechling.me/journal/2017/07/ZIPFoundation.html) |

## Verdict

The only published numbers compare against the macOS zip/unzip tools, not SSZipArchive, appear only in 2017 charts, and show gains mainly for extraction, where Apple's faster zlib decoder does the work. No head-to-head against SSZipArchive was found.

**Why tier D:** First-party benchmark whose numbers exist only in chart images; the text gives only the 60% zlib decode figure attributed to Apple.

## Use it when

- Extracting ZIP archives on Apple platforms with a pure-Swift API
- Reading or writing archives in memory without touching disk
- Linux support with the same API

## Skip it when

- Password-protected or AES-encrypted ZIPs (not supported)
- Workloads dominated by creating archives, where the charts show little gain
- Debug builds: the maintainer says DEBUG builds are far slower, and CRC32 in debug was about an order of magnitude slower

## How it is fast

It reads and writes the ZIP container in Swift and hands Deflate decoding to Apple's Compression framework, whose zlib decoder Apple optimized. Compression goes through the same framework, which Apple did not speed up, so adding entries gains little. On Linux it falls back to stock zlib.

## What it costs

- No encryption support
- Compression speed limited to Apple's zlib encoder (level 5 only)

## Problems with the evidence

- Baseline was the command-line zip/unzip tools, not SSZipArchive or marmelroy/Zip
- Numbers are only in chart images from 2017 on macOS 10.12.5; hardware not stated
- The 60% figure describes Apple's zlib decoder, not ZIPFoundation as a whole
- Later issues report slow behaviour in DEBUG builds and when opening many archives

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> Apple somehow managed to speed-up the decoding part of zlib by 60% while still maintaining compatibility.
>
> — [thomas.zoechling.me/journal/2017/07/ZIPFoundation.html](https://thomas.zoechling.me/journal/2017/07/ZIPFoundation.html)

> The baseline performance is established by the default zip/unzip command line tools on macOS.
>
> — [thomas.zoechling.me/journal/2017/07/ZIPFoundation.html](https://thomas.zoechling.me/journal/2017/07/ZIPFoundation.html)

> The benchmark was executed on macOS Sierra 10.12.5.
>
> — [thomas.zoechling.me/journal/2017/07/ZIPFoundation.html](https://thomas.zoechling.me/journal/2017/07/ZIPFoundation.html)

> ZIP entry extraction. Time in milliseconds. Lower is better.
>
> — [thomas.zoechling.me/journal/2017/07/ZIPFoundation.html](https://thomas.zoechling.me/journal/2017/07/ZIPFoundation.html)

</details>
