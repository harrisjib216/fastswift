# lld (Mach-O port, ld64.lld)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md) › [Linkers](README.md)</sub>

**Tier B** (independent measurement) · 🟡 Holds up in part · Open source · `C++` · `Apache-2.0 WITH LLVM-exception` · 🟢 active

> LLVM's Mach-O linker: about 2x faster than Xcode 14's ld64, but slower than Xcode 15's ld-prime on Apple silicon.

| | |
|---|---|
| **Beats** | ld64 in Xcode 14 and earlier; ld-prime is the default from Xcode 15 |
| **Claimed result** | More than twice as fast as ld64 on large programs (LLVM docs); twice as fast as ld64 linking Chromium Framework, 6x before Xcode 14.1 (Chromium's earlier doc); 20-50% less time than ld64 (Michael Eisel); now slower than ld-prime, which is up to 4-6x faster on arm64 macOS (Chromium's current doc) |
| **Workload** | Linking Chromium Framework in symbol_level=0 release builds; large iOS and macOS debug binaries (Eisel) |
| **Metric** | time |
| **OS** | macOS |
| **Toolchain** | ld64 from Xcode 14.1+ vs LLD shipped with Chromium's clang (2023); ld-prime from Xcode 15+ (2026) |
| **Measured** | 2023-06 |
| **Adoption** | 41.2k stars |
| **Last commit** | 2026-10-27 |
| **Platforms** | macOS and Linux hosts; targets iOS, macOS and other Apple platforms |
| **Install** | LLVM release binaries (bin/ld64.lld), Homebrew llvm; select with -fuse-ld=lld or --ld-path |
| **Links** | [repository](https://github.com/llvm/llvm-project) · [benchmark](https://github.com/chromium/chromium/blob/9d31eda35a6ef73546d8607f2592519efbc6d9b8/docs/mac_lld.md) |

## Verdict

LLD did beat ld64: Chromium measured it twice as fast after Xcode 14.1 and 6x as fast before. Against ld-prime, the default since Xcode 15, Chromium now reports the Apple linker up to 4-6x faster than LLD on arm64 Macs, so the speed case only holds against the old linker.

**Why tier B:** Chromium's docs and Michael Eisel's write-up are outside the LLVM project's own docs, though Chromium engineers are major LLD Mach-O contributors.

## Use it when

- Projects pinned to Xcode 14 or earlier, or still linking with ld64
- Cross-compiling Apple binaries from Linux, or build systems that want compiler and linker at the same LLVM revision for simpler LTO
- Teams that need to patch and ship their own linker rather than wait for Xcode releases (Chromium's stated reason)

## Skip it when

- Xcode 15+ on Apple silicon if link speed is the only goal: ld-prime is faster
- Release builds that rely on ld64-only behavior; see LLVM's ld64-vs-lld differences document

## How it is fast

Unlike zld, which was a fork of ld64, LLD's Mach-O port was written from scratch with speed as a goal. Where ld64 walked every symbol once per pass, LLD folds several passes into one iteration, and it builds on LLVM's tuned data structures. Facebook and Google engineers pushed it to production quality around 2021-2022.

## What it costs

- Behavior can differ from Apple's linker in edge cases
- Mixing LLD with a different LLVM version than Xcode's clang can cause LTO problems

## Problems with the evidence

- The 2x and 6x figures come from a June 2023 Chromium doc revision and predate the ld-prime comparison
- Chromium engineers are among LLD's main Mach-O contributors, so the Chromium numbers are not fully independent
- None of the sources give raw timings or hardware; LLVM's 'more than twice as fast' names no workload
- Eisel's post was later updated to say lld is no longer necessarily the fastest option after ld-prime

## Evidence

<details>
<summary>7 quotes from the sources, checked 2026-10-28</summary>

> When you link a large program on a multicore machine, you can expect that LLD runs more than twice as fast as the ld64 linker.
>
> — [github.com/llvm/llvm-project/blob/main/lld/docs/MachO/index.md](https://github.com/llvm/llvm-project/blob/main/lld/docs/MachO/index.md)

> LLD is currently twice as fast as ld64, the macOS system linker, at linking
>
> — [github.com/chromium/chromium/blob/9d31eda35a6ef73546d8607f2592519ef…](https://github.com/chromium/chromium/blob/9d31eda35a6ef73546d8607f2592519efbc6d9b8/docs/mac_lld.md)

> (Before Xcode 14.1, LLD was 6x as fast as ld64.)
>
> — [github.com/chromium/chromium/blob/9d31eda35a6ef73546d8607f2592519ef…](https://github.com/chromium/chromium/blob/9d31eda35a6ef73546d8607f2592519efbc6d9b8/docs/mac_lld.md)

> It takes 20-50% less time than ld64 and is now used by many large companies.
>
> — [eisel.me/lld](https://eisel.me/lld)

> Update: with the release of ld-prime, the new default linker, lld is no longer necessarily the fastest option
>
> — [eisel.me/lld](https://eisel.me/lld)

> lld was written from scratch with speed as a top priority
>
> — [eisel.me/lld](https://eisel.me/lld)

> Supported only for local non-cross arm64 macOS builds (ARM Mac) to improve link speed (yielding up to a 4-6x speedup depending on configuration).
>
> — [github.com/chromium/chromium/blob/13b8fd8fc88ffeea53b0ae5d07d82c5cf…](https://github.com/chromium/chromium/blob/13b8fd8fc88ffeea53b0ae5d07d82c5cfd2f03df/docs/apple_platform_linkers.md)

</details>
