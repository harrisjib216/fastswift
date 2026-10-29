# UI and rendering

<sub>[fastswift](../../README.md) › [Catalog](../README.md)</sub>

## [Layout](layout/README.md)

**The default:** Auto Layout, UIStackView and SwiftUI stacks.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Auto Layout (iOS 12 engine)**](layout/apple-uikit-auto-layout.md) | The iOS 12 Auto Layout engine ran 1.22x faster than iOS 11's on the same iPhone 7, narrowing but not closing the gap to frame layout. | A | ✅ Holds up |
| [**LayoutKit**](layout/linkedinattic-layoutkit.md) | LinkedIn's immutable layout engine for UIKit; still about 3.8x faster than Auto Layout in a 2025 run, but archived since 2021. | A | ✅ Holds up |
| [**Texture (ASDisplayNode, ASCollectionNode)**](layout/texturegroup-texture.md) | Node-based UI framework (ex-AsyncDisplayKit) that cut main-thread cell layout time 5.4x vs Auto Layout in an independent 2025 run. | A | ✅ Holds up |
| [**FlexLayout (Yoga flexbox)**](layout/layoutbox-flexlayout.md) | Swift wrapper over Meta's Yoga flexbox engine; about 4x faster than UIStackView on current iPhones in LayoutFrameworkBenchmark. | A | 🟡 Holds up in part |
| [**PinLayout**](layout/layoutbox-pinlayout.md) | Frame-based layout DSL for UIKit that runs about 3x faster than Auto Layout on current iPhones in LayoutFrameworkBenchmark. | A | 🟡 Holds up in part |

## [Lists and scrolling](lists-and-scrolling/README.md)

**The default:** UITableView, UICollectionView, and SwiftUI List or LazyVStack.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**SwiftUI List (macOS 26)**](lists-and-scrolling/apple-swiftui-list.md) | Apple says SwiftUI List on macOS 26 loads 100,000+ item lists 6x faster and updates them up to 16x faster than before. | C | ✅ Holds up |
| [**SwiftUI List (vs ScrollView + LazyVStack)**](lists-and-scrolling/apple-swiftui-list-vs-lazyvstack.md) | In a 1,000-row image stress test on iOS 17.5, SwiftUI List scrolled 9.5x faster than LazyVStack with far fewer hangs. | B | 🟡 Holds up in part |

## [Text rendering](text-rendering/README.md)

**The default:** UILabel, UITextView, TextKit and SwiftUI Text.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**TextKit 2 (NSTextLayoutManager)**](text-rendering/apple-uikit-textkit-2.md) | Apple's viewport-based text engine; pitched as faster than TextKit 1 for large documents, but no published numbers and mixed field reports. | D | 🟡 Holds up in part |

## [Animation and vector graphics](animation-and-vector/README.md)

**The default:** Lottie's main-thread engine and hand-rolled Core Animation.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**lottie-ios (Core Animation rendering engine)**](animation-and-vector/airbnb-lottie-ios-core-animation-engine.md) | Lottie's default iOS renderer since 4.0: plays animations as CAAnimations in the render server instead of redrawing on the main thread each frame. | C | 🟡 Holds up in part |
| [**Rive (rive-ios, vs Lottie)**](animation-and-vector/rive-app-rive-ios.md) | Rive's iOS runtime draws vector animations with Metal; the faster-than-Lottie numbers in circulation come from Android, not iOS. | B | ❌ Doesn't hold up |
