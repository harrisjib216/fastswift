# Chronicle

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Concurrency and runtime](../README.md) › [Logging](README.md)</sub>

**Tier C** (first-party numbers) · 🟡 Holds up in part · No open-source license · `Swift` · 🟢 active

> Experimental in-process structured logger claiming a few dozen nanoseconds per message; no published comparison with os_log or print.

| | |
|---|---|
| **Beats** | os_log / os.Logger, NSLog and print |
| **Claimed result** | 'just a few dozen nanoseconds per message' (no baseline measured) |
| **Workload** | Not stated |
| **Metric** | latency |
| **Adoption** | 118 stars |
| **Last commit** | 2026-01-01 |
| **Platforms** | Apple platforms (reads __TEXT,__cstring from loaded images) |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/saagarjha/Chronicle) · [benchmark](https://github.com/saagarjha/Chronicle) |

## Verdict

The README claims a few dozen nanoseconds per message but publishes no benchmark, no baseline numbers and no hardware. The author also says the library is an experiment that is not complete or ready for use.

**Why tier C:** First-party per-message figure with no harness, hardware or comparison numbers.

## Use it when

- Studying how to build a low-overhead, crash-durable in-process log
- Very high message rates where os_log might drop messages, if you accept experimental code

## Skip it when

- Production apps: the author says it is not complete or ready for use
- You need Console.app, Instruments or sysdiagnose integration
- You need a license to ship it: the repository has none

## How it is fast

A #log macro and inlining turn each call into direct writes into a memory-mapped ring buffer, with no system call or XPC per message. Constant strings are recorded as offsets into the binary rather than copied, and only typed arguments plus a timestamp and logger ID are written. Formatting happens later, when the log is read.

## What it costs

- Logs live in your own file; no system-wide collection or Apple tooling
- Only simple integer, floating-point, Bool and String arguments can be logged
- Swift only

## Problems with the evidence

- No benchmark code or numbers in the repository text beyond the one README figure
- No license file, so the code is study-only

## Evidence

<details>
<summary>2 quotes from the sources, checked 2026-10-28</summary>

> With logging this cheap (just a few dozen nanoseconds per message!) there's no reason to turn it off.
>
> — [github.com/saagarjha/Chronicle](https://github.com/saagarjha/Chronicle)

> Complete or ready for use. See below.
>
> — [github.com/saagarjha/Chronicle](https://github.com/saagarjha/Chronicle)

</details>
