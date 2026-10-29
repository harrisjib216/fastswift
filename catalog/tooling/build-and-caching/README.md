# Build systems and caching

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md)</sub>

**The default:** xcodebuild with no cache.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Tuist (module cache)**](tuist-tuist.md) | Xcode project generator whose module cache swaps unchanged targets for prebuilt binaries, cutting clean builds 2-3x in its benchmarks. | A | ✅ Holds up |
| [**Xcode compilation cache (COMPILATION_CACHE_ENABLE_CACHING, Xcode 26)**](apple-xcode-compilation-cache.md) | Xcode 26's opt-in content-addressed compilation cache; Tuist measured 18-77% shorter clean builds once the cache is warm. | A | ✅ Holds up |
| [**SwiftPM prebuilt swift-syntax for macros**](swiftlang-swift-package-manager-swift-syntax-prebuilts.md) | SwiftPM downloads a release-built swift-syntax for macros instead of compiling it, cutting minutes from clean builds. | B | ✅ Holds up |
| [**Bazel (with rules_swift, rules_apple and rules_xcodeproj)**](bazelbuild-bazel.md) | Google's build system with Swift and Apple rules; Spotify cut iOS CI waits 4x, mostly through remote caching and remote execution. | B | 🟡 Holds up in part |
| [**Explicitly built modules (Xcode 16+)**](apple-xcode-explicitly-built-modules.md) | Xcode 16's explicit module builds: faster LLDB startup is measured, but independent tests found clean builds slower. | B | 🟡 Holds up in part |
| [**XCRemoteCache**](spotify-xcremotecache.md) | Spotify's remote cache for Xcode builds; cut median clean builds 70% at Spotify, but needs old driver settings and has stalled. | C | 🟡 Holds up in part |
