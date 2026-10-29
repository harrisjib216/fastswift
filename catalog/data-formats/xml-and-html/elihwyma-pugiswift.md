# PugiSwift

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md) › [XML and HTML](README.md)</sub>

**Tier C** (first-party numbers) · 🟡 Holds up in part · Open source · `Swift + C++` · `Apache-2.0` · 🟡 stale

> Swift macros over the pugixml C++ parser; 14x XMLCoder and 3.7x Fuzi on a 212 KB file in its author's test.

| | |
|---|---|
| **Beats** | XMLCoder (Codable over Foundation XMLParser) and Fuzi (libxml2) |
| **Claimed result** | 757 parses/s vs 207 (Fuzi) and 54 (XMLCoder) on a 212kb file: 3.7x Fuzi and 14x XMLCoder (ratios derived from page data) |
| **Workload** | Parsing a 212 KB XML file of <record> elements (11 string and integer fields each) into Swift structs, counting completed parses in one second |
| **Metric** | throughput (parses per second) |
| **Toolchain** | Release mode, debugger off; Swift version not stated |
| **Measured** | 2024-10-31 |
| **Adoption** | 14 stars |
| **Last commit** | 2025-09-20 |
| **Platforms** | Apple platforms and Linux (server use with Vapor per README) |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/elihwyma/PugiSwift) · [benchmark](https://github.com/elihwyma/PugiSwift/blob/main/README.md) |

## Verdict

It parsed a 212 KB file 14x as often as XMLCoder and 3.7x as often as Fuzi in one test. Plain Foundation XMLParser with a delegate was not measured, so the gap to the actual default is unknown, and the method (one one-second loop per parser) is thin.

**Why tier C:** Benchmark code is public (PugiSwiftComparisons) and run in release mode, but hardware, OS and Swift version are not stated and each parser runs one one-second loop.

## Use it when

- Decoding large or frequent XML documents into fixed Swift structs
- Server-side XML ingestion where XMLCoder shows up in profiles

## Skip it when

- You need XPath or CSS queries over arbitrary documents (Fuzi, Kanna)
- Streaming very large files: pugixml builds a full DOM in memory

## How it is fast

pugixml parses the document in place into a compact DOM with few allocations, and Swift macros (@Node, @Attribute, @Element) generate the code that maps nodes to struct fields. XMLCoder instead drives Foundation's XMLParser callbacks into an intermediate tree and runs Codable over it.

## What it costs

- C++ interop in the build
- Macro-generated mapping is less flexible than query-based access

## Problems with the evidence

- One one-second loop per parser, no warm-up or repeated trials.
- Hardware, OS and Swift version not stated.
- Foundation XMLParser used directly (SAX delegate, no Codable) was not measured.
- Small project: 14 stars, bundles pugixml 1.14.

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> The test was in Release mode with the debugger turned off. Comparisons were made against [Fuzi](https://github.com/cezheng/Fuzi.git) and [XMLCoder](https://github.com/CoreOffice/XMLCoder.git).
>
> — [github.com/elihwyma/PugiSwift/blob/main/README.md](https://github.com/elihwyma/PugiSwift/blob/main/README.md)

> title "Parses per second of 212kb file"
>
> — [github.com/elihwyma/PugiSwift/blob/main/README.md](https://github.com/elihwyma/PugiSwift/blob/main/README.md)

> x-axis "Programs" ["PugiSwift", "Fuzi", "XMLCoder"]
>
> — [github.com/elihwyma/PugiSwift/blob/main/README.md](https://github.com/elihwyma/PugiSwift/blob/main/README.md)

> bar [757, 207, 54]
>
> — [github.com/elihwyma/PugiSwift/blob/main/README.md](https://github.com/elihwyma/PugiSwift/blob/main/README.md)

</details>
