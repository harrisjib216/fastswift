# swift-foundation NewCodable (JSONDecodable + JSONParserDecoder, experimental)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md) › [JSON](README.md)</sub>

**Tier C** (first-party numbers) · ✅ Holds up · Open source · `Swift` · `Apache-2.0` · 🟢 active

> Apple's prototype successor to Codable for JSON; about 6x JSONDecoder's throughput on twitter.json, on an experimental branch.

| | |
|---|---|
| **Beats** | Decodable + Foundation JSONDecoder (current swift-foundation) |
| **Claimed result** | approximately 6x decode throughput over Decodable + JSONDecoder on twitter.json |
| **Workload** | Decoding twitter.json into model types |
| **Metric** | throughput |
| **Toolchain** | Swift 6.3 required; swift test --configuration release --filter NewCodableBenchmarks |
| **Measured** | 2026-03-06 |
| **Adoption** | 2.7k stars |
| **Last commit** | 2026-10-28 |
| **Platforms** | Swift 6.3 toolchains (experimental branch) |
| **Install** | Swift Package Manager (branch experimental/new-codable, import NewCodable) |
| **Links** | [repository](https://github.com/swiftlang/swift-foundation) · [benchmark](https://forums.swift.org/t/new-codable-prototype-available-for-feedback/85186) |

## Verdict

Apple's Codable lead reports about 6x the decode throughput of Decodable + JSONDecoder on twitter.json, and the benchmarks are on the public branch. It is one file on an unreleased prototype, and nothing contradicts it.

**Why tier C:** First-party figure from one file with the branch's own benchmark target; no hardware or OS stated.

## Use it when

- Trying Codable's successor ahead of release and sending feedback
- Benchmarking your own models against JSONDecoder to see what the new design buys

## Skip it when

- Production code: the branch has TODOs, placeholder names and some failing tests
- Toolchains older than Swift 6.3

## How it is fast

Types conform to format-specific protocols (JSONDecodable) that a parser-driven decoder (JSONParserDecoder) calls directly, so values are decoded while the bytes are parsed, without an intermediate representation and without the existential containers of Decoder and KeyedDecodingContainer. The design follows Rust's serde and the musli crate.

## What it costs

- Requires adopting new protocols (JSONDecodable / CommonDecodable) instead of Codable
- Unreleased; may change

## Problems with the evidence

- One file (twitter.json), measured by the author ('I personally observe') on benchmark infrastructure the post calls bespoke.
- The author says it still falls somewhat short of simdjson and serde in throughput.
- API names (NewJSONDecoder and others) are placeholders; macros are planned but not designed yet.

## Evidence

<details>
<summary>3 quotes from the sources, checked 2026-10-28</summary>

> provide a throughput improvement of approximately 6x over
>
> — [forums.swift.org/t/new-codable-prototype-available-for-feedback/85186](https://forums.swift.org/t/new-codable-prototype-available-for-feedback/85186)

> Swift 6.3 is required.
>
> — [forums.swift.org/t/new-codable-prototype-available-for-feedback/85186](https://forums.swift.org/t/new-codable-prototype-available-for-feedback/85186)

> we still do currently fall somewhat short of simdjson and serde in terms of throughput.
>
> — [forums.swift.org/t/new-codable-prototype-available-for-feedback/85186](https://forums.swift.org/t/new-codable-prototype-available-for-feedback/85186)

</details>
