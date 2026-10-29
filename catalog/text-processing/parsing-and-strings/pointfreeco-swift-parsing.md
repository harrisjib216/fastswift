# swift-parsing (UTF8View parsers vs Scanner)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Text processing](../README.md) › [Parsing and strings](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Open source · `Swift` · `MIT` · 🟢 active

> Composable parser library; its UTF-8 parsers beat Foundation Scanner 3x-9x, but Substring parsers do not beat hand-written split code.

| | |
|---|---|
| **Beats** | Foundation Scanner and hand-written String.split parsing |
| **Claimed result** | M1 Pro: README example, Scanner 12084 ns vs UTF8 parser 1291 ns (9.4x, derived from page data) and Substring parser 2834 ns (4.3x, derived from page data); ad hoc split 2459 ns. Comma-separated Ints: Scanner 50654458.5 ns vs Int.parser 15364583 ns (3.3x, derived from page data) vs String.split 15452542 ns. PrefixUpTo: UTF8 40417 ns vs String.range(of:) 49792 ns vs Scanner 53959 ns. README prose claims Scanner is 'more than 5 times' slower than the Substring parser and 'more than 15 times' slower than the UTF-8 parser. |
| **Workload** | Small CSV-like user records; long comma-separated lists of Int and Double; prefix search; Bool parsing. |
| **Metric** | time |
| **Hardware** | MacBook Pro (16-inch, 2021), Apple M1 Pro, 32 GB |
| **Toolchain** | swift run -c release (Makefile); Swift version not stated, table updated in the Swift 5.8 support commit |
| **Measured** | 2023-03 |
| **Adoption** | 1.0k stars |
| **Last commit** | 2026-09-02 |
| **Platforms** | iOS 13+, macOS 10.15+, tvOS 13+, watchOS 6+, Linux |
| **Install** | Swift Package Manager |
| **Links** | [repository](https://github.com/pointfreeco/swift-parsing) · [benchmark](https://github.com/pointfreeco/swift-parsing#benchmarks) |

## Verdict

Against Scanner the claim holds: the UTF-8 parser is 9.4x faster on the README example and 3.3x faster on comma-separated integers. Against hand-written split code it does not hold at the Substring level: the README's own current table shows ad hoc split parsing (2,459 ns) beating the Substring parser (2,834 ns), contradicting its 'more than twice as slow' text, and split matches the Int parser on bulk numbers.

**Why tier A:** Public benchmark executable (make benchmarks runs swift run -c release), hardware stated in the README; Swift version not stated.

## Use it when

- Replacing Scanner-based parsers in hot paths
- Formats you can parse at the UTF-8 byte level and that benefit from composable, testable parsers

## Skip it when

- Simple delimiter splitting, where String.split is as fast or faster
- JSON: the same table shows its JSON parser 21x slower than JSONSerialization (38,167 ns vs 1,792 ns)
- Debug builds, where generic composition is far slower

## How it is fast

Parsers are generic over the input view, so a parser can run directly on Substring.UTF8View bytes instead of Characters, avoiding grapheme breaking. Small parsers compose into one specialized type that the optimizer inlines. Scanner bridges to NSString and works through a heavier object API.

## What it costs

- Heavy use of generics and result builders can lengthen compile times.
- Byte-level parsers need care with non-ASCII input.

## Problems with the evidence

- Table rows were updated at different times (most in March 2023; the Date row in July 2023), so they are not one run.
- Swift version and macOS version not stated; numbers predate Swift 5.9 and the 2023 Swift Foundation rewrite.
- The prose ratios in the README (5x, 15x, 'twice as slow') come from an older run and do not match the current table.

## Evidence

<details>
<summary>18 quotes from the sources, checked 2026-10-28</summary>

> Apple M1 Pro (10 cores, 8 performance and 2 efficiency)
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> MacBook Pro (16-inch, 2021)
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> 32 GB (LPDDR5)
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> README Example.Parser: Substring                 2834.000 ns ±  12.87 %     488264
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> README Example.Parser: UTF8                      1291.000 ns ±  22.65 %    1000000
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> README Example.Ad hoc                            2459.000 ns ±  20.61 %     561930
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> README Example.Scanner                          12084.000 ns ±   5.53 %     115388
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> Numerics.Comma separated: Int.parser         15364583.000 ns ±   0.63 %         91
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> Numerics.Comma separated: Scanner.scanInt    50654458.500 ns ±   0.30 %         28
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> Numerics.Comma separated: String.split       15452542.000 ns ±   1.30 %         90
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> PrefixUpTo.Parser: UTF8                         40417.000 ns ±   2.71 %      34379
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> PrefixUpTo.String.range(of:)                    49792.000 ns ±   2.70 %      27891
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> PrefixUpTo.Scanner.scanUpToString               53959.000 ns ±   3.87 %      25745
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> JSON.Parser                                     38167.000 ns ±   3.26 %      36423
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> JSON.JSONSerialization                           1792.000 ns ±  54.14 %     753770
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> the `.split`-style of parsing is more than twice as slow
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> However, the `Scanner` style of parsing is more than 5 times as slow as the substring parser written above, and more than 15 times slower than the UTF-8 parser:
>
> — [github.com/pointfreeco/swift-parsing/blob/main/README.md](https://github.com/pointfreeco/swift-parsing/blob/main/README.md)

> swift run -c release swift-parsing-benchmark
>
> — [github.com/pointfreeco/swift-parsing/blob/main/Makefile](https://github.com/pointfreeco/swift-parsing/blob/main/Makefile)

</details>
