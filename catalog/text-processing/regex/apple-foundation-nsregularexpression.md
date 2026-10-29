# NSRegularExpression (vs Swift Regex)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Text processing](../README.md) › [Regular expressions](README.md)</sub>

**Tier B** (independent measurement) · 🟡 Holds up in part · Ships with Apple's SDKs · `Objective-C (ICU)` · `Apple SDK` · 🟢 active

> Foundation's ICU regex is ~19x cheaper to construct than Swift Regex and avoids some backtracking cliffs; matching is near parity once cached.

| | |
|---|---|
| **Beats** | Swift Regex (Regex literals and Regex(String), Swift 5.7 to 6.3) |
| **Claimed result** | Construction, 10000 times: Swift Regex 0.677 s vs NSRegularExpression 0.036 s (18.8x, derived from page data). Pathological backtracking: Swift 5.7, NSRegularExpression 0.0001s vs Swift Regex 0.25s ('1000x'); Swift 6.1.2 on M3, 9.167 s for one match and 'It is 4x faster to use NSRegularExpression'. swift-format lint of swift-syntax: 47796699574 instructions (static Regex) vs 47465967198 (static NSRegularExpression), 0.7% (derived from page data); Regex rebuilt per file 49422947117. |
| **Workload** | Construction loop of a comment-matching pattern; '^ +A' against 50,000 spaces; '.*\[' against a long run of 'a'; swift-format lint of the swift-syntax repository. |
| **Metric** | time, instructions |
| **Hardware** | Intel iMac (2022 report); Apple M3 (2025 report) |
| **OS** | macOS 15 (2025 report) |
| **Toolchain** | Swift 5.7 (2022); Apple Swift 6.1.2 (2025); release builds for swift-format |
| **Measured** | 2025-06 |
| **Platforms** | iOS 4+, macOS 10.7+, Linux via swift-corelibs-foundation |
| **Install** | built into Foundation |
| **Links** | [documentation](https://developer.apple.com/documentation/foundation/nsregularexpression) · [benchmark](https://github.com/swiftlang/swift-format/pull/968) |

## Verdict

NSRegularExpression is much cheaper to construct (0.036 s vs 0.677 s for 10,000 patterns) and avoids some of Swift Regex's backtracking blow-ups (4x faster in a Swift 6.1.2 report). But with the Regex hoisted to a static, a real linting workload ran within 0.7% of NSRegularExpression. The advantage is mostly construction and pathological patterns, not everyday matching.

**Why tier B:** Independent user measurements in Swift Forums, swift-format and swift-experimental-string-processing issues, with toolchains and some hardware stated; no single controlled suite.

## Use it when

- Patterns built from strings at runtime, especially when created repeatedly
- Patterns that hit Swift Regex's known backtracking problems (issue 483, still open)

## Skip it when

- Regexes created once and reused, where matching cost is close to parity
- Code that needs typed captures, RegexBuilder or Unicode grapheme-correct matching

## How it is fast

NSRegularExpression compiles patterns with ICU's mature C engine and matches over UTF-16. Swift Regex compiles to its own bytecode with grapheme-cluster semantics by default; on one large match benchmark its maintainers found more time going to retain/release, copy-on-write arrays and walking String's higher-level representation than to matching itself.

## What it costs

- Stringly typed patterns and NSRange-based results.
- UTF-16 semantics rather than Character semantics.

## Problems with the evidence

- The 1000x figure is from Swift 5.7 (2022); the tracking issue is still open in 2026 but the case has not been re-measured publicly.
- Swift Regex did get faster: 2023 changes cut some benchmarks by up to 57%, and maintainers measured a further ~1.5x in late 2024, but a forum user found Swift 6.3-dev 'quite the same' on a large match benchmark that remains ~10x slower than Java.
- No public suite compares the two across typical patterns on current toolchains.
- Instruction counts, not wall time, for the swift-format comparison.

## Evidence

<details>
<summary>16 quotes from the sources, checked 2026-10-28</summary>

> func testSwiftRegex() { // 0.677 sec
>
> — [api.github.com/repos/swiftlang/swift-format/issues/comments/2740774112](https://api.github.com/repos/swiftlang/swift-format/issues/comments/2740774112)

> func testNSRegularExpression() { // 0.036 sec
>
> — [api.github.com/repos/swiftlang/swift-format/issues/comments/2740774112](https://api.github.com/repos/swiftlang/swift-format/issues/comments/2740774112)

> for _ in 0..<10000 {
>
> — [api.github.com/repos/swiftlang/swift-format/issues/comments/2740774112](https://api.github.com/repos/swiftlang/swift-format/issues/comments/2740774112)

> - Regex:          49422947117
>
> — [api.github.com/repos/swiftlang/swift-format/pulls/968](https://api.github.com/repos/swiftlang/swift-format/pulls/968)

> - Regex + static: 47796699574
>
> — [api.github.com/repos/swiftlang/swift-format/pulls/968](https://api.github.com/repos/swiftlang/swift-format/pulls/968)

> - NSRegularExpression + static: 47465967198
>
> — [api.github.com/repos/swiftlang/swift-format/pulls/968](https://api.github.com/repos/swiftlang/swift-format/pulls/968)

> Today I tried to use the new Regex from Swift 5.7 to parse CSS variables in a 2000 line CSS file.
>
> — [forums.swift.org/t/performance-of-the-new-regex-in-swift-5-7-degrad…](https://forums.swift.org/t/performance-of-the-new-regex-in-swift-5-7-degrades-quadratically-without-need/58122)

> The old NSRegularExpression class performed the job in 0.0001s on my Intel iMac whereas the new Regex takes 1000x longer, namely 0.25s.
>
> — [forums.swift.org/t/performance-of-the-new-regex-in-swift-5-7-degrad…](https://forums.swift.org/t/performance-of-the-new-regex-in-swift-5-7-degrades-quadratically-without-need/58122)

> // 9.167097091674805 s
>
> — [api.github.com/repos/swiftlang/swift-experimental-string-processing…](https://api.github.com/repos/swiftlang/swift-experimental-string-processing/issues/816)

> It is 4x faster to use `NSRegularExpression`
>
> — [api.github.com/repos/swiftlang/swift-experimental-string-processing…](https://api.github.com/repos/swiftlang/swift-experimental-string-processing/issues/816)

> Apple Swift version 6.1.2
>
> — [api.github.com/repos/swiftlang/swift-experimental-string-processing…](https://api.github.com/repos/swiftlang/swift-experimental-string-processing/issues/816)

> From my tests on M3 CPU
>
> — [api.github.com/repos/swiftlang/swift-experimental-string-processing…](https://api.github.com/repos/swiftlang/swift-experimental-string-processing/issues/816)

> let numberOfSpaces = 50000
>
> — [api.github.com/repos/swiftlang/swift-experimental-string-processing…](https://api.github.com/repos/swiftlang/swift-experimental-string-processing/issues/483)

> Just tried 6.3-dev and it is quite the same as before.
>
> — [forums.swift.org/t/slow-regex-performance/75768](https://forums.swift.org/t/slow-regex-performance/75768)

> still shows a 10x factor between Java and Swift
>
> — [forums.swift.org/t/slow-regex-performance/75768](https://forums.swift.org/t/slow-regex-performance/75768)

> -57.2%
>
> — [api.github.com/repos/swiftlang/swift-experimental-string-processing…](https://api.github.com/repos/swiftlang/swift-experimental-string-processing/pulls/690)

</details>
