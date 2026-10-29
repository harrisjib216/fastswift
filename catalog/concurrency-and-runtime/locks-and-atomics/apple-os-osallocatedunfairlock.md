# OSAllocatedUnfairLock (os framework)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Concurrency and runtime](../README.md) › [Locks and atomics](README.md)</sub>

**Tier B** (independent measurement) · 🟡 Holds up in part · Ships with Apple's SDKs · `Swift` · `Apple SDK` · 🟢 active

> Heap-allocated Swift wrapper for os_unfair_lock; faster than NSLock uncontended, but measured 1.75x slower under heavy contention.

| | |
|---|---|
| **Beats** | NSLock |
| **Claimed result** | Under contention it was slower: ~3.5 s vs ~2 s for NSLock (1.75x slower, derived from page data) for 100M increments from 10 parallel tasks; uncontended, the underlying os_unfair_lock took 0.12 s vs 0.172 s for pthread_mutex over 10 million cycles (1.4x faster, derived, 2019) |
| **Workload** | 10 tasks in parallel, each incrementing one shared Int 10 million times (100M increments in total) behind NSLock, OSAllocatedUnfairLock, an atomic, or an actor; a single-thread run of the same work took about 0.1 s |
| **Metric** | time |
| **Measured** | 2024-04-20 |
| **Platforms** | iOS 16+, macOS 13+, tvOS 16+, watchOS 9+ |
| **Install** | built into iOS 16+ / macOS 13+ (import os) |
| **Links** | [documentation](https://developer.apple.com/documentation/os/osallocatedunfairlock) · [benchmark](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338) |

## Verdict

The underlying os_unfair_lock is about 1.4x faster than pthread_mutex (which NSLock wraps) when uncontended, but the one published contended test found OSAllocatedUnfairLock 1.75x slower than NSLock. The win holds for uncontended access only.

**Why tier B:** Independent forum measurement with the workload described, but no hardware, build settings or code for the timed variant.

## Use it when

- Mostly uncontended locking on iOS 16+ / macOS 13+ where Mutex (iOS 18+) is not yet available
- You need the os_unfair_lock speed without the unsafe &lock pattern

## Skip it when

- Many threads hammer the same lock continuously; in the only published test NSLock finished faster
- Cross-platform code (use Synchronization.Mutex)
- Deployment targets below iOS 16 / macOS 13

## How it is fast

It allocates the os_unfair_lock (and optionally the protected state) on the heap, so the lock has the stable address that a Swift value type cannot guarantee. Acquisition is an atomic compare-and-swap in user space, with a kernel call only on contention. The thread that measured it slower than NSLock under contention did not explain the cause.

## What it costs

- One extra heap allocation per lock compared with Mutex
- Not FIFO and not recursive
- Apple platforms only

## Problems with the evidence

- The poster said the OSAllocatedUnfairLock timing was unstable, between 3 and 4 seconds
- Hardware, OS and build configuration are not stated for the contended test
- The uncontended comparison is indirect: it measures raw os_unfair_lock against pthread_mutex in 2019, not OSAllocatedUnfairLock against NSLock

## Evidence

<details>
<summary>7 quotes from the sources, checked 2026-10-28</summary>

> NSLock ~ 2 sec
>
> — [forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338)

> OSAllocatedUnfairLock ~ 3.5 sec
>
> — [forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338)

> running 10 tasks in parallel each
>
> — [forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338)

> sequential version (all 100M
>
> — [forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338](https://forums.swift.org/t/se-0433-mutex-vs-actor-general-advice/71338)

> I ran a simple loop, 10 million times, entering a mutex, incrementing a counter, and leaving the mutex.
>
> — [cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html](https://www.cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html)

> 0.263 0.175 0.172
>
> — [cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html](https://www.cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html)

> 0.187 0.130 0.12
>
> — [cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html](https://www.cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html)

</details>
