# Linkers

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md)</sub>

**The default:** ld64, and ld-prime since Xcode 15.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**ld-prime (Xcode 15+ linker)**](apple-xcode-ld-prime.md) | Apple's rewritten linker, default since Xcode 15: up to 5x faster than ld64 per Apple, and 4-6x faster than LLD in Chromium's builds. | B | ✅ Holds up |
| [**lld (Mach-O port, ld64.lld)**](llvm-llvm-project-lld-macho.md) | LLVM's Mach-O linker: about 2x faster than Xcode 14's ld64, but slower than Xcode 15's ld-prime on Apple silicon. | B | 🟡 Holds up in part |
| [**zld**](michaeleisel-zld.md) | Archived fork of ld64 that linked about 40% faster in 2020; lld and then Xcode 15's ld-prime overtook it. | C | ❌ Doesn't hold up |
