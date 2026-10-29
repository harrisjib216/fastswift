# Animation and vector graphics

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [UI and rendering](../README.md)</sub>

**The default:** Lottie's main-thread engine and hand-rolled Core Animation.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**lottie-ios (Core Animation rendering engine)**](airbnb-lottie-ios-core-animation-engine.md) | Lottie's default iOS renderer since 4.0: plays animations as CAAnimations in the render server instead of redrawing on the main thread each frame. | C | 🟡 Holds up in part |
| [**Rive (rive-ios, vs Lottie)**](rive-app-rive-ios.md) | Rive's iOS runtime draws vector animations with Metal; the faster-than-Lottie numbers in circulation come from Android, not iOS. | B | ❌ Doesn't hold up |
