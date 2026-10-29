# Kitura (web framework)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Server and networking](../README.md) › [Web frameworks](README.md)</sub>

**Tier A** (reproducible public benchmark) · ❌ Doesn't hold up · Open source · `Swift` · `Apache-2.0` · 🔴 abandoned

> Kitura, the IBM-started Swift web framework; TechEmpower Round 19 measured it at a third to half of Vapor's HTTP throughput.

| | |
|---|---|
| **Beats** | Vapor 4 release candidate (TechEmpower "vapor" implementation; Fluent 4 RC with Postgres for the database test) |
| **Claimed result** | No HTTP speedup measured. TechEmpower Round 19: plaintext 72,839 vs Vapor 231,833 req/s (0.31x), JSON 66,318 vs 133,105 req/s (0.50x); Kitura-NIO plaintext 139,674 (0.60x), JSON 87,792 (0.66x). Single query with Kitura's ORM: 47,695 vs Vapor with Fluent 37,431 req/s (1.27x). (derived from page data: peak totalRequests per 15-second run, plaintext 1092580 vs 3477496, JSON 994765 vs 1996576, Kitura-NIO 2095106 and 1316874, single query 715428 vs 561468) |
| **Workload** | TechEmpower Framework Benchmarks plaintext (pipelined "Hello, World!"), JSON (one small object per request) and single-query (one random row from PostgreSQL returned as JSON) tests; peak requests per second across concurrency levels, 15-second runs. |
| **Metric** | throughput |
| **Hardware** | Three Dell R440 servers, Intel Xeon Gold 5120, 32 GB, 10 Gbps Ethernet (TechEmpower "Citrine" environment) |
| **OS** | Linux, in Docker |
| **Toolchain** | Kitura entries: Swift 4.1, Kitura 2.6.x, swift build -c release. Vapor entry: Swift 5.2, Vapor 4.0.0-rc, swift build --enable-test-discovery -c release |
| **Measured** | 2020-05-28 |
| **Adoption** | 7.6k stars |
| **Last commit** | 2022-10-07 |
| **Platforms** | macOS, Linux |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/Kitura/Kitura) · [benchmark](https://www.techempower.com/benchmarks/#section=data-r19&hw=ph&test=json) |

## Verdict

In Round 19 (2020), the last official round with Kitura results, Kitura served about a third of Vapor's plaintext throughput and half its JSON throughput, and its SwiftNIO-based variant still trailed at 0.60x and 0.66x. Its ORM beat Vapor with Fluent on the single-query test by 1.27x, but the project has had no commits since October 2022 and TechEmpower removed it in 2024.

**Why tier A:** TechEmpower runs the tests itself on stated hardware and publishes every implementation's source and Dockerfile, including the Swift version and build flags.

## Use it when

- Maintaining an existing Kitura service until it can be migrated; there is no performance reason to start one.

## Skip it when

- Any new project: the framework is unmaintained, and Vapor and Hummingbird out-served it on HTTP in the same round.
- Code that needs current Swift concurrency, Swift 6 or recent SwiftNIO releases.

## How it is fast

It was not faster at HTTP in the published data. Kitura's default server used its own socket layer (Kitura-net) rather than SwiftNIO; the Kitura-NIO variant swapped in SwiftNIO and closed part of the gap. The single-query result compares Kitura's Swift-Kuery ORM with a Fluent 4 release candidate, and neither project documented where the difference came from.

## What it costs

- No maintenance or security fixes since 2022.
- API built around completion handlers, not async/await.

## Problems with the evidence

- The comparison is uneven: the Kitura entries were built with Swift 4.1 and Kitura 2.6 while Vapor used Swift 5.2 and a Vapor 4 release candidate, so Kitura was measured on a two-year-older toolchain.
- Kitura's plaintext throughput fell sharply at the highest pipelined concurrency (136583 requests in the last 15-second step versus 1092580 at its peak), which points to a scaling problem rather than a constant overhead.
- Round 20 lists a kitura entry with no results, and TechEmpower removed Kitura and Perfect in May 2024 ("Remove Kitura and Perfect" commit), so Round 19 is the last data point.
- TechEmpower endpoints are deliberately trivial, so these numbers measure framework and driver overhead, not the throughput of a real application.
- Requests per second are computed from totalRequests divided by the 15-second duration in TechEmpower's raw results file; the interactive results page draws the same values as charts rendered by JavaScript.

## Evidence

<details>
<summary>9 quotes from the sources, checked 2026-10-28</summary>

> "kitura":[{"latencyAvg":"20.88ms","latencyMax":"354.56ms","latencyStdev":"42.70ms","totalRequests":814290,"startTime":1589223436,"endTime":1589223451},{"latencyAvg":"104.35ms","startTime":1589223453,"latencyMax":"496.00ms","latencyStdev":"55.31ms","totalRequests":1092580
>
> — [techempower.com/benchmarks/results/round19/ph.json](https://www.techempower.com/benchmarks/results/round19/ph.json)

> "vapor":[{"latencyAvg":"12.53ms","latencyMax":"560.56ms","latencyStdev":"25.17ms","totalRequests":3477496
>
> — [techempower.com/benchmarks/results/round19/ph.json](https://www.techempower.com/benchmarks/results/round19/ph.json)

> "kitura":[{"latencyAvg":"252.70us","latencyMax":"2.31ms","latencyStdev":"35.09us","totalRequests":947688,"startTime":1589223302,"endTime":1589223317},{"latencyAvg":"422.49us","latencyMax":"755.00us","latencyStdev":"27.69us","totalRequests":994765
>
> — [techempower.com/benchmarks/results/round19/ph.json](https://www.techempower.com/benchmarks/results/round19/ph.json)

> "vapor":[{"latencyAvg":"217.89us","latencyMax":"0.95ms","latencyStdev":"27.28us","totalRequests":1096228,"startTime":1589402847,"endTime":1589402862},{"latencyAvg":"255.01us","latencyMax":"12.27ms","latencyStdev":"76.81us","totalRequests":1646671,"startTime":1589402864,"endTime":1589402879},{"latencyAvg":"432.79us","latencyMax":"20.39ms","latencyStdev":"277.99us","totalRequests":1968819,"startTime…
>
> — [techempower.com/benchmarks/results/round19/ph.json](https://www.techempower.com/benchmarks/results/round19/ph.json)

> "kitura-nio":[{"latencyAvg":"17.79ms","latencyMax":"234.29ms","latencyStdev":"11.57ms","totalRequests":2095106
>
> — [techempower.com/benchmarks/results/round19/ph.json](https://www.techempower.com/benchmarks/results/round19/ph.json)

> "kitura-nio":[{"latencyAvg":"249.73us","latencyMax":"3.28ms","latencyStdev":"44.81us","totalRequests":960523,"startTime":1589225374,"endTime":1589225389},{"latencyAvg":"362.07us","latencyMax":"6.79ms","latencyStdev":"134.78us","totalRequests":1172916,"startTime":1589225391,"endTime":1589225406},{"latencyAvg":"690.57us","latencyMax":"10.07ms","latencyStdev":"482.60us","totalRequests":1308532,"start…
>
> — [techempower.com/benchmarks/results/round19/ph.json](https://www.techempower.com/benchmarks/results/round19/ph.json)

> "kitura-postgres-orm":[{"latencyAvg":"498.85us","latencyMax":"3.63ms","latencyStdev":"47.20us","totalRequests":481814,"startTime":1589227740,"endTime":1589227755},{"latencyAvg":"647.63us","latencyMax":"13.28ms","latencyStdev":"87.82us","totalRequests":650408,"startTime":1589227757,"endTime":1589227772},{"latencyAvg":"1.19ms","latencyMax":"4.03ms","latencyStdev":"125.77us","totalRequests":708260,"s…
>
> — [techempower.com/benchmarks/results/round19/ph.json](https://www.techempower.com/benchmarks/results/round19/ph.json)

> "vapor":[{"latencyAvg":"796.96us","latencyMax":"1.54ms","latencyStdev":"70.60us","totalRequests":301405,"startTime":1589402713,"endTime":1589402728},{"latencyAvg":"0.92ms","latencyMax":"8.99ms","latencyStdev":"92.78us","totalRequests":458468,"startTime":1589402730,"endTime":1589402746},{"latencyAvg":"1.50ms","latencyMax":"20.56ms","latencyStdev":"256.17us","totalRequests":559294,"startTime":158940…
>
> — [techempower.com/benchmarks/results/round19/ph.json](https://www.techempower.com/benchmarks/results/round19/ph.json)

> {"name":"Round 19 Citrine","completionTime":1589429246190,"duration":15,
>
> — [techempower.com/benchmarks/results/round19/ph.json](https://www.techempower.com/benchmarks/results/round19/ph.json)

</details>
