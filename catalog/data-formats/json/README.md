# JSON

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md)</sub>

**The default:** Foundation's JSONDecoder, JSONEncoder and JSONSerialization.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Foundation JSONDecoder / JSONEncoder (swift-foundation rewrite)**](apple-foundation-jsondecoder.md) | Apple's 2023 Swift rewrite of JSONDecoder/JSONEncoder; 2x-5x faster decoding than the NSJSONSerialization-based version it replaced. | C | ✅ Holds up |
| [**swift-foundation NewCodable (JSONDecodable + JSONParserDecoder, experimental)**](swiftlang-swift-foundation-new-codable.md) | Apple's prototype successor to Codable for JSON; about 6x JSONDecoder's throughput on twitter.json, on an experimental branch. | C | ✅ Holds up |
| [**ReerJSON**](reers-reerjson.md) | yyjson-backed drop-in JSONDecoder/JSONEncoder; its charts show it ahead of Foundation on iOS 26, but the numbers are only in images. | D | ✅ Holds up |
| [**swift-extras-json (ExtrasJSON, formerly pure-swift-json)**](swift-extras-swift-extras-json.md) | Foundation-free JSON coder that beat Swift 5.1/5.2 Foundation by 1.5-10x; its parsing approach later went into Foundation itself. | A | 🟡 Holds up in part |
| [**swift-yyjson (YYJSON)**](mattt-swift-yyjson.md) | yyjson wrapper with JSONSerialization/JSONDecoder-style APIs; parses 9-15x faster than JSONSerialization, Codable path unmeasured. | A | 🟡 Holds up in part |
| [**FastCoders (JSONDecoderEncoderBenchmarks)**](chrisbenua-jsondecoderencoderbenchmarks.md) | Patched JSONDecoder/JSONEncoder that skips slow conformance checks; 2x faster in a huge app, now largely merged into swift-foundation. | C | 🟡 Holds up in part |
| [**swift-json-schema (generated SwiftJSON ObjectView decoding)**](wendylabsinc-swift-json-schema.md) | Build plugin that generates structs plus zero-copy JSON initializers; 1.5-2x faster than JSONDecoder on small inputs, slower on large ones. | C | 🟡 Holds up in part |
| [**ZippyJSON**](michaeleisel-zippyjson.md) | Drop-in JSONDecoder built on simdjson; 3-4x faster than the pre-iOS 17 decoder, and slower than iOS 17+'s by its own README. | C | 🟡 Holds up in part |
| [**IkigaJSON (orlandos-nl/swift-json)**](orlandos-nl-swift-json.md) | SwiftNIO-friendly Codable JSON coder; its own 2026 benchmark puts it level with or behind modern Foundation, with fewer decode allocations. | A | ❌ Doesn't hold up |
