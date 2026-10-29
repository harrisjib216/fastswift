# Data formats

<sub>[fastswift](../../README.md) › [Catalog](../README.md)</sub>

## [JSON](json/README.md)

**The default:** Foundation's JSONDecoder, JSONEncoder and JSONSerialization.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Foundation JSONDecoder / JSONEncoder (swift-foundation rewrite)**](json/apple-foundation-jsondecoder.md) | Apple's 2023 Swift rewrite of JSONDecoder/JSONEncoder; 2x-5x faster decoding than the NSJSONSerialization-based version it replaced. | C | ✅ Holds up |
| [**swift-foundation NewCodable (JSONDecodable + JSONParserDecoder, experimental)**](json/swiftlang-swift-foundation-new-codable.md) | Apple's prototype successor to Codable for JSON; about 6x JSONDecoder's throughput on twitter.json, on an experimental branch. | C | ✅ Holds up |
| [**ReerJSON**](json/reers-reerjson.md) | yyjson-backed drop-in JSONDecoder/JSONEncoder; its charts show it ahead of Foundation on iOS 26, but the numbers are only in images. | D | ✅ Holds up |
| [**swift-extras-json (ExtrasJSON, formerly pure-swift-json)**](json/swift-extras-swift-extras-json.md) | Foundation-free JSON coder that beat Swift 5.1/5.2 Foundation by 1.5-10x; its parsing approach later went into Foundation itself. | A | 🟡 Holds up in part |
| [**swift-yyjson (YYJSON)**](json/mattt-swift-yyjson.md) | yyjson wrapper with JSONSerialization/JSONDecoder-style APIs; parses 9-15x faster than JSONSerialization, Codable path unmeasured. | A | 🟡 Holds up in part |
| [**FastCoders (JSONDecoderEncoderBenchmarks)**](json/chrisbenua-jsondecoderencoderbenchmarks.md) | Patched JSONDecoder/JSONEncoder that skips slow conformance checks; 2x faster in a huge app, now largely merged into swift-foundation. | C | 🟡 Holds up in part |
| [**swift-json-schema (generated SwiftJSON ObjectView decoding)**](json/wendylabsinc-swift-json-schema.md) | Build plugin that generates structs plus zero-copy JSON initializers; 1.5-2x faster than JSONDecoder on small inputs, slower on large ones. | C | 🟡 Holds up in part |
| [**ZippyJSON**](json/michaeleisel-zippyjson.md) | Drop-in JSONDecoder built on simdjson; 3-4x faster than the pre-iOS 17 decoder, and slower than iOS 17+'s by its own README. | C | 🟡 Holds up in part |
| [**IkigaJSON (orlandos-nl/swift-json)**](json/orlandos-nl-swift-json.md) | SwiftNIO-friendly Codable JSON coder; its own 2026 benchmark puts it level with or behind modern Foundation, with fewer decode allocations. | A | ❌ Doesn't hold up |

## [Binary serialization](binary-serialization/README.md)

**The default:** Codable with JSONEncoder or PropertyListEncoder as the wire or disk format.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Apache Fory (Swift)**](binary-serialization/apache-fory-swift.md) | Macro-generated cross-language binary serializer; 11-59x the throughput of Codable JSON and up to 5.6x SwiftProtobuf in its own benchmark. | A | ✅ Holds up |
| [**SwiftProtobuf (binary wire format)**](binary-serialization/apple-swift-protobuf.md) | Apple's Protocol Buffers runtime for Swift; 5-19x the throughput of Codable JSON in a third-party benchmark, at about half the bytes. | A | ✅ Holds up |

## [XML and HTML](xml-and-html/README.md)

**The default:** Foundation's XMLParser, and SwiftSoup for HTML.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**PugiSwift**](xml-and-html/elihwyma-pugiswift.md) | Swift macros over the pugixml C++ parser; 14x XMLCoder and 3.7x Fuzi on a 212 KB file in its author's test. | C | 🟡 Holds up in part |

## [Base64 and encoding](base64-and-encoding/README.md)

**The default:** Foundation's base64EncodedString and Data(base64Encoded:).

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Foundation Base64 (swift-foundation 2025 rewrite)**](base64-and-encoding/apple-foundation-base64.md) | Foundation's own Base64, rewritten in Swift in 2025: 1 MB encodes and decodes 5-7.5x faster than the version it replaced. | C | ✅ Holds up |
| [**swift-extras-base64**](base64-and-encoding/swift-extras-swift-extras-base64.md) | Foundation-free Base64 that was 3-10x faster than 2020 Foundation; its author has since brought the approach into Foundation. | A | 🟡 Holds up in part |

## [Markdown](markdown/README.md)

**The default:** The common Markdown parsers and renderers.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Down**](markdown/johnxnguyen-down.md) | Swift wrapper over cmark 0.29; its speed figures are cmark versus Markdown.pl and show no gain over Swift's cmark-based defaults. | C | ❌ Doesn't hold up |
