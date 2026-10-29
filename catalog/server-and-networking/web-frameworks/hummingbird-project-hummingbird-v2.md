# Hummingbird 2 (HTTP server framework)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Server and networking](../README.md) › [Web frameworks](README.md)</sub>

**Tier A** (reproducible public benchmark) · ❌ Doesn't hold up · Open source · `Swift` · `Apache-2.0` · 🟢 active

> Hummingbird 2, the async/await rewrite, which TechEmpower Round 23 measured as slower than Vapor on plaintext and JSON.

| | |
|---|---|
| **Beats** | Vapor 4 (TechEmpower "vapor" implementation, same Swift toolchain and build flags) |
| **Claimed result** | No speedup measured. TechEmpower Round 23: plaintext 244,953 vs Vapor 310,442 req/s (0.79x), JSON 146,978 vs Vapor 263,364 req/s (0.56x). (derived from page data: peak totalRequests per 15-second run, plaintext 3674293 vs 4656628, JSON 2204663 vs 3950461) |
| **Workload** | TechEmpower Framework Benchmarks plaintext test (pipelined "Hello, World!" responses at 256 to 16,384 connections) and JSON test (one small JSON object serialized per request at 16 to 512 connections); peak requests per second across concurrency levels, 15-second runs. |
| **Metric** | throughput |
| **Hardware** | Three HPE ProLiant DL360 Gen10 Plus servers, Intel Xeon Gold 6330 (56 cores), 64 GB, 40 Gbps Ethernet |
| **OS** | Linux, in Docker (official swift slim images) |
| **Toolchain** | Swift 5.10, swift build -c release -Xswiftc -enforce-exclusivity=unchecked; Package.swift asks for hummingbird from 2.0.0-beta |
| **Measured** | 2025-02-24 |
| **Adoption** | 1.9k stars |
| **Last commit** | 2026-10-28 |
| **Platforms** | macOS 11+, iOS 15+, tvOS 15+, visionOS 1+, Linux |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/hummingbird-project/hummingbird) · [benchmark](https://www.techempower.com/benchmarks/#section=data-r23&hw=ph&test=json) |

## Verdict

Hummingbird's reputation as the faster Swift framework comes from the 1.x rows. In Round 23, the only official round with Hummingbird 2, it was slower than Vapor on both plaintext and JSON, and its Postgres implementation failed to start, so there is no database result either.

**Why tier A:** TechEmpower runs the tests itself on stated hardware and publishes every implementation's source and Dockerfile, including the Swift version and build flags.

## Use it when

- You want a small, modular async/await server framework and Vapor-level throughput is enough.

## Skip it when

- Choosing Hummingbird over Vapor for raw throughput: the only independent numbers show the opposite.

## How it is fast

It is not faster in the published data. Hummingbird 2 runs handlers as Swift concurrency tasks, which adds hops between the NIO EventLoop and the cooperative thread pool; the maintainer said in October 2024 that custom task executors, the planned fix, still had performance issues.

## Problems with the evidence

- TechEmpower endpoints are deliberately trivial, so these numbers measure framework and driver overhead, not the throughput of a real application.
- Requests per second are computed from totalRequests divided by the 15-second duration in TechEmpower's raw results file; the interactive results page draws the same values as charts rendered by JavaScript.
- The TechEmpower FrameworkBenchmarks repository was archived in March 2026, so Round 23 (published 2025-02-24) is the last official round. No Swift 6.x results exist.
- Round 23 ran from 2025-01-30 with Swift 5.10. Hummingbird 2 has had many releases since (2.25 in 2026), some listing performance work, and no newer independent numbers exist, so the gap may have changed.
- The hummingbird2-postgres implementation failed to start in Round 23 ("ERROR: Problem starting hummingbird2-postgres" in the raw results), so database tests have no Hummingbird 2 data.
- Built with -enforce-exclusivity=unchecked, which ordinary release builds do not use.

## Evidence

<details>
<summary>8 quotes from the sources, checked 2026-10-28</summary>

> "hummingbird2": [ { "latencyAvg": "8.71ms", "latencyStdev": "5.76ms", "latencyMax": "142.18ms", "totalRequests": 3674293
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> "vapor": [ { "latencyAvg": "7.03ms", "latencyStdev": "4.21ms", "latencyMax": "38.88ms", "totalRequests": 4656628
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> "hummingbird2": [ { "latencyAvg": "1.07ms", "latencyStdev": "242.29us", "latencyMax": "2.28ms", "totalRequests": 222774, "startTime": 1738604892, "endTime": 1738604907 }, { "latencyAvg": "511.60us", "latencyStdev": "192.55us", "latencyMax": "2.74ms", "totalRequests": 934337, "startTime": 1738604909, "endTime": 1738604924 }, { "latencyAvg": "433.35us", "latencyStdev": "128.31us", "latencyMax": "4.7…
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> "vapor": [ { "latencyAvg": "1.22ms", "latencyStdev": "255.89us", "latencyMax": "2.44ms", "totalRequests": 195267, "startTime": 1738301493, "endTime": 1738301508 }, { "latencyAvg": "1.11ms", "latencyStdev": "266.00us", "latencyMax": "2.52ms", "totalRequests": 429415, "startTime": 1738301510, "endTime": 1738301525 }, { "latencyAvg": "415.53us", "latencyStdev": "121.91us", "latencyMax": "2.67ms", "to…
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> Round 23 results are in: https://tfb-status.techempower.com/results/91a66052-9d86-446c-b31a-eadbd669ed08
>
> — [github.com/TechEmpower/FrameworkBenchmarks/issues/9589](https://github.com/TechEmpower/FrameworkBenchmarks/issues/9589)

> "uuid": "91a66052-9d86-446c-b31a-eadbd669ed08", "name": "Continuous Benchmarking Run 2025-01-30 18:47:41"
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> "duration": 15, "rawData": {
>
> — [techempower.com/benchmarks/results/round23/ph.json](https://www.techempower.com/benchmarks/results/round23/ph.json)

> Currently performance is not up to what we hoped for Hummingbird 2 we are waiting on some changes in Swift before we improve that. With Hummingbird 1 we were able to keep request processing to a single EventLoop, as we have moved to Swift concurrency the ability to do this has been complicated.
>
> — [forums.swift.org/t/hummingbird-2/74535](https://forums.swift.org/t/hummingbird-2/74535)

</details>
