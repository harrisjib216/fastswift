# Diffing

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Collections](../README.md)</sub>

**The default:** The standard library's difference(from:), reloadData, and diffable data sources.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**IGListKit (IGListDiff)**](instagram-iglistkit.md) | Instagram's list framework with a linear-time Heckel diff, measured 1.8-7.2x faster than the standard library's difference(from:). | B | ✅ Holds up |
| [**DifferenceKit**](ra1028-differencekit.md) | Linear-time Heckel diff for table and collection views, measured 33-144x faster than the standard library's difference(from:). | C | ✅ Holds up |
| [**DeepDiff**](onmyway133-deepdiff.md) | Heckel-based Swift diff for table and collection views; faster than Myers libraries, but its own benchmark overstates the gap. | C | 🟡 Holds up in part |
| [**Differ**](tonyarnold-differ.md) | Myers O((N+M)D) diff with UIKit helpers; its speed claim is against early Dwifft, and the stdlib diff now beats it. | C | ❌ Doesn't hold up |
| [**Dwifft**](jflinter-dwifft.md) | LCS-based diff with UIKit bindings; claims speed with no numbers and measured 7.6x slower than the stdlib diff. | D | ❌ Doesn't hold up |
