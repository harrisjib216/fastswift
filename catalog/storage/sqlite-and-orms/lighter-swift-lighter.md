# Lighter (Enlighter-generated SQLite bindings)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Storage](../README.md) › [SQLite and object stores](README.md)</sub>

**Tier B** (independent measurement) · 🟡 Holds up in part · Open source · `Swift` · `MIT` · 🟢 active

> Code generator that binds SQLite statements directly to Swift structs; 6.6x faster than GRDB with Codable in an independent rerun.

| | |
|---|---|
| **Beats** | GRDB and SQLite.swift decoding rows through Codable |
| **Claimed result** | Lighter's run: Lighter 7,927s vs SQLite.swift with Codable 153,172s ('>19× slower'), GRDB with Codable 49,404s ('>6× slower'), SQLite.swift with hand-written mapping 30,643s ('>3× slower'). Point-Free's rerun: Lighter 8.059 vs GRDB 7.4.1 Codable 53.326 (6.6x, derived from page data), SQLite.swift 0.15.3 Codable 43.261 (5.4x, derived from page data), GRDB manual decoding 18.819 (2.3x, derived from page data). |
| **Workload** | Load all ~16,000 rows of the Orders table of the populated Northwind SQLite database (24 MB) into Swift model values; 10 warm-up and 500 timed iterations, total duration reported. |
| **Metric** | time |
| **Hardware** | Apple M1 Mac mini (Lighter's run); not stated for Point-Free's rerun |
| **Measured** | 2022-08 |
| **Adoption** | 517 stars |
| **Last commit** | 2026-01-30 |
| **Platforms** | iOS 13+, macOS 10.15+ |
| **Install** | Swift Package Manager (with a build plugin) |
| **Links** | [repository](https://github.com/Lighter-swift/Lighter) · [benchmark](https://github.com/Lighter-swift/PerformanceTestSuite) |

## Verdict

Point-Free's 2025 rerun of Lighter's suite still has Lighter about 6.6x faster than GRDB with Codable and 2.3x faster than GRDB with hand-written mapping. But the '>19x slower' figure for SQLite.swift with Codable shrank to about 5.4x with SQLite.swift 0.15.3, and nobody has published a comparison with Core Data or SwiftData.

**Why tier B:** The lead holds in an independent rerun of the public suite published by Point-Free; Lighter's own run states the hardware (M1 Mini) but no toolchain or build configuration.

## Use it when

- Shipping a read-mostly SQLite database in the app bundle (catalogues, reference data) whose schema is fixed at build time
- Bulk-loading thousands of rows into value types on a hot path
- Code that currently decodes rows with Codable in GRDB or SQLite.swift

## Skip it when

- You need an object graph, change tracking, observation or sync out of the box
- The schema is created or changed at runtime
- You already map GRDB rows by hand: the gap there is 2.3x, not 6x

## How it is fast

Enlighter reads the SQLite schema at build time and generates Swift structs plus code that binds and reads each column by index, so no reflection, Codable containers or column-name lookups run per row. The Codable path in GRDB and SQLite.swift builds keyed containers and does string-keyed lookups for every field of every row, which is where most of their time goes in this test. Raw Enlighter output that skips the Lighter API is about 20% faster still.

## What it costs

- Adds a code generation step to the build
- Lower-level than an ORM: no faulting, relationship management or change tracking
- Small project with a single maintainer

## Problems with the evidence

- The suite says it 'doesn't have the goal to be scientifically proper'; one table and one query shape (full table scan)
- Lighter's own run used GRDB 5.26.0 and SQLite.swift 0.13.3 (2022); its GRDB hand-written row is only '~12s' with no setup or warm-up figures
- Neither run states the Swift toolchain or build configuration
- The README chart says 'Products' table while the text and data describe the Orders table
- A Core Data comparison is an open TODO in the suite

## Evidence

<details>
<summary>10 quotes from the sources, checked 2026-10-28</summary>

> M1 Mini with 10 rampup iterations and 500 test iterations.
>
> — [github.com/Lighter-swift/PerformanceTestSuite/blob/main/README.md](https://github.com/Lighter-swift/PerformanceTestSuite/blob/main/README.md)

> Lighter 0 0,162s 7,927s Baseline (63/s)
>
> — [github.com/Lighter-swift/PerformanceTestSuite/blob/main/README.md](https://github.com/Lighter-swift/PerformanceTestSuite/blob/main/README.md)

> SQLite.swift 0 0,613s 30,643s Handwritten Mapping (>3× slower) (16/s)
>
> — [github.com/Lighter-swift/PerformanceTestSuite/blob/main/README.md](https://github.com/Lighter-swift/PerformanceTestSuite/blob/main/README.md)

> GRDB 0,001 0,995s 49,404s Codable (>6× slower) (10/s)
>
> — [github.com/Lighter-swift/PerformanceTestSuite/blob/main/README.md](https://github.com/Lighter-swift/PerformanceTestSuite/blob/main/README.md)

> SQLite.swift 0,001 3,109s 153,172s Codable (>19× slower) (3/s)
>
> — [github.com/Lighter-swift/PerformanceTestSuite/blob/main/README.md](https://github.com/Lighter-swift/PerformanceTestSuite/blob/main/README.md)

> It doesn't have the goal to be scientifically proper.
>
> — [github.com/Lighter-swift/PerformanceTestSuite/blob/main/README.md](https://github.com/Lighter-swift/PerformanceTestSuite/blob/main/README.md)

> Lighter (1.4.10) 0 0.164 8.059
>
> — [github.com/pointfreeco/sqlite-data/blob/main/README.md](https://github.com/pointfreeco/sqlite-data/blob/main/README.md)

> GRDB (7.4.1, manual decoding) 0 0.376 18.819
>
> — [github.com/pointfreeco/sqlite-data/blob/main/README.md](https://github.com/pointfreeco/sqlite-data/blob/main/README.md)

> SQLite.swift (0.15.3, Codable) 0 0.863 43.261
>
> — [github.com/pointfreeco/sqlite-data/blob/main/README.md](https://github.com/pointfreeco/sqlite-data/blob/main/README.md)

> GRDB (7.4.1, Codable) 0.002 1.07 53.326
>
> — [github.com/pointfreeco/sqlite-data/blob/main/README.md](https://github.com/pointfreeco/sqlite-data/blob/main/README.md)

</details>
