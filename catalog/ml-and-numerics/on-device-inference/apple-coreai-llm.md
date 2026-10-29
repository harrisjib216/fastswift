# Core AI (LLM runtime, Core ML successor)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [ML and numerics](../README.md) › [On-device inference](README.md)</sub>

**Tier A** (reproducible public benchmark) · 🟡 Holds up in part · Ships with Apple's SDKs · `Swift` · `Apple SDK` · 🟢 active

> Apple's Core ML successor in iOS 27/macOS 27; decodes LLMs several times faster than Core ML conversions and ties MLX on dense models.

| | |
|---|---|
| **Beats** | Core ML LLM conversions on the Neural Engine (CoreML-LLM), and MLX Swift as the fastest third-party alternative |
| **Claimed result** | iPhone 17 Pro, Qwen3-0.6B: 193.3 tok/s cold vs 37.7 for Core ML (different sessions); M4 Max vs MLX: 1,121 vs 455 tok/s (2.47×) with the macOS-26 export, ~500 vs 455 (1.1×) after re-export, Qwen3-8B 94 vs 90 (1.05×), gpt-oss-20b MoE 78.1 vs 100.2 (MLX +28%); same recipe gives a 2.2× slower artifact after the macOS 27 beta upgrade |
| **Workload** | Batch-1 greedy decoding of 4-bit Qwen3 0.6B to 8B, Gemma and Mistral models: 128-token short-chat on iPhone, 512-token prompt and 1024 generated tokens on Mac. |
| **Metric** | throughput (decode tokens/s) |
| **Hardware** | iPhone 17 Pro (A19 Pro); Mac Studio (M4 Max) |
| **OS** | iOS 27 beta; macOS 26 and macOS 27 beta |
| **Toolchain** | coreai.llm.export and coreai-build from Apple's coreai-torch; mlx-lm 0.31.3 for the MLX column |
| **Measured** | 2026-06-18 |
| **Platforms** | iOS 27+, macOS 27+ |
| **Install** | built into iOS 27 and macOS 27 |
| **Links** | [documentation](https://developer.apple.com/documentation/coreai) · [benchmark](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md) |

## Verdict

Core AI's GPU engine decoded several times faster than the Core ML Neural Engine conversion on iPhone 17 Pro. Its headline 2.47x lead over MLX holds only for a 0.6B model built with one export toolchain. After re-export it is 1.1x, at 8B it is a near tie, and MLX wins the MoE model by 28%.

**Why tier A:** Third-party harness with public code, raw logs and environment pins; Core AI cells use Apple's own llm-benchmark release build.

## Use it when

- New apps targeting iOS 27 / macOS 27 that would otherwise ship a Core ML LLM conversion
- Small dense models where dispatch overhead dominates and the pipelined GPU engine has its largest lead
- You want Apple's first-party runtime without bundling MLX

## Skip it when

- Apps that must run on iOS 26 or earlier
- Mixture-of-experts models, where MLX was 28% faster
- Long contexts on iPhone: the harness hit an iOS KV cap of 1,024 and jetsams under its deep protocol

## How it is fast

PyTorch models are exported with coreai-torch into .aimodel bundles. A dynamic-shape export runs on a pipelined GPU engine that overlaps dispatch with compute, which matters most for small models. A static-shape export targets the Neural Engine. On iOS the bundle is compiled ahead of time for the specific GPU architecture.

## What it costs

- The compute unit is fixed by the export shape, not chosen at runtime
- iOS bundles must be compiled ahead of time per GPU architecture
- The Neural Engine path used about 1.2 GB on iPhone, several times the Core ML conversion's footprint

## Problems with the evidence

- All measurements on beta OS releases from June to September 2026
- Results depend on the export environment: the same recipe produced a 2.2x slower artifact after a macOS 27 beta upgrade
- The iPhone Core AI vs Core ML cells come from sessions a day apart, which the README says should not be turned into ratios
- Warm re-capture of the 0.6B iPhone bundles was blocked by a coreai-build regression in July
- Single third-party harness; no Apple-published performance numbers were checked

## Evidence

<details>
<summary>8 quotes from the sources, checked 2026-10-28</summary>

> | **Core AI** (pipelined) | GPU | **193.3** 🏆 _(first-ever 76.5)_ | blocked† | 196 MB | 2026-06-18 |
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> | **CoreML-LLM** | ANE | 37.7 | pending‡ | **184** 🏆 | 2026-06-17 |
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> | Qwen3-0.6B (macOS-26 export) | 1,121 | 455 | **2.47×** |
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> | Qwen3-0.6B (macOS-27β re-export) | ~500 | 455 | **1.1×** |
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> | Qwen3-8B | 94 | 90 | **1.05×** |
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> | gpt-oss-20b (MoE, MXFP4) | 13 GB | 78.1 (1,252) | **100.2** (1,528) | **MLX +28%** |
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> recipe produces a 2.2× slower artifact after the macOS 27 beta upgrade
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

> Core AI jetsams under the standard deep protocol
>
> — [github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539…](https://github.com/john-rocky/apple-silicon-llm-bench/blob/bd5feaf9fb1a5539046bb30789223d628d39d622/README.md)

</details>
