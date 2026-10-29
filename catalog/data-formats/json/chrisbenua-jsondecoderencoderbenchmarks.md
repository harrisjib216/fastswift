# FastCoders (JSONDecoderEncoderBenchmarks)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md) › [JSON](README.md)</sub>

**Tier C** (first-party numbers) · 🟡 Holds up in part · No open-source license · `Swift` · 🟡 stale

> Patched JSONDecoder/JSONEncoder that skips slow conformance checks; 2x faster in a huge app, now largely merged into swift-foundation.

| | |
|---|---|
| **Beats** | Foundation JSONDecoder / JSONEncoder (swift-foundation, before PR #1481) in an app with about 150k protocol conformances |
| **Claimed result** | Production A/B (80k measurements), median per-launch total: JSONDecoder 200 ms vs 422 ms, JSONEncoder 73 ms vs 159 ms. Synthetic 10k-model binary, median: optimized JSONDecoder 2.65 s vs 5.826 s, 0.114 s with String coding keys; optimized JSONEncoder 2.68 s vs 8.08 s, 0.149 s with String coding keys. |
| **Workload** | Summed JSONDecoder.decode / JSONEncoder.encode time during app launch in a large iOS app; synthetic: 2.5k decodes and encodes of a 319-byte JSON across 10k generated Codable models in a binary with ~70k conformance records |
| **Metric** | time |
| **Toolchain** | SwiftPM release build (arm64-apple-macosx/release); Swift version not stated |
| **Measured** | 2025-08 |
| **Adoption** | 3 stars |
| **Last commit** | 2025-08-27 |
| **Platforms** | Apple platforms |
| **Install** | Source only (FastCoders target in the benchmark repository) |
| **Links** | [repository](https://github.com/ChrisBenua/JSONDecoderEncoderBenchmarks) · [benchmark](https://github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md) |

## Verdict

The 2x production win holds for very large binaries, but Apple merged the two safe optimizations into swift-foundation (PR #1481, 2025-09-30), so on Foundation builds that include it there is little left to gain. The 98% synthetic figures need String coding keys, which Apple declined to adopt and which drop typed CodingKeys.

**Why tier C:** Code is public and built in release mode, but hardware and Swift version are not stated, the production A/B numbers cannot be reproduced, and the author wrote the library.

## Use it when

- Very large apps whose launch-time JSON work shows swift_conformsToProtocol in profiles
- Foundation builds that predate swift-foundation PR #1481

## Skip it when

- Your Foundation already includes PR #1481
- You use convertFromSnakeCase or custom key strategies: the optimization only applies to .useDefaultKeys
- Small apps: the author notes Apple's own benchmark, which loops in one process with a small binary, hides this cost

## How it is fast

Foundation's JSONDecoder.unwrap and JSONEncoder.wrapGeneric run a dynamic cast for every value to detect String-keyed dictionaries. The first such check per type scans every protocol conformance record in the binary, which in an app with 150k conformances dominates decode time. FastCoders skips the check when the key strategy is .useDefaultKeys, where its result is never used.

## What it costs

- The largest gains need String-based CodingKeys, losing compile-time key checking
- Not a packaged library

## Problems with the evidence

- No license file: study only.
- Production numbers come from the author's app and cannot be reproduced.
- In the forum thread, Kevin Perry (swift-foundation) said optimizations 1 and 2 would be straightforward to take and declined the ABI-breaking change; the String coding key idea was not adopted.
- The author reports dyld's iOS 16+ conformance cache does not cover these generic dictionary checks; 98% of their users were on iOS 16+ and still saw the gain.

## Evidence

<details>
<summary>15 quotes from the sources, checked 2026-10-28</summary>

> We have 80k measurements from different devices.
>
> — [github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md](https://github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md)

> | standard JSONDecoder  | 198 ms          | 282 ms           | 422 ms         | 667 ms          | 1017 ms        |
>
> — [github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md](https://github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md)

> | optimized JSONDecoder | 100 ms          | 133 ms          | 200 ms         | 322 ms          | 528 ms         |
>
> — [github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md](https://github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md)

> | standard JSONEncoder  | 59 ms        | 94 ms         | 159 ms       | 289 ms        | 547 ms       |
>
> — [github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md](https://github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md)

> | optimized JSONEncoder | 14 ms        | 30 ms         | 73 ms        | 135 ms        | 220 ms       |
>
> — [github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md](https://github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md)

> | standard JSONDecoder                        | 5.81 s         | 5.826 s        | 5.86 s          |
>
> — [github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md](https://github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md)

> | optimized JSONDecoder                       | 2.64 s (↑55%)  | 2.65 s (↑55%)  | 2.66 s (↑54.6%) |
>
> — [github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md](https://github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md)

> | optimized JSONDecoder + String as CodingKey | 0.113 s (↑98%) | 0.114 s (↑98%) | 0.116 s (↑98%)  |
>
> — [github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md](https://github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md)

> | standard JSONEncoder                        | 8.06 s           | 8.08 s           | 8.12 s           |
>
> — [github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md](https://github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md)

> | optimized JSONEncoder                       | 2.67 s (↑67%)    | 2.68 s (↑67%)    | 2.69 s (↑67%)    |
>
> — [github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md](https://github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md)

> | optimized JSONEncoder + String as CodingKey | 0.148 s (↑98.1%) | 0.149 s (↑98.2%) | 0.151 s (↑98.1%) |
>
> — [github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md](https://github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md)

> Its size is only 319 bytes.
>
> — [github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md](https://github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md)

> contains 10k Codable models with standard Codable implementation. These 10k Codable models can be semantically splitted to 2.5k groups of 4.
>
> — [github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md](https://github.com/ChrisBenua/JSONDecoderEncoderBenchmarks/blob/main/README.md)

> So we can easily skip this checks when default keyDecoding/EncodingStrategy is used.
>
> — [github.com/swiftlang/swift-foundation/pull/1481](https://github.com/swiftlang/swift-foundation/pull/1481)

> 98% of our users already use iOS 16 or newer iOS versions. And still we get massive improvement in
>
> — [forums.swift.org/t/improving-jsondecoder-encoder-performance-for-la…](https://forums.swift.org/t/improving-jsondecoder-encoder-performance-for-large-apps/81839)

</details>
