# CwlUtils (Xoshiro)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Crypto and hashing](../README.md) › [Random numbers](README.md)</sub>

**Tier A** (reproducible public benchmark) · ✅ Holds up · Open source · `Swift` · `NOASSERTION` · 🔴 abandoned

> Swift Xoshiro256** generator from CwlUtils; 69x faster than arc4random_buf, the source behind SystemRandomNumberGenerator.

| | |
|---|---|
| **Beats** | SystemRandomNumberGenerator, which calls arc4random_buf on Apple platforms |
| **Claimed result** | 68.7x faster than arc4random_buf (0.244 s vs 16.76 s for 100 million 64-bit values, Swift 4.2) (derived from page data); the author puts Xoshiro at 1.45 nanoseconds per 64-bit number after subtracting test overhead |
| **Workload** | Generate 100 million UInt64 values through the RandomNumberGenerator protocol across one module boundary (incremental build, not whole-module optimization); a constant-returning generator measures the call overhead |
| **Metric** | time |
| **Hardware** | MacBookPro15,1 (Mac Pro 4,1 for the Swift 3 column) |
| **Toolchain** | Swift 4.2; build setting 'incremental' (not whole-module optimization) |
| **Adoption** | 622 stars |
| **Last commit** | 2021-08-27 |
| **Platforms** | Apple platforms (Package.swift declares no minimum versions) |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/mattgallagher/CwlUtils) · [benchmark](https://www.cocoawithlove.com/blog/2016/05/19/random-numbers.html) |

## Verdict

Generating 100 million UInt64 values took 0.244 s with the Swift Xoshiro generator against 16.76 s with arc4random_buf, the call behind SystemRandomNumberGenerator on Apple platforms. A 2025 measurement of a similar non-cryptographic generator on an M4 found a similar 40-50x gap.

**Why tier A:** Public performance test file (CwlRandomPerformanceTests.swift) in the library, with Swift version, Mac model and build setting stated.

## Use it when

- Simulations, games, procedural content, shuffling or test data that need millions of random values
- You need a seedable, repeatable sequence, which SystemRandomNumberGenerator cannot give
- Each thread can own its own generator

## Skip it when

- Keys, tokens, nonces, passwords or anything an attacker must not predict: Xoshiro is not cryptographically secure
- You only draw a handful of numbers; the system generator's cost will not show up

## How it is fast

Xoshiro256** keeps 256 bits of state in four UInt64 values and produces each number with a few shifts, rotates, XORs and one multiply, all inlinable. arc4random_buf takes a global lock, keeps a large cryptographic state, and periodically mixes in kernel entropy. The custom generator is a struct the caller owns, so there is no shared state or locking.

## What it costs

- Not cryptographically secure
- The caller must seed it and manage per-thread instances
- CwlUtils is a grab-bag utility package; copying the one struct is lighter than taking the dependency

## Problems with the evidence

- Swift 4.2-era measurement (post first published 2016-05-19 and later updated); no run date stated
- Measured through a non-inlined module boundary on purpose, so both generators pay the same call overhead (0.104 s for a constant generator)
- arc4random_buf's own speed has changed across OS releases: the same test took 4.359 s in the Swift 3 / Mac Pro column and 16.76 s in the Swift 4.2 / MacBookPro15,1 column
- The repository has had no commits since 2021; GitHub reports the license as NOASSERTION but LICENSE.txt is ISC

## Evidence

<details>
<summary>7 quotes from the sources, checked 2026-10-28</summary>

> Time taken to generate 100 million 64-bit values
>
> — [cocoawithlove.com/blog/2016/05/19/random-numbers.html](https://www.cocoawithlove.com/blog/2016/05/19/random-numbers.html)

> Seconds (Swift 4.2, MacBookPro15,1)
>
> — [cocoawithlove.com/blog/2016/05/19/random-numbers.html](https://www.cocoawithlove.com/blog/2016/05/19/random-numbers.html)

> 4.359 16.76
>
> — [cocoawithlove.com/blog/2016/05/19/random-numbers.html](https://www.cocoawithlove.com/blog/2016/05/19/random-numbers.html)

> (0.347) 0.244
>
> — [cocoawithlove.com/blog/2016/05/19/random-numbers.html](https://www.cocoawithlove.com/blog/2016/05/19/random-numbers.html)

> 0.211 0.104
>
> — [cocoawithlove.com/blog/2016/05/19/random-numbers.html](https://www.cocoawithlove.com/blog/2016/05/19/random-numbers.html)

> high performance (1.45 nanoseconds per 64-bit number, after subtracting test overheads)
>
> — [cocoawithlove.com/blog/2016/05/19/random-numbers.html](https://www.cocoawithlove.com/blog/2016/05/19/random-numbers.html)

> Apple platforms use `arc4random_buf(3)`.
>
> — [github.com/swiftlang/swift/blob/main/stdlib/public/core/Random.swift](https://github.com/swiftlang/swift/blob/main/stdlib/public/core/Random.swift)

</details>
