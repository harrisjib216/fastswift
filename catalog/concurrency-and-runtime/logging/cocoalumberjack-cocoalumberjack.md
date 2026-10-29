# CocoaLumberjack

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Concurrency and runtime](../README.md) › [Logging](README.md)</sub>

**Tier D** (directional only) · 🟡 Holds up in part · Open source · `Objective-C` · `BSD-3-Clause` · 🟢 active

> Logging framework that claimed an order-of-magnitude win over NSLog in 2010 benchmarks; untested against today's NSLog or os.Logger.

| | |
|---|---|
| **Beats** | NSLog (ASL-backed, pre-2016) and print |
| **Claimed result** | 'an order of magnitude faster than NSLog' in most cases (README; per-test numbers only in chart images) |
| **Workload** | Four tests of 1,000 log statements each: all asynchronous, all synchronous, a mixed-level simulation, and a debug-heavy simulation where 90% are filtered out; each run 20 times against NSLog |
| **Metric** | time |
| **Hardware** | iPhone 3GS, iPad, iMac, PowerMac |
| **Measured** | 2010 |
| **Adoption** | 13.3k stars |
| **Last commit** | 2026-10-28 |
| **Platforms** | iOS, macOS, tvOS, watchOS, visionOS |
| **Install** | Swift Package Manager, CocoaPods, Carthage |
| **Links** | [repository](https://github.com/CocoaLumberjack/CocoaLumberjack) · [benchmark](https://github.com/CocoaLumberjack/CocoaLumberjack/blob/master/Documentation/Performance.md) |

## Verdict

The 'order of magnitude faster than NSLog' claim rests on 2010 benchmarks on an iPhone 3GS, iPad, iMac and PowerMac, when NSLog opened an Apple System Log connection per call. NSLog has since moved to the unified logging system, and no current measurement was found, so the size of today's gap is unknown.

**Why tier D:** Benchmark code is in the repository, but the published results are chart images and unlabeled CSVs from 2010; the text gives only 'an order of magnitude'.

## Use it when

- You need file logging with rotation, custom formatters or several sinks from one call
- Most log calls are debug-level and filtered out at runtime
- A large existing codebase already uses DDLog

## Skip it when

- You only need system logging; os.Logger is built in, defers formatting, and its debug level is not persisted
- Crash-time logs must be complete: asynchronous messages can be lost if the process dies before the queue drains

## How it is fast

Log calls below the configured level are filtered out cheaply, and non-error messages are queued to a background GCD queue so the caller returns before formatting and I/O finish. Each logger (console, file) runs concurrently. The 2010 design also kept one reusable ASL connection, while NSLog opened a new one per call.

## What it costs

- Adds a dependency and a background queue
- Asynchronous messages can be dropped on crash
- Console.app and unified-log visibility require adding its os_log-backed logger

## Problems with the evidence

- 2010 hardware (iPhone 3GS, PowerMac) and a 2010 NSLog that wrote through ASL; since iOS 10 / macOS 10.12 NSLog writes to the unified log, so the per-call ASL cost the benchmark exploited is gone
- Numbers exist only as chart images on the page and as unlabeled CSV rows in Benchmarking/Results
- Asynchronous logging moves work off the calling thread rather than removing it
- No comparison with print or os.Logger was found

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> In most cases it is an order of magnitude faster than NSLog.
>
> — [github.com/CocoaLumberjack/CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack)

> The simple truth is that NSLog is just plain slow.
>
> — [github.com/CocoaLumberjack/CocoaLumberjack/blob/master/Documentatio…](https://github.com/CocoaLumberjack/CocoaLumberjack/blob/master/Documentation/Performance.md)

> every time NSLog is called it opens a new asl client connection, sends the message, and then closes the connection.
>
> — [github.com/CocoaLumberjack/CocoaLumberjack/blob/master/Documentatio…](https://github.com/CocoaLumberjack/CocoaLumberjack/blob/master/Documentation/Performance.md)

> Asynchronous logging test. Execute 1,000 log statements.
>
> — [github.com/CocoaLumberjack/CocoaLumberjack/blob/master/Documentatio…](https://github.com/CocoaLumberjack/CocoaLumberjack/blob/master/Documentation/Performance.md)

</details>
