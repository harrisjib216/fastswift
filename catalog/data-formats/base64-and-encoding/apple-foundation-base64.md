# Foundation Base64 (swift-foundation 2025 rewrite)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Data formats](../README.md) › [Base64 and encoding](README.md)</sub>

**Tier C** (first-party numbers) · ✅ Holds up · Ships with Apple's SDKs · `Swift` · `Apple SDK` · 🟢 active

> Foundation's own Base64, rewritten in Swift in 2025: 1 MB encodes and decodes 5-7.5x faster than the version it replaced.

| | |
|---|---|
| **Beats** | Foundation base64EncodedString / Data(base64Encoded:) as shipped before February 2025 |
| **Claimed result** | 1MB encode to String 414μs vs 2915μs (7x), to Data 494μs vs 2894μs (5.8x); JWT-header encode 120ns vs 409ns (3.4x); 1MB decode from String 405μs vs 3038μs (7.5x), from Data 406μs vs 2123μs (5.2x); invalid input after 257 bytes 2675ns vs 748ns (3.5x slower). Follow-ups: encoding '3-4 times' faster again, decoding 'Generally ~2, but up to 4 times' faster. |
| **Workload** | swift-foundation Base64 benchmarks: encoding and decoding 1 MB buffers to and from String and Data, line-length options, a JWT header, and an invalid-input case |
| **Metric** | time |
| **Hardware** | Not stated for the 2025 numbers; the follow-up PRs list Apple M1 and M6 machines |
| **Measured** | 2025-02 |
| **Platforms** | Foundation releases built from swift-foundation after February 2025 (first OS release not stated in the sources) |
| **Install** | built into Foundation |
| **Links** | [documentation](https://developer.apple.com/documentation/foundation/data/base64encodedstring(options:)) · [benchmark](https://github.com/swiftlang/swift-foundation/pull/1157) |

## Verdict

Benchmarks posted on the merged swift-foundation PRs show 1 MB encodes 5.8-7x faster and 1 MB decodes 5.2-7.5x faster than the Foundation of the time, and later follow-ups report another 3-4x on encoding and about 2x on decoding. Rejecting invalid input got slower.

**Why tier C:** Measured by the change's author with swift-foundation's benchmark target, but the 2025 posts give no hardware or toolchain.

## Use it when

- Default choice for Base64 once your OS or toolchain includes the rewrite
- Large payloads (images, attachments, JWT bodies) encoded or decoded in bulk

## Skip it when

- Older OS versions without the change keep the old speed
- Workloads dominated by rejecting malformed input: that path measured 3.5x slower

## How it is fast

A Swift encoder and decoder built on precomputed lookup tables (the swift-extras-base64 approach, contributed by the same author) write straight into the output buffer instead of going through the older implementation. The follow-up PRs restructure the loops so the compiler can auto-vectorize them and use Span for input and output.

## What it costs

- Invalid-input rejection is slower than before (2675ns vs 748ns in the decode PR's measurement)

## Problems with the evidence

- Author-measured; the 2025 posts give no hardware or toolchain.
- Which OS release first ships each change is not stated; the October 2026 follow-ups are on main and probably not in a shipping OS yet.
- 'Baseline (in Foundation today)' is the system Foundation the author measured against in February 2025.

## Evidence

<details>
<summary>15 quotes from the sources, checked 2026-10-28</summary>

> Baseline (in Foundation today): 2894μs
>
> — [github.com/swiftlang/swift-foundation/pull/1157](https://github.com/swiftlang/swift-foundation/pull/1157)

> This PR: 494μs (5.8x faster)
>
> — [github.com/swiftlang/swift-foundation/pull/1157](https://github.com/swiftlang/swift-foundation/pull/1157)

> Baseline (in Foundation today): 2915μs
>
> — [github.com/swiftlang/swift-foundation/pull/1157](https://github.com/swiftlang/swift-foundation/pull/1157)

> This PR: 414μs (7x faster)
>
> — [github.com/swiftlang/swift-foundation/pull/1157](https://github.com/swiftlang/swift-foundation/pull/1157)

> Baseline (in Foundation today): 409ns
>
> — [github.com/swiftlang/swift-foundation/pull/1157](https://github.com/swiftlang/swift-foundation/pull/1157)

> This PR: 120ns (3.4x faster)
>
> — [github.com/swiftlang/swift-foundation/pull/1157](https://github.com/swiftlang/swift-foundation/pull/1157)

> Baseline (in Foundation today): 3038μs
>
> — [github.com/swiftlang/swift-foundation/pull/1160](https://github.com/swiftlang/swift-foundation/pull/1160)

> This PR: 405μs (7.5x faster)
>
> — [github.com/swiftlang/swift-foundation/pull/1160](https://github.com/swiftlang/swift-foundation/pull/1160)

> Baseline (in Foundation today): 2123μs
>
> — [github.com/swiftlang/swift-foundation/pull/1160](https://github.com/swiftlang/swift-foundation/pull/1160)

> This PR: 406μs (5.2x faster)
>
> — [github.com/swiftlang/swift-foundation/pull/1160](https://github.com/swiftlang/swift-foundation/pull/1160)

> base64-decode-1MB-fromData-noOptions-invalidAfter257bytes
>
> — [github.com/swiftlang/swift-foundation/pull/1160](https://github.com/swiftlang/swift-foundation/pull/1160)

> Baseline (in Foundation today): 748ns
>
> — [github.com/swiftlang/swift-foundation/pull/1160](https://github.com/swiftlang/swift-foundation/pull/1160)

> This PR: 2675ns (3.5x slower)
>
> — [github.com/swiftlang/swift-foundation/pull/1160](https://github.com/swiftlang/swift-foundation/pull/1160)

> The Base64 encoding logic can be made 3-4 times more performant.
>
> — [github.com/swiftlang/swift-foundation/pull/2236](https://github.com/swiftlang/swift-foundation/pull/2236)

> Generally ~2, but up to 4 times faster decoding for large inputs, per benchmarks.
>
> — [github.com/swiftlang/swift-foundation/pull/2301](https://github.com/swiftlang/swift-foundation/pull/2301)

</details>
