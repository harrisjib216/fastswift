# os_unfair_lock (os framework)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Concurrency and runtime](../README.md) › [Locks and atomics](README.md)</sub>

**Tier A** (reproducible public benchmark) · ✅ Holds up · Ships with Apple's SDKs · `C` · `Apple SDK` · 🟢 active

> Apple's unfair lock: about 29x faster than DispatchQueue.sync and 1.4x faster than pthread_mutex in an uncontended loop.

| | |
|---|---|
| **Beats** | DispatchQueue.sync on a serial queue used as a mutex; also pthread_mutex, which NSLock wraps |
| **Claimed result** | 29x faster than DispatchQueue.sync (0.12 s vs 3.484 s for 10 million lock/increment/unlock cycles, Swift 5.0) and 1.4x faster than pthread_mutex_lock/unlock (0.12 s vs 0.172 s) (derived from page data); a separate 2018 benchmark found DispatchQueue 7-8 times slower than locks for getters and 3-4 times slower for setters |
| **Workload** | Single thread, 10 million iterations of lock, increment a counter, unlock (uncontended). Second source: a class with a locked getter and setter, each sample averaged over 100 runs. |
| **Metric** | time |
| **Hardware** | MacBookPro15,1 (2018 15-inch MacBook Pro); Mac Pro 4,1 for the Swift 3.0 column |
| **Toolchain** | Swift 5.0 master snapshot of 2019-01-19 (the page also has Swift 3.0 and Swift 4.2 columns) |
| **Measured** | 2019-01 |
| **Platforms** | iOS 10+, macOS 10.12+, tvOS 10+, watchOS 3+ |
| **Install** | built into iOS 10+ / macOS 10.12+ (os module) |
| **Links** | [documentation](https://developer.apple.com/documentation/os/os_unfair_lock) · [benchmark](https://www.cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html) |

## Verdict

Two independent benchmarks agree that a lock beats a serial queue's sync by a wide margin: 29x for os_unfair_lock in an uncontended loop (Swift 5.0, 2019), and 3-8x for locks in general in a 2018 getter/setter test. The gap to pthread_mutex is much smaller, about 1.4x.

**Why tier A:** Third-party benchmark whose test file is public (CwlUtils CwlMutexPerformanceTests.swift), with the Swift toolchain and Mac model stated for each column.

## Use it when

- Short critical sections (read or write a property, update a small dictionary) that run very often
- Code that must stay synchronous and cannot hop to an actor
- Apple-only code on OS versions before OSAllocatedUnfairLock (iOS 16) or Mutex (iOS 18)

## Skip it when

- Calling os_unfair_lock_lock(&lock) on a Swift stored property: Apple's documentation says this is unsafe because the value has no stable address; use OSAllocatedUnfairLock, Mutex, or a manually allocated pointer
- The critical section can block or run long; the lock gives no FIFO order and can starve waiters
- Code that must build on Linux or Windows (use Mutex or pthread_mutex)

## How it is fast

The lock is a 32-bit word taken with an atomic compare-and-swap in user space, and it only calls into the kernel when there is contention. DispatchQueue.sync adds queue bookkeeping, and in the Swift 3/4 era it also heap-allocated the closure context because the call crosses into libdispatch and cannot be inlined. The lock hands ownership to an arbitrary waiter instead of keeping FIFO order, so it skips fairness bookkeeping.

## What it costs

- Not FIFO: a waiting thread can be passed over repeatedly
- Not recursive; relocking from the same thread deadlocks or traps
- Must be unlocked on the thread that locked it
- Apple platforms only

## Problems with the evidence

- Uncontended single-thread loop only; contended behaviour is not measured on this page
- Numbers are from 2016-2019 toolchains (Swift 3.0 to a Swift 5.0 snapshot); no current release-build measurement on Apple silicon was found
- The table does not state the build configuration; the article recommends whole-module optimization
- The 2018 corroborating benchmark (vadimbulavin.com) gives ratios only, with numbers in chart images and no hardware stated

## Evidence

<details>
<summary>7 quotes from the sources, checked 2026-10-28</summary>

> I ran a simple loop, 10 million times, entering a mutex, incrementing a counter, and leaving the mutex.
>
> — [cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html](https://www.cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html)

> (Swift 5.0 master 2019-01-19, MacBookPro 15,1)
>
> — [cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html](https://www.cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html)

> 3.530 3.687 3.484
>
> — [cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html](https://www.cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html)

> 0.263 0.175 0.172
>
> — [cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html](https://www.cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html)

> 0.187 0.130 0.12
>
> — [cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html](https://www.cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html)

> DispatchQueue is 7-8 times slower than locks
>
> — [vadimbulavin.com/benchmarking-locking-apis/](https://www.vadimbulavin.com/benchmarking-locking-apis/)

> DispatchQueue is 3-4 times slower than locks
>
> — [vadimbulavin.com/benchmarking-locking-apis/](https://www.vadimbulavin.com/benchmarking-locking-apis/)

</details>
