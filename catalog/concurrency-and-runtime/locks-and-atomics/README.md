# Locks and atomics

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Concurrency and runtime](../README.md)</sub>

**The default:** NSLock, a serial DispatchQueue with sync, or an actor used as a lock.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**os_unfair_lock (os framework)**](apple-os-os-unfair-lock.md) | Apple's unfair lock: about 29x faster than DispatchQueue.sync and 1.4x faster than pthread_mutex in an uncontended loop. | A | ✅ Holds up |
| [**OSAllocatedUnfairLock (os framework)**](apple-os-osallocatedunfairlock.md) | Heap-allocated Swift wrapper for os_unfair_lock; faster than NSLock uncontended, but measured 1.75x slower under heavy contention. | B | 🟡 Holds up in part |
| [**Synchronization.Mutex (Swift 6)**](apple-synchronization-mutex.md) | Swift 6's cross-platform lock; 1.6x faster than NSLock and 7.3x faster than an actor in one debug-build test. | B | 🟡 Holds up in part |
