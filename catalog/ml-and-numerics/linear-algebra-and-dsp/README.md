# Linear algebra and DSP

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [ML and numerics](../README.md)</sub>

**The default:** Plain Swift loops over arrays.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Accelerate (BLAS and LAPACK)**](apple-accelerate-blas.md) | Apple's tuned BLAS and LAPACK; Linpack over 24x faster than untuned code and SGEMM about 2.5x faster than Eigen on iPhone XS. | C | ✅ Holds up |
| [**Matft**](jjjkkkjjj-matft.md) | NumPy-style arrays for Swift on Accelerate; 10-33x faster than NumPy on sin and power, slower on sorting and comparisons. | A | 🟡 Holds up in part |
| [**LASwift**](alexandertar-laswift.md) | Matlab-style vector and matrix library over Accelerate; a 2017 Swift 3 benchmark puts it near NumPy, with no Swift-loop baseline. | B | 🟡 Holds up in part |
| [**Accelerate (vDSP and vForce element-wise math)**](apple-accelerate-vdsp.md) | Apple's vectorized array math; claimed 3-10x over scalar loops, but optimized Swift loops match it on simple element-wise arithmetic. | C | 🟡 Holds up in part |
| [**Surge**](jounce-surge.md) | Swift wrappers over Accelerate's vDSP, vForce and BLAS; claims near-Accelerate speed but publishes no numbers against plain loops. | D | 🟡 Holds up in part |
