# llama.cpp (Metal backend on Apple silicon)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [ML and numerics](../README.md) › [On-device inference](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Open source · `C++` · `MIT` · 🟢 active

> C/C++ LLM runtime with a Metal backend; beats Core ML's Neural Engine path on burst decode but trails MLX Swift on Apple silicon.

| | |
|---|---|
| **Beats** | Core ML LLM conversions running on the Neural Engine (CoreML-LLM) |
| **Claimed result** | iPhone 17 Pro, Qwen 3.5 2B: 39.1 vs 27.9 tok/s over Core ML/ANE (Debug builds); slower than MLX Swift elsewhere: 38.8 vs 49.1 tok/s (Gemma 4 E2B, iPhone 17 Pro), 127.1 vs 177.8 tok/s (Gemma 4 E2B, M4 Max), 86.2 vs 159.7 tok/s (Nemotron-3 Nano 30B-A3B, M4 Max); 0.483 J/tok on iPhone, the highest of all runtimes |
| **Workload** | Batch-1 greedy decoding of Q4_K_M GGUF models: 128-token short-chat on iPhone, llama-bench tg256 after a pp512 prompt for the hybrid models on M4 Max, 600-second sustained run for energy. |
| **Metric** | throughput (decode tokens/s) |
| **Hardware** | iPhone 17 Pro (A19 Pro); Apple M4 Max |
| **OS** | iOS 26.4.2 (Qwen 3.5 2B cells); iOS 27 beta; macOS 27 beta |
| **Toolchain** | llama.cpp Homebrew build 8680 (commit 15f786e65) for the M4 Max hybrid runs |
| **Measured** | 2026-09-04 |
| **Adoption** | 132.7k stars |
| **Last commit** | 2026-10-28 |
| **Platforms** | macOS, iOS, Linux, Windows, Android |
| **Install** | Homebrew, CMake source build, XCFramework for Apple apps |
| **Links** | [repository](https://github.com/ggml-org/llama.cpp) · [benchmark](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md) |

## Verdict

llama.cpp out-decodes the Core ML Neural Engine path in the one same-table comparison, but those cells are Debug builds. In release-build cells of the same harness it trails MLX Swift on every row, at roughly half MLX's speed on hybrid Mamba-2 models, and it used the most energy per token on the phone.

**Why tier A:** Third-party harness with public code; llama.cpp build number and commit, devices and quantization are stated.

## Use it when

- You need one runtime across Apple platforms, Linux, Windows and Android
- The model only exists as a GGUF file
- Low charged memory footprint matters more than tokens per second (weights are mmap'd)

## Skip it when

- Peak decode speed on Apple silicon: MLX Swift was faster on every row of the same harness
- Battery-sensitive iPhone apps: it drew the most energy per token and kept the least of its burst rate under sustained load
- Google's official Gemma 4 QAT GGUF, which failed to load in this harness

## How it is fast

llama.cpp runs GGUF models through hand-written Metal kernels for quantized matrix-vector products, with k-quant formats such as Q4_K_M that cut memory traffic per token. Weights are memory-mapped, so loading is fast and clean pages are not charged to the app's footprint.

## What it costs

- Mmap'd weights hide about 2.9 GB of resident memory behind a 191 MB charged footprint on iPhone
- C API; Swift apps need a wrapper or the XCFramework

## Problems with the evidence

- The only direct Core ML comparison uses Debug-build captures, which the harness's own rules flag
- Quantization differs between columns (Q4_K_M vs MLX 4-bit affine)
- llama.cpp's own Apple silicon table (discussion #4167) gives absolute llama-bench numbers per chip with no Core ML or MLX baseline
- iOS 27 and macOS 27 betas for the newer cells

## Evidence

<details>
<summary>10 quotes from the sources, checked 2026-10-28</summary>

> ### Qwen 3.5 2B (pre-refresh cells — Debug builds, iOS 26.4.2, 2026-05-28)
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> | 🔵 llama.cpp | 39.1 | 1,479 |
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> | 🟠 CoreML/ANE | 27.9 | **241** 🏆 |
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> | 🔵 llama.cpp | Q4_K_M (PTQ) | 38.8 (7/27, n=10) | 24.4 ms (7/27) | 191 † | 76.0% | 0.260 ◊ |
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> | 🟣 MLX-Swift | PTQ 4-bit | 49.1 (A2 7/28, n=6) | 20.5 ms | 3,010 | 84.0% | 0.182 ◊ |
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> | 🟣 MLX PTQ 4-bit | **0.090** 🏆 | 14.6 | **177.8** 🏆 |
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> | 🔵 llama.cpp Q4_K_M | 0.170 | 20.5 | 127.1 |
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> | NVIDIA Nemotron-3 Nano 30B-A3B | Apple M4 Max | 159.7 | 86.2 | 2026-09-04 |
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> NVIDIA Nemotron-3 Nano 30B-A3B · llama.cpp: unsloth/Nemotron-3-Nano-30B-A3B-GGUF Q4_K_M (Homebrew build 8680, commit 15f786e65; tg256 mean of 3 (±0.47))
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> **llama.cpp is the energy floor at 0.483 J/tok**
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

</details>
