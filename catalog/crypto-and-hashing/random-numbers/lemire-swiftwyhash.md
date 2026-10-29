# SwiftWyhash (WyRand)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Crypto and hashing](../README.md) › [Random numbers](README.md)</sub>

**Tier B** (independent measurement) · ✅ Holds up · Open source · `Swift` · `Apache-2.0` · 🟡 stale

> Pure-Swift wyrand generator; about 50x faster than Double.random(in:) with the system generator for bulk random arrays.

| | |
|---|---|
| **Beats** | SystemRandomNumberGenerator via Double.random(in:) |
| **Claimed result** | About 50x faster than the default Swift random (65 ms vs 3318 ms for 100,000,000 Doubles; 81 ms when still going through Double.random(in:using:)), 42x in an earlier run; a second poster saw ~12x from swapping in a Mersenne Twister |
| **Workload** | Fill a [Double] of 100,000,000 elements with uniform values in [0, 1); wyrand either fed through Double.random(in:using:) or converted directly by dividing by 2^64 |
| **Metric** | time |
| **Hardware** | Apple M4 Mac |
| **Toolchain** | swiftc -Ounchecked; timed with hyperfine |
| **Measured** | 2025-05 |
| **Adoption** | 25 stars |
| **Last commit** | 2025-05-26 |
| **Platforms** | Any platform with 64-bit Swift (uses multipliedFullWidth) |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/lemire/SwiftWyhash) · [benchmark](https://forums.swift.org/t/creating-an-array-of-random-numbers-in-swift-is-slow/80022?page=2) |

## Verdict

On an M4 Mac with -Ounchecked, filling a 100-million-element Double array with a wyrand generator took 65-81 ms against 3,318 ms with Double.random(in:), which uses the system generator. The algorithm is the one Lemire ported; the measured port uses newer upstream constants but the same operations.

**Why tier B:** Independent forum benchmark (hyperfine, M4, -Ounchecked, code posted in the thread), but it measures an updated port rather than this package as published.

## Use it when

- Filling large arrays with random values for simulation, Monte Carlo or test data
- Shuffling or sampling at high volume where predictability to an attacker does not matter
- You want a seedable, reproducible stream

## Skip it when

- Security-sensitive randomness (keys, tokens, nonces): wyrand is not cryptographically secure
- Code that draws only a few values

## How it is fast

Each value costs one 64-bit add, one 64x64-to-128-bit multiply and an XOR on a single UInt64 of state, with no locks and no system calls. SystemRandomNumberGenerator goes to arc4random_buf on Apple platforms and getrandom on Linux for every value, which adds locking and cryptographic mixing. The generator is a small struct that the compiler can inline into the fill loop.

## What it costs

- Not cryptographically secure; only 64 bits of state
- The package lags upstream wyhash by several years, as noted in the thread
- Small project (25 stars), no commits since May 2025

## Problems with the evidence

- The benchmarked WyRand is a forum poster's update of this package with newer upstream constants, not the package byte for byte
- Part of the 50x comes from avoiding Double.random(in:) itself; through Double.random(in:using:) the gap was 41x (derived)
- Single machine, single poster; Swift version not stated
- Lemire's own follow-up post notes wyhash-style generators lose some of their edge on older ARM cores where the high half of a 64-bit multiply is slow; the M4 result suggests this does not apply to Apple silicon

## Evidence

<details>
<summary>7 quotes from the sources, checked 2026-10-28</summary>

> The wyrand method was about 50x faster than the default Swift random.
>
> — [forums.swift.org/t/creating-an-array-of-random-numbers-in-swift-is-…](https://forums.swift.org/t/creating-an-array-of-random-numbers-in-swift-is-slow/80022?page=2)

> Swift random rand.swift 3318 50.5x
>
> — [forums.swift.org/t/creating-an-array-of-random-numbers-in-swift-is-…](https://forums.swift.org/t/creating-an-array-of-random-numbers-in-swift-is-slow/80022?page=2)

> WyRand random wyrand.swift 81 1.2x
>
> — [forums.swift.org/t/creating-an-array-of-random-numbers-in-swift-is-…](https://forums.swift.org/t/creating-an-array-of-random-numbers-in-swift-is-slow/80022?page=2)

> WyRand uniform wyuniform.swift 65
>
> — [forums.swift.org/t/creating-an-array-of-random-numbers-in-swift-is-…](https://forums.swift.org/t/creating-an-array-of-random-numbers-in-swift-is-slow/80022?page=2)

> grants me a ~12x speed increase in throughput
>
> — [forums.swift.org/t/creating-an-array-of-random-numbers-in-swift-is-…](https://forums.swift.org/t/creating-an-array-of-random-numbers-in-swift-is-slow/80022?page=2)

> 42x faster than
>
> — [forums.swift.org/t/creating-an-array-of-random-numbers-in-swift-is-…](https://forums.swift.org/t/creating-an-array-of-random-numbers-in-swift-is-slow/80022)

> when filling a Double array of 100,000,000 elements. This was measured on an M4 Mac, compiling with -Ounchecked, and using hyperfine for the benchmark.
>
> — [forums.swift.org/t/creating-an-array-of-random-numbers-in-swift-is-…](https://forums.swift.org/t/creating-an-array-of-random-numbers-in-swift-is-slow/80022)

</details>
