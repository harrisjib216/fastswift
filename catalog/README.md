# Catalog

<sub>[fastswift](../README.md)</sub>

Every entry, grouped by domain and category. Within a category, entries that hold up come first, then partial ones, then rejected claims, each ordered by the strength of their evidence.

## [Data formats](data-formats/README.md)

- **[JSON](data-formats/json/README.md)**: [Foundation JSONDecoder / JSONEncoder (swift-foundation rewrite)](data-formats/json/apple-foundation-jsondecoder.md), [swift-foundation NewCodable (JSONDecodable + JSONParserDecoder, experimental)](data-formats/json/swiftlang-swift-foundation-new-codable.md), [ReerJSON](data-formats/json/reers-reerjson.md), [swift-extras-json (ExtrasJSON, formerly pure-swift-json)](data-formats/json/swift-extras-swift-extras-json.md), [swift-yyjson (YYJSON)](data-formats/json/mattt-swift-yyjson.md), [FastCoders (JSONDecoderEncoderBenchmarks)](data-formats/json/chrisbenua-jsondecoderencoderbenchmarks.md), [swift-json-schema (generated SwiftJSON ObjectView decoding)](data-formats/json/wendylabsinc-swift-json-schema.md), [ZippyJSON](data-formats/json/michaeleisel-zippyjson.md), [IkigaJSON (orlandos-nl/swift-json)](data-formats/json/orlandos-nl-swift-json.md)
- **[Binary serialization](data-formats/binary-serialization/README.md)**: [Apache Fory (Swift)](data-formats/binary-serialization/apache-fory-swift.md), [SwiftProtobuf (binary wire format)](data-formats/binary-serialization/apple-swift-protobuf.md)
- **[XML and HTML](data-formats/xml-and-html/README.md)**: [PugiSwift](data-formats/xml-and-html/elihwyma-pugiswift.md)
- **[Base64 and encoding](data-formats/base64-and-encoding/README.md)**: [Foundation Base64 (swift-foundation 2025 rewrite)](data-formats/base64-and-encoding/apple-foundation-base64.md), [swift-extras-base64](data-formats/base64-and-encoding/swift-extras-swift-extras-base64.md)
- **[Markdown](data-formats/markdown/README.md)**: [Down](data-formats/markdown/johnxnguyen-down.md)

## [Collections](collections/README.md)

- **[Deques and queues](collections/deques-and-queues/README.md)**: [swift-collections (Deque)](collections/deques-and-queues/apple-swift-collections-deque.md)
- **[Ordered and sorted collections](collections/ordered-and-sorted/README.md)**: [swift-collections (OrderedSet)](collections/ordered-and-sorted/apple-swift-collections-orderedset.md), [BTree (attaswift)](collections/ordered-and-sorted/attaswift-btree.md)
- **[Persistent and tree collections](collections/persistent-and-tree/README.md)**: [swift-collections (TreeSet, TreeDictionary)](collections/persistent-and-tree/apple-swift-collections-treeset.md)
- **[Heaps and bit sets](collections/heaps-and-bitsets/README.md)**: [SwiftBitset](collections/heaps-and-bitsets/lemire-swiftbitset.md), [swift-collections (Heap)](collections/heaps-and-bitsets/apple-swift-collections-heap.md)
- **[Diffing](collections/diffing/README.md)**: [IGListKit (IGListDiff)](collections/diffing/instagram-iglistkit.md), [DifferenceKit](collections/diffing/ra1028-differencekit.md), [DeepDiff](collections/diffing/onmyway133-deepdiff.md), [Differ](collections/diffing/tonyarnold-differ.md), [Dwifft](collections/diffing/jflinter-dwifft.md)
- **[Sorting and searching](collections/sorting-and-searching/README.md)**: [swift-algorithms (min(count:), max(count:))](collections/sorting-and-searching/apple-swift-algorithms-min-count.md)

## [Concurrency and runtime](concurrency-and-runtime/README.md)

- **[Locks and atomics](concurrency-and-runtime/locks-and-atomics/README.md)**: [os_unfair_lock (os framework)](concurrency-and-runtime/locks-and-atomics/apple-os-os-unfair-lock.md), [OSAllocatedUnfairLock (os framework)](concurrency-and-runtime/locks-and-atomics/apple-os-osallocatedunfairlock.md), [Synchronization.Mutex (Swift 6)](concurrency-and-runtime/locks-and-atomics/apple-synchronization-mutex.md)
- **[Reactive streams](concurrency-and-runtime/reactive-streams/README.md)**: [RxSwift](concurrency-and-runtime/reactive-streams/reactivex-rxswift.md)
- **[Logging](concurrency-and-runtime/logging/README.md)**: [Chronicle](concurrency-and-runtime/logging/saagarjha-chronicle.md), [CocoaLumberjack](concurrency-and-runtime/logging/cocoalumberjack-cocoalumberjack.md)

## [Crypto and hashing](crypto-and-hashing/README.md)

- **[Cryptographic hashes and ciphers](crypto-and-hashing/crypto-hashes-and-ciphers/README.md)**: [CryptoSwift](crypto-and-hashing/crypto-hashes-and-ciphers/krzyzanowskim-cryptoswift.md)
- **[Non-cryptographic hashes](crypto-and-hashing/non-crypto-hashes/README.md)**: [SwiftXXHash (xxHash XXH3/XXH64)](crypto-and-hashing/non-crypto-hashes/jaesung-jung-swiftxxhash.md)
- **[Random numbers](crypto-and-hashing/random-numbers/README.md)**: [CwlUtils (Xoshiro)](crypto-and-hashing/random-numbers/mattgallagher-cwlutils-xoshiro.md), [SwiftWyhash (WyRand)](crypto-and-hashing/random-numbers/lemire-swiftwyhash.md)

## [Compression](compression/README.md)

- **[General-purpose compression](compression/general-compression/README.md)**: [Compression framework (LZFSE)](compression/general-compression/apple-compression-lzfse.md), [SwiftZSTD (zstd)](compression/general-compression/aperedera-swiftzstd.md), [Compression framework (LZ4)](compression/general-compression/apple-compression-lz4.md), [Compression framework (LZMESH)](compression/general-compression/apple-compression-lzmesh.md), [Compression framework (LZRAVEN)](compression/general-compression/apple-compression-lzraven.md), [SWCompression](compression/general-compression/tsolomko-swcompression.md)
- **[ZIP archives](compression/archives/README.md)**: [ZIPFoundation](compression/archives/weichsel-zipfoundation.md)

## [Storage](storage/README.md)

- **[SQLite and object stores](storage/sqlite-and-orms/README.md)**: [GRDB.swift (records against Core Data)](storage/sqlite-and-orms/groue-grdb-swift.md), [Realm Swift](storage/sqlite-and-orms/realm-realm-swift.md), [Lighter (Enlighter-generated SQLite bindings)](storage/sqlite-and-orms/lighter-swift-lighter.md), [SQLiteData (StructuredQueries decoding over GRDB)](storage/sqlite-and-orms/pointfreeco-sqlite-data.md), [Core Data (used directly instead of SwiftData)](storage/sqlite-and-orms/apple-coredata-nsmanagedobjectcontext.md)
- **[Caches and key-value stores](storage/caches-and-key-value/README.md)**: [Bodega (SQLiteStorageEngine)](storage/caches-and-key-value/mergesort-bodega.md), [MMKV](storage/caches-and-key-value/tencent-mmkv.md), [YYCache (YYMemoryCache, YYDiskCache)](storage/caches-and-key-value/ibireme-yycache.md)

## [Images and media](images-and-media/README.md)

- **[Image loading](images-and-media/image-loading/README.md)**: [Fast Image Cache](images-and-media/image-loading/path-fastimagecache.md)
- **[Image codecs](images-and-media/image-codecs/README.md)**: [MetalBlurHash](images-and-media/image-codecs/lukilabs-metalblurhash.md), [libjpeg-turbo (on iOS)](images-and-media/image-codecs/libjpeg-turbo-libjpeg-turbo.md)
- **[Resizing and processing](images-and-media/resizing-and-processing/README.md)**: [Image I/O (CGImageSourceCreateThumbnailAtIndex)](images-and-media/resizing-and-processing/apple-imageio-cgimagesourcecreatethumbnailatindex.md), [GPUImage (OpenGL ES)](images-and-media/resizing-and-processing/bradlarson-gpuimage.md), [Core Image (CILanczosScaleTransform)](images-and-media/resizing-and-processing/apple-coreimage-cilanczosscaletransform.md), [vImage (vImageScale_ARGB8888)](images-and-media/resizing-and-processing/apple-accelerate-vimagescale.md)
- **[Animated images](images-and-media/animated-images/README.md)**: [FLAnimatedImage](images-and-media/animated-images/flipboard-flanimatedimage.md)

## [UI and rendering](ui-and-rendering/README.md)

- **[Layout](ui-and-rendering/layout/README.md)**: [Auto Layout (iOS 12 engine)](ui-and-rendering/layout/apple-uikit-auto-layout.md), [LayoutKit](ui-and-rendering/layout/linkedinattic-layoutkit.md), [Texture (ASDisplayNode, ASCollectionNode)](ui-and-rendering/layout/texturegroup-texture.md), [FlexLayout (Yoga flexbox)](ui-and-rendering/layout/layoutbox-flexlayout.md), [PinLayout](ui-and-rendering/layout/layoutbox-pinlayout.md)
- **[Lists and scrolling](ui-and-rendering/lists-and-scrolling/README.md)**: [SwiftUI List (macOS 26)](ui-and-rendering/lists-and-scrolling/apple-swiftui-list.md), [SwiftUI List (vs ScrollView + LazyVStack)](ui-and-rendering/lists-and-scrolling/apple-swiftui-list-vs-lazyvstack.md)
- **[Text rendering](ui-and-rendering/text-rendering/README.md)**: [TextKit 2 (NSTextLayoutManager)](ui-and-rendering/text-rendering/apple-uikit-textkit-2.md)
- **[Animation and vector graphics](ui-and-rendering/animation-and-vector/README.md)**: [lottie-ios (Core Animation rendering engine)](ui-and-rendering/animation-and-vector/airbnb-lottie-ios-core-animation-engine.md), [Rive (rive-ios, vs Lottie)](ui-and-rendering/animation-and-vector/rive-app-rive-ios.md)

## [Text processing](text-processing/README.md)

- **[Regular expressions](text-processing/regex/README.md)**: [NSRegularExpression (vs Swift Regex)](text-processing/regex/apple-foundation-nsregularexpression.md)
- **[Parsing and strings](text-processing/parsing-and-strings/README.md)**: [swift-parsing (UTF8View parsers vs Scanner)](text-processing/parsing-and-strings/pointfreeco-swift-parsing.md)
- **[Dates and numbers](text-processing/dates-and-numbers/README.md)**: [Date.FormatStyle (Swift Foundation, macOS 14 / iOS 17)](text-processing/dates-and-numbers/apple-foundation-date-formatstyle.md), [Parse3339](text-processing/dates-and-numbers/juri-parse3339.md), [swift-parsing (RFC 3339 date parser benchmark)](text-processing/dates-and-numbers/pointfreeco-swift-parsing-date-parser.md), [Date.ISO8601FormatStyle (Swift Foundation, ICU-free)](text-processing/dates-and-numbers/apple-foundation-iso8601formatstyle.md)

## [Server and networking](server-and-networking/README.md)

- **[Web frameworks](server-and-networking/web-frameworks/README.md)**: [Hummingbird 1.x (HTTP server framework)](server-and-networking/web-frameworks/hummingbird-project-hummingbird-v1.md), [SwiftNIO (hand-written NIOHTTP1 server)](server-and-networking/web-frameworks/apple-swift-nio.md), [Hummingbird 2 (HTTP server framework)](server-and-networking/web-frameworks/hummingbird-project-hummingbird-v2.md), [Kitura (web framework)](server-and-networking/web-frameworks/kitura-kitura.md)
- **[Database drivers](server-and-networking/database-drivers/README.md)**: [PostgresKit / PostgresNIO raw SQL (in Vapor)](server-and-networking/database-drivers/vapor-postgres-kit.md), [SQLKit query builder (in Vapor, on PostgresKit)](server-and-networking/database-drivers/vapor-sql-kit.md)

## [ML and numerics](ml-and-numerics/README.md)

- **[On-device inference](ml-and-numerics/on-device-inference/README.md)**: [Core ML stateful models (KV cache as model state)](ml-and-numerics/on-device-inference/apple-coreml-stateful-models.md), [ane_transformers (Neural Engine Transformer reference)](ml-and-numerics/on-device-inference/apple-aiml-research-ml-ane-transformers.md), [Core AI (LLM runtime, Core ML successor)](ml-and-numerics/on-device-inference/apple-coreai-llm.md), [llama.cpp (Metal backend on Apple silicon)](ml-and-numerics/on-device-inference/ggml-org-llama-cpp.md), [MLX Swift (LLM decoding on the Apple silicon GPU)](ml-and-numerics/on-device-inference/ml-explore-mlx-swift.md), [ml-stable-diffusion (Core ML Stable Diffusion, SPLIT_EINSUM_V2 attention)](ml-and-numerics/on-device-inference/apple-aiml-research-ml-stable-diffusion.md), [WhisperKit (argmax-oss-swift)](ml-and-numerics/on-device-inference/argmaxinc-argmax-oss-swift.md)
- **[Linear algebra and DSP](ml-and-numerics/linear-algebra-and-dsp/README.md)**: [Accelerate (BLAS and LAPACK)](ml-and-numerics/linear-algebra-and-dsp/apple-accelerate-blas.md), [Matft](ml-and-numerics/linear-algebra-and-dsp/jjjkkkjjj-matft.md), [LASwift](ml-and-numerics/linear-algebra-and-dsp/alexandertar-laswift.md), [Accelerate (vDSP and vForce element-wise math)](ml-and-numerics/linear-algebra-and-dsp/apple-accelerate-vdsp.md), [Surge](ml-and-numerics/linear-algebra-and-dsp/jounce-surge.md)

## [Build and tooling](tooling/README.md)

- **[Build systems and caching](tooling/build-and-caching/README.md)**: [Tuist (module cache)](tooling/build-and-caching/tuist-tuist.md), [Xcode compilation cache (COMPILATION_CACHE_ENABLE_CACHING, Xcode 26)](tooling/build-and-caching/apple-xcode-compilation-cache.md), [SwiftPM prebuilt swift-syntax for macros](tooling/build-and-caching/swiftlang-swift-package-manager-swift-syntax-prebuilts.md), [Bazel (with rules_swift, rules_apple and rules_xcodeproj)](tooling/build-and-caching/bazelbuild-bazel.md), [Explicitly built modules (Xcode 16+)](tooling/build-and-caching/apple-xcode-explicitly-built-modules.md), [XCRemoteCache](tooling/build-and-caching/spotify-xcremotecache.md)
- **[Linkers](tooling/linkers/README.md)**: [ld-prime (Xcode 15+ linker)](tooling/linkers/apple-xcode-ld-prime.md), [lld (Mach-O port, ld64.lld)](tooling/linkers/llvm-llvm-project-lld-macho.md), [zld](tooling/linkers/michaeleisel-zld.md)
- **[Developer tools](tooling/developer-tools/README.md)**: [SwiftLint (SwiftSyntax-based rules)](tooling/developer-tools/realm-swiftlint.md), [xcodes (aria2 downloads)](tooling/developer-tools/xcodesorg-xcodes.md), [SwiftFormat](tooling/developer-tools/nicklockwood-swiftformat.md), [unxip](tooling/developer-tools/saagarjha-unxip.md), [xcbeautify](tooling/developer-tools/cpisciotta-xcbeautify.md)
