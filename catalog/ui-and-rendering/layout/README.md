# Layout

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [UI and rendering](../README.md)</sub>

**The default:** Auto Layout, UIStackView and SwiftUI stacks.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Auto Layout (iOS 12 engine)**](apple-uikit-auto-layout.md) | The iOS 12 Auto Layout engine ran 1.22x faster than iOS 11's on the same iPhone 7, narrowing but not closing the gap to frame layout. | A | ✅ Holds up |
| [**LayoutKit**](linkedinattic-layoutkit.md) | LinkedIn's immutable layout engine for UIKit; still about 3.8x faster than Auto Layout in a 2025 run, but archived since 2021. | A | ✅ Holds up |
| [**Texture (ASDisplayNode, ASCollectionNode)**](texturegroup-texture.md) | Node-based UI framework (ex-AsyncDisplayKit) that cut main-thread cell layout time 5.4x vs Auto Layout in an independent 2025 run. | A | ✅ Holds up |
| [**FlexLayout (Yoga flexbox)**](layoutbox-flexlayout.md) | Swift wrapper over Meta's Yoga flexbox engine; about 4x faster than UIStackView on current iPhones in LayoutFrameworkBenchmark. | A | 🟡 Holds up in part |
| [**PinLayout**](layoutbox-pinlayout.md) | Frame-based layout DSL for UIKit that runs about 3x faster than Auto Layout on current iPhones in LayoutFrameworkBenchmark. | A | 🟡 Holds up in part |
