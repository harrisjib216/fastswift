# Rive (rive-ios, vs Lottie)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [UI and rendering](../README.md) › [Animation and vector graphics](README.md)</sub>

**Tier B** (independent measurement) · ❌ Doesn't hold up · Open source · `Swift + C++` · `MIT` · 🟢 active

> Rive's iOS runtime draws vector animations with Metal; the faster-than-Lottie numbers in circulation come from Android, not iOS.

| | |
|---|---|
| **Beats** | lottie-ios with its Core Animation rendering engine (the iOS default since Lottie 4.0) |
| **Claimed result** | Callstack, Android: Rive almost 60 FPS vs Lottie 17 FPS; total memory Lottie 246 MB vs Rive 276 MB (Rive used more). No iOS numbers. |
| **Workload** | Same onboarding animation exported for Lottie and Rive, played in a React Native app with dev mode off. |
| **Metric** | FPS, memory |
| **Hardware** | Sony Xperia Z3 (Android) |
| **OS** | Android (version not stated) |
| **Toolchain** | React Native, dev mode disabled |
| **Measured** | 2023-01-11 |
| **Adoption** | 855 stars |
| **Last commit** | 2026-10-28 |
| **Platforms** | iOS 14+, macOS 13.1+, tvOS 16+, visionOS 1+, Mac Catalyst 14+ |
| **Install** | Swift Package Manager, CocoaPods |
| **Links** | [repository](https://github.com/rive-app/rive-ios) · [benchmark](https://callstack.com/blog/lottie-vs-rive-optimizing-mobile-app-animation) |

## Verdict

The widely cited numbers (Rive near 60 FPS vs Lottie at 17 FPS) come from a React Native app on a 2014 Android phone, not from lottie-ios. In the same test Rive used more total memory. Rive's own Apple documentation warns that app-only profiling is not a fair comparison against Core Animation-based Lottie. No iOS speed comparison was found.

**Why tier B:** Third-party (Callstack) benchmark with numbers and a named device, but on Android through React Native.

## Use it when

- Interactive, state-machine-driven animations that Lottie cannot express
- Reducing animation asset size, which Rive's blog says is often 10-15x smaller than Lottie JSON

## Skip it when

- Choosing Rive over lottie-ios for speed on iOS without measuring app plus backboardd on target devices

## How it is fast

Rive files are a compact binary format played by a C++ runtime that renders with Metal inside the app process. Lottie on iOS instead builds Core Animation layers that the system render server plays, so the costs land in different processes and are hard to compare.

## What it costs

- Metal rendering and memory appear in the app process.
- Requires the Rive editor and file format instead of After Effects exports.

## Problems with the evidence

- Numbers are from Android through React Native on a 2014 phone and use Lottie's Android player.
- On iOS, Lottie's Core Animation engine shows near 0% CPU in the app process because playback runs in the render server.
- Rive's blog comparison is first-party and discusses file size, not iOS frame times.

## Evidence

<details>
<summary>6 quotes from the sources, checked 2026-10-28</summary>

> The results show that the Rive animation runs almost at 60FPS whereas Lottie runs at 17FPS.
>
> — [callstack.com/blog/lottie-vs-rive-optimizing-mobile-app-animation](https://callstack.com/blog/lottie-vs-rive-optimizing-mobile-app-animation)

> The total memory consumption of Lottie is 246 MB and Rive is 276 MB.
>
> — [callstack.com/blog/lottie-vs-rive-optimizing-mobile-app-animation](https://callstack.com/blog/lottie-vs-rive-optimizing-mobile-app-animation)

> We benchmarked this on a Sony Xperia Z3 model using an Android profiler and Perf monitor that is shipped with the React Native app.
>
> — [callstack.com/blog/lottie-vs-rive-optimizing-mobile-app-animation](https://callstack.com/blog/lottie-vs-rive-optimizing-mobile-app-animation)

> Since Rive uses Metal directly, CPU usage and memory allocations appear in the app process.
>
> — [rive.app/docs/runtimes/apple/resource-usage.md](https://rive.app/docs/runtimes/apple/resource-usage.md)

> CPU usage often shows as 0% in profiling tools because it offloads animation playback to the render server, a separate system process.
>
> — [rive.app/blog/rive-as-a-lottie-alternative](https://rive.app/blog/rive-as-a-lottie-alternative)

> Rive files are often 10 to 15 times smaller than equivalent Lottie JSON files.
>
> — [rive.app/blog/rive-as-a-lottie-alternative](https://rive.app/blog/rive-as-a-lottie-alternative)

</details>
