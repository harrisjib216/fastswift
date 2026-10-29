# Concurrency and runtime

<sub>[fastswift](../../README.md) › [Catalog](../README.md)</sub>

## [Locks and atomics](locks-and-atomics/README.md)

**The default:** NSLock, a serial DispatchQueue with sync, or an actor used as a lock.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**os_unfair_lock (os framework)**](locks-and-atomics/apple-os-os-unfair-lock.md) | Apple's unfair lock: about 29x faster than DispatchQueue.sync and 1.4x faster than pthread_mutex in an uncontended loop. | A | ✅ Holds up |
| [**OSAllocatedUnfairLock (os framework)**](locks-and-atomics/apple-os-osallocatedunfairlock.md) | Heap-allocated Swift wrapper for os_unfair_lock; faster than NSLock uncontended, but measured 1.75x slower under heavy contention. | B | 🟡 Holds up in part |
| [**Synchronization.Mutex (Swift 6)**](locks-and-atomics/apple-synchronization-mutex.md) | Swift 6's cross-platform lock; 1.6x faster than NSLock and 7.3x faster than an actor in one debug-build test. | B | 🟡 Holds up in part |

## [Reactive streams](reactive-streams/README.md)

**The default:** Combine.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**RxSwift**](reactive-streams/reactivex-rxswift.md) | Reactive Extensions for Swift; slower than Combine in 10 of 11 published operator benchmarks, so speed is not a reason to pick it. | B | ❌ Doesn't hold up |

## [Logging](logging/README.md)

**The default:** print and NSLog.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Chronicle**](logging/saagarjha-chronicle.md) | Experimental in-process structured logger claiming a few dozen nanoseconds per message; no published comparison with os_log or print. | C | 🟡 Holds up in part |
| [**CocoaLumberjack**](logging/cocoalumberjack-cocoalumberjack.md) | Logging framework that claimed an order-of-magnitude win over NSLog in 2010 benchmarks; untested against today's NSLog or os.Logger. | D | 🟡 Holds up in part |
