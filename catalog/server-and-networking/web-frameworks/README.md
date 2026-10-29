# Web frameworks

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Server and networking](../README.md)</sub>

**The default:** Vapor.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Hummingbird 1.x (HTTP server framework)**](hummingbird-project-hummingbird-v1.md) | Hummingbird 1.x, a SwiftNIO web framework that served about twice Vapor's plaintext and JSON throughput in TechEmpower Round 23. | A | 🟡 Holds up in part |
| [**SwiftNIO (hand-written NIOHTTP1 server)**](apple-swift-nio.md) | SwiftNIO used directly as a bare HTTP/1.1 server, measured at 4-11x Vapor's throughput on TechEmpower's trivial endpoints. | A | 🟡 Holds up in part |
| [**Hummingbird 2 (HTTP server framework)**](hummingbird-project-hummingbird-v2.md) | Hummingbird 2, the async/await rewrite, which TechEmpower Round 23 measured as slower than Vapor on plaintext and JSON. | A | ❌ Doesn't hold up |
| [**Kitura (web framework)**](kitura-kitura.md) | Kitura, the IBM-started Swift web framework; TechEmpower Round 19 measured it at a third to half of Vapor's HTTP throughput. | A | ❌ Doesn't hold up |
