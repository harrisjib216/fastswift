# Hummingbird 1.x (HTTP server framework)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Server and networking](../README.md) › [Web frameworks](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Open source · `Swift` · `Apache-2.0` · 🟡 stale

> Hummingbird 1.x, a SwiftNIO web framework that served about twice Vapor's plaintext and JSON throughput in TechEmpower Round 23.

| | |
|---|---|
| **Beats** | Vapor 4 (TechEmpower "vapor" implementation, same Swift toolchain and build flags) |
| **Claimed result** | TechEmpower Round 23: plaintext 644,858 vs 310,442 req/s (2.08x), JSON 570,403 vs 263,364 req/s (2.17x). Round 22: plaintext 643,202 vs 155,300 req/s (4.14x), JSON 347,095 vs 130,611 req/s (2.66x). (derived from page data: peak totalRequests per 15-second run, Round 23 plaintext 9672873 vs 4656628 and JSON 8556046 vs 3950461; Round 22 plaintext 9648031 vs 2329503 and JSON 5206421 vs 1959170) |
| **Workload** | TechEmpower Framework Benchmarks plaintext test (pipelined "Hello, World!" responses at 256 to 16,384 connections) and JSON test (one small JSON object serialized per request at 16 to 512 connections); peak requests per second across concurrency levels, 15-second runs. |
| **Metric** | throughput |
| **Hardware** | Round 23: three HPE ProLiant DL360 Gen10 Plus servers, Intel Xeon Gold 6330 (56 cores), 64 GB, 40 Gbps Ethernet. Round 22 and earlier: three Dell R440 servers, Intel Xeon Gold 5120, 32 GB, 10 Gbps Ethernet (TechEmpower "Citrine" environment) |
| **OS** | Linux, in Docker (official swift slim images) |
| **Toolchain** | Round 23: Swift 5.10, swift build -c release -Xswiftc -enforce-exclusivity=unchecked; Round 22: Swift 5.7 (SwiftNIO entry Swift 5.6), same flags |
| **Measured** | 2025-02-24 |
| **Adoption** | 1.9k stars |
| **Last commit** | 2024-05-03 |
| **Platforms** | Linux, macOS, iOS 12+, tvOS 12+ |
| **Install** | Swift Package Manager (1.x.x branch, tags 1.x) |
| **Links** | [repository](https://github.com/hummingbird-project/hummingbird) · [benchmark](https://www.techempower.com/benchmarks/#section=data-r23&hw=ph&test=json) |

## Verdict

Hummingbird 1.x served roughly twice Vapor's plaintext and JSON throughput in Round 23 and 2.7-4.1x in Round 22, so the gap is real for 1.x. But 1.x is superseded: its branch has had no commits since May 2024, and Hummingbird 2, the current major version, was slower than Vapor in the same Round 23 run.

**Why tier A:** TechEmpower runs the tests itself on stated hardware and publishes every implementation's source and Dockerfile, including the Swift version and build flags.

## Use it when

- Maintaining an existing Hummingbird 1.x service whose endpoints are small and framework overhead shows up in profiles.
- Code that already uses EventLoopFuture handlers and is not ready to move to async/await.

## Skip it when

- New projects: 1.x gets no feature work, and the current Hummingbird 2 does not keep the throughput lead over Vapor.
- Endpoints dominated by database or downstream calls, where a framework's per-request overhead is a small share of latency.
- Code that needs Swift 6 strict concurrency checking or the current Hummingbird ecosystem packages, which target 2.x.

## How it is fast

Hummingbird 1.x keeps each request on the SwiftNIO EventLoop that accepted the connection; handlers are synchronous closures or EventLoopFutures (the TechEmpower entry uses plain synchronous closures), so a request never pays for a hop to the Swift concurrency thread pool. Its HTTP core is a thin layer over NIOHTTP1 with a small router and few dependencies. The maintainer has said that losing this single-EventLoop path in the move to Swift concurrency is why Hummingbird 2 is slower.

## What it costs

- EventLoopFuture-based API instead of async/await.
- No longer developed; security and compatibility fixes now go to 2.x.
- Smaller ecosystem than Vapor (no Fluent-equivalent ORM bundled).

## Problems with the evidence

- TechEmpower endpoints are deliberately trivial, so these numbers measure framework and driver overhead, not the throughput of a real application.
- Requests per second are computed from totalRequests divided by the 15-second duration in TechEmpower's raw results file; the interactive results page draws the same values as charts rendered by JavaScript.
- The TechEmpower FrameworkBenchmarks repository was archived in March 2026, so Round 23 (published 2025-02-24) is the last official round. No Swift 6.x results exist.
- Round 22 used Swift 5.7 and Round 23 Swift 5.10, both with -enforce-exclusivity=unchecked, which disables runtime exclusivity checks that ordinary release builds keep.
- The 4.14x Round 22 plaintext gap shrank to 2.08x in Round 23 because Vapor's plaintext number doubled on the new hardware while Hummingbird 1.x stayed flat; Hummingbird 1.x plaintext may have been limited by something other than CPU.
- last_commit and maintenance_status describe the 1.x.x branch; the repository's main branch (2.x) is active.
- The Vapor entry registers async closures (req async in), which hop from the EventLoop to the Swift concurrency pool, while the Hummingbird 1.x entry uses synchronous closures; part of the gap is that choice, and a Vapor app with synchronous or EventLoopFuture handlers may close some of it.

## Evidence

<details>
<summary>16 quotes from the sources, checked 2026-10-28</summary>

> "hummingbird": [ { "latencyAvg": "23.20ms", "latencyStdev": "11.99ms", "latencyMax": "47.47ms", "totalRequests": 1412322, "startTime": 1738606585, "endTime": 1738606600 }, { "latencyAvg": "23.36ms", "latencyStdev": "11.88ms", "latencyMax": "145.82ms", "totalRequests": 5863160, "startTime": 1738606602, "endTime": 1738606617 }, { "latencyAvg": "312.39ms", "latencyStdev": "952.13ms", "latencyMax": "7…
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> "vapor": [ { "latencyAvg": "7.03ms", "latencyStdev": "4.21ms", "latencyMax": "38.88ms", "totalRequests": 4656628
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> "hummingbird": [ { "latencyAvg": "644.95us", "latencyStdev": "162.33us", "latencyMax": "1.28ms", "totalRequests": 370112, "startTime": 1738606452, "endTime": 1738606467 }, { "latencyAvg": "666.31us", "latencyStdev": "193.49us", "latencyMax": "1.77ms", "totalRequests": 716787, "startTime": 1738606469, "endTime": 1738606484 }, { "latencyAvg": "348.95us", "latencyStdev": "219.16us", "latencyMax": "1.…
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> "vapor": [ { "latencyAvg": "1.22ms", "latencyStdev": "255.89us", "latencyMax": "2.44ms", "totalRequests": 195267, "startTime": 1738301493, "endTime": 1738301508 }, { "latencyAvg": "1.11ms", "latencyStdev": "266.00us", "latencyMax": "2.52ms", "totalRequests": 429415, "startTime": 1738301510, "endTime": 1738301525 }, { "latencyAvg": "415.53us", "latencyStdev": "121.91us", "latencyMax": "2.67ms", "to…
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> "hummingbird": [ { "latencyAvg": "24.83ms", "latencyStdev": "13.04ms", "latencyMax": "57.43ms", "totalRequests": 1329910, "startTime": 1697242939, "endTime": 1697242954 }, { "latencyAvg": "24.94ms", "latencyStdev": "13.39ms", "latencyMax": "203.53ms", "totalRequests": 5304172, "startTime": 1697242956, "endTime": 1697242972 }, { "latencyAvg": "282.00ms", "latencyStdev": "911.68ms", "latencyMax": "8…
>
> — [techempower.com/benchmarks/results/round22/ph.json](https://www.techempower.com/benchmarks/results/round22/ph.json)

> "vapor": [ { "latencyAvg": "17.18ms", "latencyStdev": "24.41ms", "latencyMax": "515.49ms", "totalRequests": 2329503
>
> — [techempower.com/benchmarks/results/round22/ph.json](https://www.techempower.com/benchmarks/results/round22/ph.json)

> "hummingbird": [ { "latencyAvg": "213.92us", "latencyStdev": "30.84us", "latencyMax": "3.44ms", "totalRequests": 1091531, "startTime": 1697242806, "endTime": 1697242821 }, { "latencyAvg": "144.07us", "latencyStdev": "23.04us", "latencyMax": "7.45ms", "totalRequests": 2836171, "startTime": 1697242823, "endTime": 1697242838 }, { "latencyAvg": "165.21us", "latencyStdev": "99.46us", "latencyMax": "9.9…
>
> — [techempower.com/benchmarks/results/round22/ph.json](https://www.techempower.com/benchmarks/results/round22/ph.json)

> "vapor": [ { "latencyAvg": "290.01us", "latencyStdev": "29.71us", "latencyMax": "5.56ms", "totalRequests": 810880, "startTime": 1697546266, "endTime": 1697546281 }, { "latencyAvg": "345.35us", "latencyStdev": "62.37us", "latencyMax": "7.82ms", "totalRequests": 1194228, "startTime": 1697546283, "endTime": 1697546298 }, { "latencyAvg": "510.58us", "latencyStdev": "161.26us", "latencyMax": "8.55ms", …
>
> — [techempower.com/benchmarks/results/round22/ph.json](https://www.techempower.com/benchmarks/results/round22/ph.json)

> Round 23 results are in: https://tfb-status.techempower.com/results/91a66052-9d86-446c-b31a-eadbd669ed08
>
> — [github.com/TechEmpower/FrameworkBenchmarks/issues/9589](https://github.com/TechEmpower/FrameworkBenchmarks/issues/9589)

> "uuid": "91a66052-9d86-446c-b31a-eadbd669ed08", "name": "Continuous Benchmarking Run 2025-01-30 18:47:41"
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> "duration": 15, "rawData": {
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> Round 22 is composed of: Run ID: 66d86090-b6d0-46b3-9752-5aa4913b2e33 on our Citrine environment.
>
> — [techempower.com/blog/2023/11/15/framework-benchmarks-round-22/](https://www.techempower.com/blog/2023/11/15/framework-benchmarks-round-22/)

> "uuid": "66d86090-b6d0-46b3-9752-5aa4913b2e33", "name": "Continuous Benchmarking Run 2023-10-11 08:00:48"
>
> — [techempower.com/benchmarks/results/round22/ph.json](https://www.techempower.com/benchmarks/results/round22/ph.json)

> "duration": 15, "rawData": {
>
> — [techempower.com/benchmarks/results/round22/ph.json](https://www.techempower.com/benchmarks/results/round22/ph.json)

> Currently performance is not up to what we hoped for Hummingbird 2 we are waiting on some changes in Swift before we improve that. With Hummingbird 1 we were able to keep request processing to a single EventLoop, as we have moved to Swift concurrency the ability to do this has been complicated.
>
> — [forums.swift.org/t/hummingbird-2/74535](https://forums.swift.org/t/hummingbird-2/74535)

> You'll notice Hummingbird v1 is the fastest of the swift frameworks outside of the raw SwiftNIO server.
>
> — [forums.swift.org/t/hummingbird-2/74535](https://forums.swift.org/t/hummingbird-2/74535)

</details>
