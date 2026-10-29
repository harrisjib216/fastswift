# swift-json-schema (generated SwiftJSON ObjectView decoding)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md) › [JSON](README.md)</sub>

**Tier C** (first-party numbers) · 🟡 Holds up in part · No open-source license · `Swift` · 🟢 active

> Build plugin that generates structs plus zero-copy JSON initializers; 1.5-2x faster than JSONDecoder on small inputs, slower on large ones.

| | |
|---|---|
| **Beats** | Foundation JSONDecoder after the swift-foundation rewrite (Apple M4 Max) |
| **Claimed result** | p50: small 2,083 ns vs 4,335 ns (2.1x faster), medium 6,335 ns vs 9,423 ns (1.5x faster), large 560 µs vs 408 µs (1.4x slower) (ratios derived from page data); allocations 3 vs 15 (small) |
| **Workload** | Decoding a 4-field object, a 10-field object with nesting, and 100 nested objects into generated Swift structs via typed accessors on a JSONObjectView over Span<UInt8> |
| **Metric** | time (p50 wall clock) and allocations |
| **Hardware** | Apple M4 Max |
| **Measured** | 2026-06-10 |
| **Adoption** | 20 stars |
| **Last commit** | 2026-07-19 |
| **Install** | Swift Package Manager (build tool plugin) |
| **Links** | [repository](https://github.com/wendylabsinc/swift-json-schema) · [benchmark](https://forums.swift.org/t/swift-json-schema-an-efficient-codable-alternative/87268) |

## Verdict

Its generated non-Codable path beats Foundation on small (2,083 ns vs 4,335 ns) and medium (6,335 ns vs 9,423 ns) payloads. On the large payload its own table shows 560 µs against Foundation's 408 µs, so the post's statement that it matches Foundation there is not supported.

**Why tier C:** First-party forum post with the hardware stated, but no OS, Swift version or benchmark source location.

## Use it when

- Small and medium payloads described by a JSON Schema, on hot request paths
- Allocation-sensitive server code

## Skip it when

- Large documents: 560 µs vs Foundation's 408 µs in the author's table
- No JSON Schema for your payloads

## How it is fast

A SwiftPM build plugin generates Swift types from .schema.json files, plus initializers that read each field straight from an IkigaJSON index over a Span<UInt8> with typed per-key accessors. That skips the Decoder protocol, CodingKey matching and Any boxing, and cuts allocations to a few per document.

## What it costs

- Requires JSON Schema files and a build plugin
- Fast path depends on IkigaJSON

## Problems with the evidence

- First-party; no OS, Swift version or benchmark code location given in the post.
- No license detected on the repository: study only.
- The post's prose says the large-payload case matches Foundation's throughput; its table shows it about 37% slower.

## Evidence

<details>
<summary>7 quotes from the sources, checked 2026-10-28</summary>

> Benchmarked on Apple M4-Max (p50 wall-clock, using the
>
> — [forums.swift.org/t/swift-json-schema-an-efficient-codable-alternati…](https://forums.swift.org/t/swift-json-schema-an-efficient-codable-alternative/87268)

> 4,335 ns · 15 allocs
>
> — [forums.swift.org/t/swift-json-schema-an-efficient-codable-alternati…](https://forums.swift.org/t/swift-json-schema-an-efficient-codable-alternative/87268)

> 2,083 ns · 3 allocs
>
> — [forums.swift.org/t/swift-json-schema-an-efficient-codable-alternati…](https://forums.swift.org/t/swift-json-schema-an-efficient-codable-alternative/87268)

> 9,423 ns · 33 allocs
>
> — [forums.swift.org/t/swift-json-schema-an-efficient-codable-alternati…](https://forums.swift.org/t/swift-json-schema-an-efficient-codable-alternative/87268)

> 6,335 ns · 9 allocs
>
> — [forums.swift.org/t/swift-json-schema-an-efficient-codable-alternati…](https://forums.swift.org/t/swift-json-schema-an-efficient-codable-alternative/87268)

> 408 µs · 1,752 allocs
>
> — [forums.swift.org/t/swift-json-schema-an-efficient-codable-alternati…](https://forums.swift.org/t/swift-json-schema-an-efficient-codable-alternative/87268)

> 560 µs · 913 allocs
>
> — [forums.swift.org/t/swift-json-schema-an-efficient-codable-alternati…](https://forums.swift.org/t/swift-json-schema-an-efficient-codable-alternative/87268)

</details>
