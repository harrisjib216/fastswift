# Synchronization.Mutex (Swift 6)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Concurrency and runtime](../README.md) › [Locks and atomics](README.md)</sub>

**Tier B** (independent measurement) · 🟡 Holds up in part · Ships with Apple's SDKs · `Swift` · `Apple SDK` · 🟢 active

> Swift 6's cross-platform lock; 1.6x faster than NSLock and 7.3x faster than an actor in one debug-build test.

| | |
|---|---|
| **Beats** | NSLock, or an actor used as a lock |
| **Claimed result** | 1.6x faster than NSLock (0.971 s vs 1.555 s) and 7.3x faster than an actor (0.971 s vs 7.098 s) for 10 tasks x 1_000_000 enqueues (derived from page data); in the same thread another poster measured an actor at ~50 s vs NSLock at ~2 s for 100M contended increments |
| **Workload** | 10 child tasks in a TaskGroup, each enqueuing 1,000,000 Ints into one shared FIFO guarded by NSLock, Mutex, or an actor; wall-clock seconds for the whole group |
| **Metric** | time |
| **Hardware** | MacBook Air M1 (8 cores) |
| **OS** | macOS 13.6.6 |
| **Toolchain** | Xcode 15.2 with the swift-PR-71383-1223 pre-release toolchain; debug build |
| **Measured** | 2024-04-20 |
| **Platforms** | iOS 18+, macOS 15+, tvOS 18+, watchOS 11+, visionOS 2+, Linux, Windows |
| **Install** | built into the Swift 6 standard library (import Synchronization); needs an iOS 18 / macOS 15 deployment target on Apple platforms |
| **Links** | [documentation](https://developer.apple.com/documentation/synchronization/mutex) · [benchmark](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338) |

## Verdict

The only published Swift numbers come from a debug build on a pre-release toolchain: Mutex was 1.6x faster than NSLock and 7.3x faster than an actor under 10-task contention. The direction is plausible because Mutex wraps os_unfair_lock on Apple platforms, but no release-build comparison was found.

**Why tier B:** Independent forum benchmark with code, Mac model and Xcode version posted, but run as a debug build on a pre-release toolchain.

## Use it when

- Guarding small shared state that synchronous code also touches
- Low-level data structures (queues, caches) where a hop to an actor per operation is too expensive
- Code that must build on Linux and Windows as well as Apple platforms

## Skip it when

- Deployment targets below iOS 18 / macOS 15 (use OSAllocatedUnfairLock or a backport such as swhitty/swift-mutex)
- Long-running or blocking work inside the critical section; an actor suspends instead of blocking a thread
- Code that needs recursive locking

## How it is fast

Mutex stores the protected value inline and is noncopyable, so it has a stable address without a separate heap allocation. On Apple platforms it is built on os_unfair_lock, which takes the lock with an atomic compare-and-swap and only enters the kernel on contention. An actor used as a lock pays for task suspension and executor hops on every access.

## What it costs

- Not recursive; relocking on the same thread deadlocks
- Blocks the calling thread under contention instead of suspending the task
- Noncopyable type: it has to live in a class, global, or other stable storage

## Problems with the evidence

- Debug build, so absolute times and possibly ratios differ from release builds
- Pre-release toolchain from before Swift 6 shipped
- Single run per variant, measured with Date(); no variance reported
- The ~50 s actor and ~2 s NSLock figures come from a different poster whose build settings and hardware are not stated

## Evidence

<details>
<summary>10 quotes from the sources, checked 2026-10-28</summary>

> 1.55503511428833 (NSLock)
>
> — [forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338)

> 0.9709900617599487 (SE-0433 Mutex)
>
> — [forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338)

> 7.098009943962097 (actor)
>
> — [forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338)

> let numberOfTasks = 10
>
> — [forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338)

> let numberOfItems = 1_000_000
>
> — [forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338)

> // MacBook Air M1 (8-cores)
>
> — [forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338)

> // Xcode 15.2, macOS 13.6.6, build debug
>
> — [forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338)

> NSLock ~ 2 sec
>
> — [forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338)

> actor/await ~ 50 sec
>
> — [forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338)

> sequential version (all 100M
>
> — [forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338)

</details>
