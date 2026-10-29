# Build and tooling

<sub>[fastswift](../../README.md) › [Catalog](../README.md)</sub>

## [Build systems and caching](build-and-caching/README.md)

**The default:** xcodebuild with no cache.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Tuist (module cache)**](build-and-caching/tuist-tuist.md) | Xcode project generator whose module cache swaps unchanged targets for prebuilt binaries, cutting clean builds 2-3x in its benchmarks. | A | ✅ Holds up |
| [**Xcode compilation cache (COMPILATION_CACHE_ENABLE_CACHING, Xcode 26)**](build-and-caching/apple-xcode-compilation-cache.md) | Xcode 26's opt-in content-addressed compilation cache; Tuist measured 18-77% shorter clean builds once the cache is warm. | A | ✅ Holds up |
| [**SwiftPM prebuilt swift-syntax for macros**](build-and-caching/swiftlang-swift-package-manager-swift-syntax-prebuilts.md) | SwiftPM downloads a release-built swift-syntax for macros instead of compiling it, cutting minutes from clean builds. | B | ✅ Holds up |
| [**Bazel (with rules_swift, rules_apple and rules_xcodeproj)**](build-and-caching/bazelbuild-bazel.md) | Google's build system with Swift and Apple rules; Spotify cut iOS CI waits 4x, mostly through remote caching and remote execution. | B | 🟡 Holds up in part |
| [**Explicitly built modules (Xcode 16+)**](build-and-caching/apple-xcode-explicitly-built-modules.md) | Xcode 16's explicit module builds: faster LLDB startup is measured, but independent tests found clean builds slower. | B | 🟡 Holds up in part |
| [**XCRemoteCache**](build-and-caching/spotify-xcremotecache.md) | Spotify's remote cache for Xcode builds; cut median clean builds 70% at Spotify, but needs old driver settings and has stalled. | C | 🟡 Holds up in part |

## [Linkers](linkers/README.md)

**The default:** ld64, and ld-prime since Xcode 15.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**ld-prime (Xcode 15+ linker)**](linkers/apple-xcode-ld-prime.md) | Apple's rewritten linker, default since Xcode 15: up to 5x faster than ld64 per Apple, and 4-6x faster than LLD in Chromium's builds. | B | ✅ Holds up |
| [**lld (Mach-O port, ld64.lld)**](linkers/llvm-llvm-project-lld-macho.md) | LLVM's Mach-O linker: about 2x faster than Xcode 14's ld64, but slower than Xcode 15's ld-prime on Apple silicon. | B | 🟡 Holds up in part |
| [**zld**](linkers/michaeleisel-zld.md) | Archived fork of ld64 that linked about 40% faster in 2020; lld and then Xcode 15's ld-prime overtook it. | C | ❌ Doesn't hold up |

## [Developer tools](developer-tools/README.md)

**The default:** xcpretty and the usual formatters and linters.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**SwiftLint (SwiftSyntax-based rules)**](developer-tools/realm-swiftlint.md) | The standard Swift linter; rewriting rules on SwiftSyntax made them 7-10x faster and whole runs 6-30% faster per release. | C | ✅ Holds up |
| [**xcodes (aria2 downloads)**](developer-tools/xcodesorg-xcodes.md) | Command-line Xcode installer that downloads over up to 16 connections with aria2, claimed 3-5x faster than URLSession. | C | ✅ Holds up |
| [**SwiftFormat**](developer-tools/nicklockwood-swiftformat.md) | Swift code formatter with its own tokenizer; timed 8x faster than swift-format on one small file in 2019, unmeasured since. | B | 🟡 Holds up in part |
| [**unxip**](developer-tools/saagarjha-unxip.md) | Swift tool that extracts Xcode .xip files about 2-3x faster than xip(1) and Archive Utility, per its author. | C | 🟡 Holds up in part |
| [**xcbeautify**](developer-tools/cpisciotta-xcbeautify.md) | Swift replacement for xcpretty that formats xcodebuild output; claimed 2x faster, but never published a benchmark. | D | 🟡 Holds up in part |
