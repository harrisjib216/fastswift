<h1 align="center">fastswift</h1>

<!-- fastswift:badges -->
<p align="center">
  <img alt="entries: 108" src="https://img.shields.io/badge/entries-108-2ea44f">
  <img alt="tier A: 37" src="https://img.shields.io/badge/tier_A-37-1f6feb">
  <img alt="categories: 39" src="https://img.shields.io/badge/categories-39-8250df">
  <img alt="claims rejected: 14" src="https://img.shields.io/badge/claims_rejected-14-cf222e">
  <img alt="license: MIT" src="https://img.shields.io/badge/license-MIT-blue">
</p>
<!-- /fastswift:badges -->

<p align="center"><b>Find something faster than the default you reach for in Swift, along with the benchmark, the default it beats, and the catch.</b></p>

**fastswift** is a catalog of Swift libraries, Apple frameworks and developer tools that claim to be faster than the
defaults Swift developers use: JSONDecoder, Array, NSLock, Core Data, Auto Layout, UIGraphicsImageRenderer, zlib,
Vapor, xcodebuild and others. Every entry names what it beats, quotes the published numbers, grades how far those
numbers can be trusted, and says what goes wrong if you adopt it. Claims that don't hold up stay in the catalog,
marked as rejected, because knowing what not to switch to is half the value.

It is the Swift edition of [fastpp](https://github.com/harrisjib216/fastpp), which does the same for C++.

<!-- fastswift:stats -->
**108 entries** across **39 categories** in **12 domains** · 37 tier A · 23 tier B · 34 tier C · 14 tier D · 37 hold up · 57 hold up in part · 14 rejected
<!-- /fastswift:stats -->

## Find something faster

<!-- fastswift:index -->
| Domain | Entries | Categories |
|---|--:|---|
| [**Data formats**](catalog/data-formats/README.md) | 15 | [JSON](catalog/data-formats/json/README.md) 9 · [Binary serialization](catalog/data-formats/binary-serialization/README.md) 2 · [XML and HTML](catalog/data-formats/xml-and-html/README.md) 1 · [Base64 and encoding](catalog/data-formats/base64-and-encoding/README.md) 2 · [Markdown](catalog/data-formats/markdown/README.md) 1 |
| [**Collections**](catalog/collections/README.md) | 12 | [Deques and queues](catalog/collections/deques-and-queues/README.md) 1 · [Ordered and sorted collections](catalog/collections/ordered-and-sorted/README.md) 2 · [Persistent and tree collections](catalog/collections/persistent-and-tree/README.md) 1 · [Heaps and bit sets](catalog/collections/heaps-and-bitsets/README.md) 2 · [Diffing](catalog/collections/diffing/README.md) 5 · [Sorting and searching](catalog/collections/sorting-and-searching/README.md) 1 |
| [**Concurrency and runtime**](catalog/concurrency-and-runtime/README.md) | 6 | [Locks and atomics](catalog/concurrency-and-runtime/locks-and-atomics/README.md) 3 · [Reactive streams](catalog/concurrency-and-runtime/reactive-streams/README.md) 1 · [Logging](catalog/concurrency-and-runtime/logging/README.md) 2 |
| [**Crypto and hashing**](catalog/crypto-and-hashing/README.md) | 4 | [Cryptographic hashes and ciphers](catalog/crypto-and-hashing/crypto-hashes-and-ciphers/README.md) 1 · [Non-cryptographic hashes](catalog/crypto-and-hashing/non-crypto-hashes/README.md) 1 · [Random numbers](catalog/crypto-and-hashing/random-numbers/README.md) 2 |
| [**Compression**](catalog/compression/README.md) | 7 | [General-purpose compression](catalog/compression/general-compression/README.md) 6 · [ZIP archives](catalog/compression/archives/README.md) 1 |
| [**Storage**](catalog/storage/README.md) | 8 | [SQLite and object stores](catalog/storage/sqlite-and-orms/README.md) 5 · [Caches and key-value stores](catalog/storage/caches-and-key-value/README.md) 3 |
| [**Images and media**](catalog/images-and-media/README.md) | 8 | [Image loading](catalog/images-and-media/image-loading/README.md) 1 · [Image codecs](catalog/images-and-media/image-codecs/README.md) 2 · [Resizing and processing](catalog/images-and-media/resizing-and-processing/README.md) 4 · [Animated images](catalog/images-and-media/animated-images/README.md) 1 |
| [**UI and rendering**](catalog/ui-and-rendering/README.md) | 10 | [Layout](catalog/ui-and-rendering/layout/README.md) 5 · [Lists and scrolling](catalog/ui-and-rendering/lists-and-scrolling/README.md) 2 · [Text rendering](catalog/ui-and-rendering/text-rendering/README.md) 1 · [Animation and vector graphics](catalog/ui-and-rendering/animation-and-vector/README.md) 2 |
| [**Text processing**](catalog/text-processing/README.md) | 6 | [Regular expressions](catalog/text-processing/regex/README.md) 1 · [Parsing and strings](catalog/text-processing/parsing-and-strings/README.md) 1 · [Dates and numbers](catalog/text-processing/dates-and-numbers/README.md) 4 |
| [**Server and networking**](catalog/server-and-networking/README.md) | 6 | [Web frameworks](catalog/server-and-networking/web-frameworks/README.md) 4 · [Database drivers](catalog/server-and-networking/database-drivers/README.md) 2 |
| [**ML and numerics**](catalog/ml-and-numerics/README.md) | 12 | [On-device inference](catalog/ml-and-numerics/on-device-inference/README.md) 7 · [Linear algebra and DSP](catalog/ml-and-numerics/linear-algebra-and-dsp/README.md) 5 |
| [**Build and tooling**](catalog/tooling/README.md) | 14 | [Build systems and caching](catalog/tooling/build-and-caching/README.md) 6 · [Linkers](catalog/tooling/linkers/README.md) 3 · [Developer tools](catalog/tooling/developer-tools/README.md) 5 |
<!-- /fastswift:index -->

Browse everything from the [catalog index](catalog/README.md), or query the export,
[`catalog/catalog.jsonl`](catalog/catalog.jsonl) (one entry per line, [schema](docs/schema.md)).

## Highlights

The strongest entry in each domain whose claim holds up as stated.

<!-- fastswift:featured -->
| Need faster… | Pick | What it is | Tier |
|---|---|---|:-:|
| [Binary serialization](catalog/data-formats/binary-serialization/README.md) | [**SwiftProtobuf (binary wire format)**](catalog/data-formats/binary-serialization/apple-swift-protobuf.md) | Apple's Protocol Buffers runtime for Swift; 5-19x the throughput of Codable JSON in a third-party benchmark, at about half the bytes. | **A** |
| [Deques and queues](catalog/collections/deques-and-queues/README.md) | [**swift-collections (Deque)**](catalog/collections/deques-and-queues/apple-swift-collections-deque.md) | Apple's ring-buffer double-ended queue; constant-time prepend and popFirst where Array.insert(at: 0) and removeFirst are linear. | **A** |
| [Locks and atomics](catalog/concurrency-and-runtime/locks-and-atomics/README.md) | [**os_unfair_lock (os framework)**](catalog/concurrency-and-runtime/locks-and-atomics/apple-os-os-unfair-lock.md) | Apple's unfair lock: about 29x faster than DispatchQueue.sync and 1.4x faster than pthread_mutex in an uncontended loop. | **A** |
| [Random numbers](catalog/crypto-and-hashing/random-numbers/README.md) | [**CwlUtils (Xoshiro)**](catalog/crypto-and-hashing/random-numbers/mattgallagher-cwlutils-xoshiro.md) | Swift Xoshiro256** generator from CwlUtils; 69x faster than arc4random_buf, the source behind SystemRandomNumberGenerator. | **A** |
| [General-purpose compression](catalog/compression/general-compression/README.md) | [**SwiftZSTD (zstd)**](catalog/compression/general-compression/aperedera-swiftzstd.md) | Swift wrapper for zstd; the codec compresses 4.7-15x and decompresses about 4x faster than zlib at similar or better ratios. | **A** |
| [SQLite and object stores](catalog/storage/sqlite-and-orms/README.md) | [**GRDB.swift (records against Core Data)**](catalog/storage/sqlite-and-orms/groue-grdb-swift.md) | SQLite toolkit for Swift whose record types fetched rows about 1.9x faster than Core Data in its own Release-build harness. | **A** |
| [Layout](catalog/ui-and-rendering/layout/README.md) | [**Texture (ASDisplayNode, ASCollectionNode)**](catalog/ui-and-rendering/layout/texturegroup-texture.md) | Node-based UI framework (ex-AsyncDisplayKit) that cut main-thread cell layout time 5.4x vs Auto Layout in an independent 2025 run. | **A** |
| [Dates and numbers](catalog/text-processing/dates-and-numbers/README.md) | [**Date.FormatStyle (Swift Foundation, macOS 14 / iOS 17)**](catalog/text-processing/dates-and-numbers/apple-foundation-date-formatstyle.md) | Apple reports a 150% speedup for Date.FormatStyle template formatting after Foundation's Swift rewrite in macOS 14 and iOS 17. | **C** |
| [Database drivers](catalog/server-and-networking/database-drivers/README.md) | [**SQLKit query builder (in Vapor, on PostgresKit)**](catalog/server-and-networking/database-drivers/vapor-sql-kit.md) | SQLKit's typed SQL builder in Vapor, measured at about 1.6-2.1x Fluent's throughput in TechEmpower Rounds 20 and 22. | **A** |
| [On-device inference](catalog/ml-and-numerics/on-device-inference/README.md) | [**Core ML stateful models (KV cache as model state)**](catalog/ml-and-numerics/on-device-inference/apple-coreml-stateful-models.md) | Core ML states keep an LLM's KV cache inside the model, decoding about 13x faster than passing the cache as inputs at 2K context. | **B** |
| [Build systems and caching](catalog/tooling/build-and-caching/README.md) | [**Tuist (module cache)**](catalog/tooling/build-and-caching/tuist-tuist.md) | Xcode project generator whose module cache swaps unchanged targets for prebuilt binaries, cutting clean builds 2-3x in its benchmarks. | **A** |
<!-- /fastswift:featured -->

## The default caught up

Swift's defaults move. Apple rewrote Foundation in Swift, rebuilt the linker and sped up Auto Layout, and several
libraries that existed to beat the old defaults now lose to the new ones. A benchmark from 2019 can be right about
2019 and wrong about today, so every entry records when and where it was measured.

- **JSON.** [ZippyJSON](catalog/data-formats/json/michaeleisel-zippyjson.md) decoded 3-4x faster than the
  NSJSONSerialization-backed JSONDecoder. Then Apple's
  [Swift rewrite of JSONDecoder](catalog/data-formats/json/apple-foundation-jsondecoder.md) landed in iOS 17 and
  macOS 14, and ZippyJSON's own README now says the system decoder is faster there. IkigaJSON's 2026 benchmark puts
  it level with or behind Foundation.
- **Linking.** [zld](catalog/tooling/linkers/michaeleisel-zld.md) linked about 40% faster than ld64 in 2020. LLD
  passed it, then Apple's [ld-prime](catalog/tooling/linkers/apple-xcode-ld-prime.md) became the default in Xcode
  15. Chromium's documentation now calls it faster than LLD.
- **Base64.** [swift-extras-base64](catalog/data-formats/base64-and-encoding/swift-extras-swift-extras-base64.md)
  was 3-4x faster than Foundation's Base64 on macOS in 2020. In 2025 the same author
  [merged a faster Base64 into Foundation itself](catalog/data-formats/base64-and-encoding/apple-foundation-base64.md),
  so the gap has likely closed, though no one has published a direct comparison.
- **Layout.** PinLayout's README says 8-12x faster than Auto Layout, measured on iOS 11. The same benchmark on an
  iPhone 16 in 2025 says about 3x, partly because
  [Auto Layout got faster in iOS 12](catalog/ui-and-rendering/layout/apple-uikit-auto-layout.md).

## Claims that don't hold up

<!-- fastswift:rejected -->
| Claim | Why it doesn't hold up |
|---|---|
| [**Core Image (CILanczosScaleTransform)**](catalog/images-and-media/resizing-and-processing/apple-coreimage-cilanczosscaletransform.md) | NSHipster measured 2.4983 s against 0.1420 s for UIKit (about 17.6x slower) with a shared GPU CIContext on an iPhone 7, and the article points to Apple's own Core Image performance guidance to crop and downsample with Core Graphics or Image I/O instead. Forcing the software renderer was an order of magnitude slower again. |
| [**CryptoSwift**](catalog/crypto-and-hashing/crypto-hashes-and-ciphers/krzyzanowskim-cryptoswift.md) | Every published comparison found has CommonCrypto ahead: 3.5x on a SHA-256 loop and 57x on 10 MB AES-256 encryption. The one report of CryptoSwift beating CryptoKit was against the 2019 CryptoKit beta on tiny inputs, and on the same harness CommonCrypto was 3.5x faster than CryptoSwift. |
| [**Differ**](catalog/collections/diffing/tonyarnold-differ.md) | The README's baseline is an early Dwifft, not a default anyone would reach for today. In DifferenceKit's release build, Differ took 1.0581 s on 5,000 elements, 17x slower than the standard library's difference(from:) and also slower than Dwifft 0.9, so it is not a faster choice than the default. |
| [**Down**](catalog/data-formats/markdown/johnxnguyen-down.md) | The README's numbers are upstream cmark's own C benchmarks against Markdown.pl, not a measurement of Down against any Swift default. Apple's swift-markdown, the usual Swift choice, is itself built on cmark-gfm, so the figures show no advantage over it. |
| [**Dwifft**](catalog/collections/diffing/jflinter-dwifft.md) | The README gives no numbers, only 'many orders of magnitude' faster than a naive implementation and 'almost certainly won't be the bottleneck'. In DifferenceKit's release build Dwifft 0.9 took 0.4732 s for 5,000 elements, 7.6x slower than the standard library's diff, and 187 s for 100,000, which would block a UI thread. |
| [**Hummingbird 2 (HTTP server framework)**](catalog/server-and-networking/web-frameworks/hummingbird-project-hummingbird-v2.md) | Hummingbird's reputation as the faster Swift framework comes from the 1.x rows. In Round 23, the only official round with Hummingbird 2, it was slower than Vapor on both plaintext and JSON, and its Postgres implementation failed to start, so there is no database result either. |
| [**IkigaJSON (orlandos-nl/swift-json)**](catalog/data-formats/json/orlandos-nl-swift-json.md) | The project's current benchmark on macOS 26 has it within about 10% of Foundation on small and medium payloads and slower on the large one (decode 556 μs vs 381 μs, encode 329 μs vs 300 μs). Its remaining advantage is fewer allocations when decoding, not speed. |
| [**Kitura (web framework)**](catalog/server-and-networking/web-frameworks/kitura-kitura.md) | In Round 19 (2020), the last official round with Kitura results, Kitura served about a third of Vapor's plaintext throughput and half its JSON throughput, and its SwiftNIO-based variant still trailed at 0.60x and 0.66x. Its ORM beat Vapor with Fluent on the single-query test by 1.27x, but the project has had no commits since October 2022 and TechEmpower removed it in 2024. |
| [**libjpeg-turbo (on iOS)**](catalog/images-and-media/image-codecs/libjpeg-turbo-libjpeg-turbo.md) | libjpeg-turbo's 2-6x claim is against libjpeg, which is not what iOS uses for JPEG. On an iPhone 6 an independent test found Apple's AppleJPEG path in ImageIO usually 1-2x the speed of libjpeg-turbo, so bundling it to decode JPEG faster than the system is not supported. |
| [**Rive (rive-ios, vs Lottie)**](catalog/ui-and-rendering/animation-and-vector/rive-app-rive-ios.md) | The widely cited numbers (Rive near 60 FPS vs Lottie at 17 FPS) come from a React Native app on a 2014 Android phone, not from lottie-ios. In the same test Rive used more total memory. Rive's own Apple documentation warns that app-only profiling is not a fair comparison against Core Animation-based Lottie. No iOS speed comparison was found. |
| [**RxSwift**](catalog/concurrency-and-runtime/reactive-streams/reactivex-rxswift.md) | In the only published operator-by-operator comparison, Combine was faster than RxSwift in 10 of 11 tests in release builds; RxSwift won only MapFilterPumping, by 7%. An independent reviewer put the release-build difference at small, with each framework faster in some cases. |
| [**SWCompression**](catalog/compression/general-compression/tsolomko-swcompression.md) | Its own benchmarks on an M4 MacBook Air show Deflate decompression at about 13.5 MB/s and LZ4 decompression at 52-70 MB/s. Stock zlib decompresses at 314 MB/s and LZ4 at 3832 MB/s on a server core, so the pure-Swift codecs are one to two orders of magnitude slower than the C ones they would replace. |
| [**vImage (vImageScale_ARGB8888)**](catalog/images-and-media/resizing-and-processing/apple-accelerate-vimagescale.md) | In the only end-to-end published comparison found, resizing a 12,000 px JPEG from disk took 2.3126 s with vImage against 0.1420 s with UIGraphicsImageRenderer, about 16x slower, because the vImage path decodes the full-resolution image into a buffer before scaling. The result says nothing about already-decoded pixel buffers. |
| [**zld**](catalog/tooling/linkers/michaeleisel-zld.md) | zld was about 40% faster than the ld64 of 2019-2020, but it is archived, never supported an Xcode 14 change, and its author says better-funded linkers caught up and surpassed it in 2022. ld-prime, the default since Xcode 15, is now faster than LLD, which had already passed zld. The default caught up. |
<!-- /fastswift:rejected -->

## What an entry tells you

Each entry has its own page with the same parts:

- **Beats.** The specific default, with its version where that matters ("JSONDecoder before the 2023 rewrite").
- **Claimed result.** The published numbers, quoted, and the workload, metric, hardware, OS and toolchain behind
  them, when the source states them.
- **Verdict.** *Holds up*, *holds up in part* (a narrower workload, a smaller gap, or old OS versions only), or
  *doesn't hold up* (newer data contradicts it, the baseline was misrepresented, or the "faster" option is slower).
- **Use it when, skip it when, how it is fast, what it costs.**
- **Problems with the evidence.** Debug builds, simulator runs, old OS versions, tiny samples, numbers that exist
  only in a chart image.
- **Evidence.** The quotes the numbers come from, each linked to its source.

### Evidence tiers

| Tier | Meaning |
|:-:|---|
| **A** | Public benchmark code that someone else can run, with the toolchain or flags and the hardware stated. |
| **B** | Independent of the library's authors: a third-party benchmark, a paper, or a talk with numbers. |
| **C** | First-party numbers without enough detail to reproduce. Includes Apple's own claims about Apple's frameworks. |
| **D** | Directional: no numbers in text, or numbers only in a chart image. |

The tier grades the evidence, not the library. A tier D entry can be the right choice; it just hasn't been measured
in a way you can check.

## How it's built

Each entry is a JSON record in [`data/entries/`](data/entries). The Swift package in [`tools/`](tools) does the
rest:

```sh
swift run --package-path tools catalog check    # every record against the schema
swift run --package-path tools catalog verify   # fetch every source and find every quote on it
swift run --package-path tools catalog render   # write catalog/, the exports, and this README's tables
```

`verify` fetches each evidence URL again (GitHub files from their raw source) and checks that every quote is on the
page, ignoring case and whitespace. A quote that has been paraphrased, or that a page has since dropped, fails the
check. The numbers in an entry's claimed result come from those quotes. Anything computed from them, such as a ratio,
is marked "derived from page data".

## Contributing

Corrections are the most useful contribution: a newer benchmark that changes a verdict, a default that caught up, or
a number that's wrong. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT. The catalog quotes published benchmarks for commentary. Each quote links to its source.
