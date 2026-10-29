# SwiftNIO (hand-written NIOHTTP1 server)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Server and networking](../README.md) › [Web frameworks](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Open source · `Swift + C` · `Apache-2.0` · 🟢 active

> SwiftNIO used directly as a bare HTTP/1.1 server, measured at 4-11x Vapor's throughput on TechEmpower's trivial endpoints.

| | |
|---|---|
| **Beats** | Vapor 4 (TechEmpower "vapor" implementation, same Swift toolchain and build flags) |
| **Claimed result** | TechEmpower Round 23: plaintext 3,312,290 vs 310,442 req/s (10.67x), JSON 1,089,033 vs 263,364 req/s (4.14x). Round 22: plaintext 1,959,794 vs 155,300 req/s (12.62x), JSON 492,019 vs 130,611 req/s (3.77x). (derived from page data: peak totalRequests per 15-second run, Round 23 plaintext 49684352 vs 4656628 and JSON 16335501 vs 3950461; Round 22 plaintext 29396904 vs 2329503 and JSON 7380286 vs 1959170) |
| **Workload** | TechEmpower Framework Benchmarks plaintext test (pipelined "Hello, World!" responses at 256 to 16,384 connections) and JSON test (one small JSON object serialized per request at 16 to 512 connections); peak requests per second across concurrency levels, 15-second runs. |
| **Metric** | throughput |
| **Hardware** | Round 23: three HPE ProLiant DL360 Gen10 Plus servers, Intel Xeon Gold 6330 (56 cores), 64 GB, 40 Gbps Ethernet. Round 22 and earlier: three Dell R440 servers, Intel Xeon Gold 5120, 32 GB, 10 Gbps Ethernet (TechEmpower "Citrine" environment) |
| **OS** | Linux, in Docker (official swift slim images) |
| **Toolchain** | Round 23: Swift 5.10, swift build -c release -Xswiftc -enforce-exclusivity=unchecked; Round 22: Swift 5.7 (SwiftNIO entry Swift 5.6), same flags |
| **Measured** | 2025-02-24 |
| **Adoption** | 8.5k stars |
| **Last commit** | 2026-10-19 |
| **Platforms** | macOS, iOS, tvOS, watchOS, Linux, Android |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/apple/swift-nio) · [benchmark](https://www.techempower.com/benchmarks/#section=data-r23&hw=ph&test=plaintext) |

## Verdict

A raw SwiftNIO server out-served Vapor by 4.1x on JSON and 10.7x on plaintext in Round 23, and the numbers hold. But the comparison is a 117-line handler that matches two URIs and writes pre-built buffers against a full framework, so the gap only applies to endpoints where you give up routing, middleware and content negotiation.

**Why tier A:** TechEmpower runs the tests itself on stated hardware and publishes every implementation's source and Dockerfile, including the Swift version and build flags.

## Use it when

- A tiny, fixed set of hot endpoints (health checks, a metrics or proxy front) where per-request framework cost dominates.
- Building your own protocol server or framework on top of NIO channel handlers.

## Skip it when

- Ordinary web applications: you would rewrite routing, body handling, error mapping and middleware that Vapor or Hummingbird already provide.
- Endpoints that spend their time in a database or another service; the framework overhead difference is small there.

## How it is fast

The TechEmpower entry is one ChannelInboundHandler that switches on the request URI, writes a pre-filled ByteBuffer for plaintext, reuses one JSONEncoder and output buffer per connection, caches the Date header per EventLoop, and flushes once per read batch. There is no router, middleware chain, request/response object model or Swift concurrency hop, which is where a framework spends its time on endpoints this small.

## What it costs

- Event-driven ChannelHandler code instead of async/await request handlers.
- No routing, middleware, content negotiation or HTTP/2 setup out of the box.

## Problems with the evidence

- TechEmpower endpoints are deliberately trivial, so these numbers measure framework and driver overhead, not the throughput of a real application.
- Requests per second are computed from totalRequests divided by the 15-second duration in TechEmpower's raw results file; the interactive results page draws the same values as charts rendered by JavaScript.
- The TechEmpower FrameworkBenchmarks repository was archived in March 2026, so Round 23 (published 2025-02-24) is the last official round. No Swift 6.x results exist.
- The swift-nio implementation is purpose-built for the benchmark (two URIs, pre-encoded plaintext body), so the gap overstates what a NIO-based app with real routing would see.
- Round 22 built the SwiftNIO entry with Swift 5.6 and Vapor with Swift 5.7; Round 23 built both with Swift 5.10. All use -enforce-exclusivity=unchecked.
- The Vapor entry registers async closures (req async in), adding a hop to the Swift concurrency pool per request that the NIO handler never makes.

## Evidence

<details>
<summary>14 quotes from the sources, checked 2026-10-28</summary>

> "swift-nio": [ { "latencyAvg": "674.67us", "latencyStdev": "444.82us", "latencyMax": "17.52ms", "totalRequests": 49467184, "startTime": 1738344701, "endTime": 1738344716 }, { "latencyAvg": "4.80ms", "latencyStdev": "23.12ms", "latencyMax": "552.28ms", "totalRequests": 49684352
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> "vapor": [ { "latencyAvg": "7.03ms", "latencyStdev": "4.21ms", "latencyMax": "38.88ms", "totalRequests": 4656628
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> "swift-nio": [ { "latencyAvg": "644.90us", "latencyStdev": "164.11us", "latencyMax": "1.19ms", "totalRequests": 370345, "startTime": 1738344568, "endTime": 1738344583 }, { "latencyAvg": "601.17us", "latencyStdev": "188.38us", "latencyMax": "1.92ms", "totalRequests": 793247, "startTime": 1738344585, "endTime": 1738344600 }, { "latencyAvg": "89.02us", "latencyStdev": "37.11us", "latencyMax": "2.80ms…
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> "vapor": [ { "latencyAvg": "1.22ms", "latencyStdev": "255.89us", "latencyMax": "2.44ms", "totalRequests": 195267, "startTime": 1738301493, "endTime": 1738301508 }, { "latencyAvg": "1.11ms", "latencyStdev": "266.00us", "latencyMax": "2.52ms", "totalRequests": 429415, "startTime": 1738301510, "endTime": 1738301525 }, { "latencyAvg": "415.53us", "latencyStdev": "121.91us", "latencyMax": "2.67ms", "to…
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> "swift-nio": [ { "latencyAvg": "1.28ms", "latencyStdev": "1.82ms", "latencyMax": "85.14ms", "totalRequests": 29396904
>
> — [techempower.com/benchmarks/results/round22/ph.json](https://www.techempower.com/benchmarks/results/round22/ph.json)

> "vapor": [ { "latencyAvg": "17.18ms", "latencyStdev": "24.41ms", "latencyMax": "515.49ms", "totalRequests": 2329503
>
> — [techempower.com/benchmarks/results/round22/ph.json](https://www.techempower.com/benchmarks/results/round22/ph.json)

> "swift-nio": [ { "latencyAvg": "217.85us", "latencyStdev": "30.42us", "latencyMax": "7.34ms", "totalRequests": 1071778, "startTime": 1697506454, "endTime": 1697506469 }, { "latencyAvg": "124.75us", "latencyStdev": "17.88us", "latencyMax": "4.12ms", "totalRequests": 3272261, "startTime": 1697506471, "endTime": 1697506486 }, { "latencyAvg": "131.15us", "latencyStdev": "66.36us", "latencyMax": "8.65m…
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

</details>
