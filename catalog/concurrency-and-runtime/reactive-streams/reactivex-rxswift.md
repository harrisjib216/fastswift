# RxSwift

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Concurrency and runtime](../README.md) › [Reactive streams](README.md)</sub>

**Tier B** (independent measurement) · ❌ Doesn't hold up · Open source · `Swift` · `MIT` · 🟢 active

> Reactive Extensions for Swift; slower than Combine in 10 of 11 published operator benchmarks, so speed is not a reason to pick it.

| | |
|---|---|
| **Beats** | Apple Combine (PassthroughSubject, map/filter, flatMap, combineLatest) |
| **Claimed result** | RxSwift slower than Combine in 10 of 11 tests (count derived from page data): PublishSubjectPumping 227 ms vs 135 ms, FlatMapsPumping 646 ms vs 367 ms; RxSwift faster only on MapFilterPumping, 123 ms vs 132 ms |
| **Workload** | RxSwift's own Benchmarks.swift tests translated 1:1 to Combine: subject pumping, map/filter, flatMap, flatMapLatest and combineLatest chains, each for both creation and value pumping, timed with XCTest measure |
| **Metric** | time |
| **Hardware** | MacBook Pro 2018, 2.7 GHz Intel Core i7, 16 GB, running the iPhone XR Simulator |
| **Toolchain** | Xcode 11.0 beta 5 (11M382q); release build |
| **Measured** | 2019-08 |
| **Adoption** | 24.6k stars |
| **Last commit** | 2026-09-04 |
| **Platforms** | iOS 9+, macOS 10.10+, tvOS 9+, watchOS 3+, Linux |
| **Install** | Swift Package Manager, CocoaPods, Carthage |
| **Links** | [repository](https://github.com/ReactiveX/RxSwift) · [benchmark](https://github.com/quickbirdstudios/CombineRxSwiftPerformance) |

## Verdict

In the only published operator-by-operator comparison, Combine was faster than RxSwift in 10 of 11 tests in release builds; RxSwift won only MapFilterPumping, by 7%. An independent reviewer put the release-build difference at small, with each framework faster in some cases.

**Why tier B:** Third-party benchmark (neither RxSwift nor Apple) with public test code, but measured in the iOS Simulator under an Xcode beta.

## Use it when

- Supporting OS versions before iOS 13 / macOS 10.15, where Combine does not exist
- Linux targets, where Combine is unavailable
- An existing RxSwift codebase or a need for operators Combine lacks

## Skip it when

- Choosing it for performance over Combine; the published numbers point the other way
- New code that can use Combine or Swift concurrency (AsyncSequence)

## How it is fast

It is not faster. RxSwift passes every event through class-based observers and disposables, so each operator stage adds reference counting and dynamic dispatch. Combine's publishers are generic value types that the compiler can specialize, which removes some of that per-event overhead.

## What it costs

- Adds a third-party dependency of several modules (RxSwift, RxCocoa, RxRelay)
- Larger binary than using the system Combine framework

## Problems with the evidence

- Run in the iOS Simulator, where Apple engineers note system components may use untuned implementations
- Xcode 11 beta 5 and Combine from 2019; neither framework has been re-measured since
- The first published numbers were from debug builds; the README was later updated to release builds, which shrank the gap
- The README says Combine 'was faster in every test', but its own table shows RxSwift ahead on MapFilterPumping
- Matt Gallagher noted that subscription setup inside the measure block dominates several tests and that he had cases where RxSwift was 3 times faster

## Evidence

<details>
<summary>7 quotes from the sources, checked 2026-10-28</summary>

> **PublishSubjectPumping** | 227 | 135 | 168%
>
> — [github.com/quickbirdstudios/CombineRxSwiftPerformance](https://github.com/quickbirdstudios/CombineRxSwiftPerformance)

> **MapFilterPumping** | 123 | 132 | 93%
>
> — [github.com/quickbirdstudios/CombineRxSwiftPerformance](https://github.com/quickbirdstudios/CombineRxSwiftPerformance)

> **FlatMapsPumping** | 646 | 367 | 176%
>
> — [github.com/quickbirdstudios/CombineRxSwiftPerformance](https://github.com/quickbirdstudios/CombineRxSwiftPerformance)

> We have updated all the numbers and graphs to use release builds.
>
> — [github.com/quickbirdstudios/CombineRxSwiftPerformance](https://github.com/quickbirdstudios/CombineRxSwiftPerformance)

> **Testing Device**: iPhone XR Simulator
>
> — [github.com/quickbirdstudios/CombineRxSwiftPerformance](https://github.com/quickbirdstudios/CombineRxSwiftPerformance)

> Built in Release, those tests show Combine to be slightly faster than RxSwift but not by much.
>
> — [mjtsai.com/blog/2019/08/05/performance-of-combine/](https://mjtsai.com/blog/2019/08/05/performance-of-combine/)

> I have test cases where RxSwift is 3 times faster. I have test cases where Combine is 5 times faster.
>
> — [mjtsai.com/blog/2019/08/05/performance-of-combine/](https://mjtsai.com/blog/2019/08/05/performance-of-combine/)

</details>
