# Server and networking

<sub>[fastswift](../../README.md) › [Catalog](../README.md)</sub>

## [Web frameworks](web-frameworks/README.md)

**The default:** Vapor.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Hummingbird 1.x (HTTP server framework)**](web-frameworks/hummingbird-project-hummingbird-v1.md) | Hummingbird 1.x, a SwiftNIO web framework that served about twice Vapor's plaintext and JSON throughput in TechEmpower Round 23. | A | 🟡 Holds up in part |
| [**SwiftNIO (hand-written NIOHTTP1 server)**](web-frameworks/apple-swift-nio.md) | SwiftNIO used directly as a bare HTTP/1.1 server, measured at 4-11x Vapor's throughput on TechEmpower's trivial endpoints. | A | 🟡 Holds up in part |
| [**Hummingbird 2 (HTTP server framework)**](web-frameworks/hummingbird-project-hummingbird-v2.md) | Hummingbird 2, the async/await rewrite, which TechEmpower Round 23 measured as slower than Vapor on plaintext and JSON. | A | ❌ Doesn't hold up |
| [**Kitura (web framework)**](web-frameworks/kitura-kitura.md) | Kitura, the IBM-started Swift web framework; TechEmpower Round 19 measured it at a third to half of Vapor's HTTP throughput. | A | ❌ Doesn't hold up |

## [Database drivers](database-drivers/README.md)

**The default:** Fluent and the common Swift drivers.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**PostgresKit / PostgresNIO raw SQL (in Vapor)**](database-drivers/vapor-postgres-kit.md) | Raw parameterized SQL through PostgresKit in Vapor, measured at about 1.8-2.2x Fluent's throughput in TechEmpower Rounds 20 and 22. | A | ✅ Holds up |
| [**SQLKit query builder (in Vapor, on PostgresKit)**](database-drivers/vapor-sql-kit.md) | SQLKit's typed SQL builder in Vapor, measured at about 1.6-2.1x Fluent's throughput in TechEmpower Rounds 20 and 22. | A | ✅ Holds up |
