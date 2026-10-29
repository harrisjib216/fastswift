# lottie-ios (Core Animation rendering engine)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [UI and rendering](../README.md) › [Animation and vector graphics](README.md)</sub>

**Tier C** (first-party numbers) · 🟡 Holds up in part · Open source · `Swift` · `Apache-2.0` · 🟢 active

> Lottie's default iOS renderer since 4.0: plays animations as CAAnimations in the render server instead of redrawing on the main thread each frame.

| | |
|---|---|
| **Beats** | Lottie's Main Thread rendering engine (the only engine before 3.4.0, default before 4.0) |
| **Claimed result** | Main Thread engine: 'Animations would consume 5-20%+ of the CPU while playing'; Core Animation engine: once playing, 'they do not consume any of the app’s CPU resources'. Counter-report: frames drop to 8-10 fps when setting animations in many table cells while scrolling (Lottie 4.0.1). |
| **Workload** | Playing Lottie animations in an app; no specific animation or device published. |
| **Metric** | CPU usage |
| **Measured** | 2022-07-06 |
| **Adoption** | 26.9k stars |
| **Last commit** | 2026-10-06 |
| **Platforms** | iOS 15+, macOS 10.15+, tvOS 13+, visionOS 1+ |
| **Install** | Swift Package Manager, CocoaPods, Carthage |
| **Links** | [repository](https://github.com/airbnb/lottie-ios) · [benchmark](https://github.com/airbnb/lottie-ios/discussions/1627) |

## Verdict

Moving playback into Core Animation does stop per-frame main-thread work, which Airbnb says cost 5-20%+ CPU. But 'no CPU' is measured in the app process only: the work moves to the system render server. Setting up the layer tree still runs on the main thread, and users report frame drops when many animations are set up while scrolling.

**Why tier C:** First-party release notes and announcement with one approximate CPU range and no device, animation set or method.

## Use it when

- Animations that keep playing while the main thread is busy (launch, loading, onboarding)
- Screens where Lottie's per-frame main-thread cost showed up in Time Profiler

## Skip it when

- Many animations created during fast scrolling, where layer-tree setup on the main thread causes drops
- Animations that use features the engine does not support, which fall back to the Main Thread engine anyway
- Code that needs per-frame value providers or keypath operations the engine does not support

## How it is fast

The Core Animation engine converts the Lottie JSON into a CALayer tree with CAAnimation keyframes once, then hands playback to the system render server. The Main Thread engine instead advanced and re-rendered the animation from a display link on every frame. Unsupported features make the automatic mode fall back to the Main Thread engine.

## What it costs

- Up-front setup cost on the main thread when an animation is assigned.
- Feature coverage is narrower than the Main Thread engine.

## Problems with the evidence

- 'No CPU' refers to the app process; Rive's documentation notes Core Animation work is reported by backboardd, which Xcode does not show by default.
- No device, animation set or measurement method published for the 5-20% figure.
- Airbnb's launch-time experiment is described without numbers in coverage of the 4.0 announcement.

## Evidence

<details>
<summary>6 quotes from the sources, checked 2026-10-28</summary>

> Animations would consume 5-20%+ of the CPU while playing, leaving fewer CPU cycles available for the rest of the application.
>
> — [github.com/airbnb/lottie-ios/discussions/1627](https://github.com/airbnb/lottie-ios/discussions/1627)

> Once animations begin playing, they do not consume any of the app’s CPU resources
>
> — [github.com/airbnb/lottie-ios/discussions/1627](https://github.com/airbnb/lottie-ios/discussions/1627)

> Animations that use features which are not supported by the Core Animation rendering engine will automatically fall back to using the original Main Thread rendering engine.
>
> — [api.github.com/repos/airbnb/lottie-ios/releases/tags/4.0.0](https://api.github.com/repos/airbnb/lottie-ios/releases/tags/4.0.0)

> Frames drop to 8-10 fps if I scroll really fast
>
> — [api.github.com/repos/airbnb/lottie-ios/issues/1885](https://api.github.com/repos/airbnb/lottie-ios/issues/1885)

> Lottie 4.0.1
>
> — [api.github.com/repos/airbnb/lottie-ios/issues/1885](https://api.github.com/repos/airbnb/lottie-ios/issues/1885)

> Other APIs can make use of other system processes, the stats of which will not be immediately visible by Xcode or Instruments.
>
> — [rive.app/docs/runtimes/apple/resource-usage.md](https://rive.app/docs/runtimes/apple/resource-usage.md)

</details>
