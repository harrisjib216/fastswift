# Database drivers

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Server and networking](../README.md)</sub>

**The default:** Fluent and the common Swift drivers.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**PostgresKit / PostgresNIO raw SQL (in Vapor)**](vapor-postgres-kit.md) | Raw parameterized SQL through PostgresKit in Vapor, measured at about 1.8-2.2x Fluent's throughput in TechEmpower Rounds 20 and 22. | A | ✅ Holds up |
| [**SQLKit query builder (in Vapor, on PostgresKit)**](vapor-sql-kit.md) | SQLKit's typed SQL builder in Vapor, measured at about 1.6-2.1x Fluent's throughput in TechEmpower Rounds 20 and 22. | A | ✅ Holds up |
