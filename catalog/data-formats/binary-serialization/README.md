# Binary serialization

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md)</sub>

**The default:** Codable with JSONEncoder or PropertyListEncoder as the wire or disk format.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Apache Fory (Swift)**](apache-fory-swift.md) | Macro-generated cross-language binary serializer; 11-59x the throughput of Codable JSON and up to 5.6x SwiftProtobuf in its own benchmark. | A | ✅ Holds up |
| [**SwiftProtobuf (binary wire format)**](apple-swift-protobuf.md) | Apple's Protocol Buffers runtime for Swift; 5-19x the throughput of Codable JSON in a third-party benchmark, at about half the bytes. | A | ✅ Holds up |
