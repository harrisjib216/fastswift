# ane_transformers (Neural Engine Transformer reference)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [ML and numerics](../README.md) › [On-device inference](README.md)</sub>

**Tier C** (first-party numbers) · ✅ Holds up · No open-source license · `Python` · `NOASSERTION` · 🟢 active

> Apple's PyTorch reference for Neural Engine-friendly Transformers; up to 10x faster than an as-is Core ML conversion of distilbert.

| | |
|---|---|
| **Beats** | Hugging Face distilbert converted to Core ML as-is |
| **Claimed result** | Up to 10 times faster forward pass and 14 times lower peak memory (sequence length 512, batch size 8, iPhone 13); 2.84 times lower latency at sequence length 128, batch size 1 (iPhone 13 Pro Max, iOS 16.0) |
| **Workload** | distilbert-base-uncased-finetuned-sst-2-english forward pass at sequence lengths up to 512 and batch sizes up to 8. |
| **Metric** | latency and peak memory |
| **Hardware** | iPhone 13; iPhone 13 Pro Max (A15) |
| **OS** | iOS 16.0 |
| **Toolchain** | coremltools >= 5.2, torch 1.10 to 1.11 (requirements.txt) |
| **Measured** | 2022-06 |
| **Adoption** | 2.8k stars |
| **Last commit** | 2026-09-11 |
| **Platforms** | Generated Core ML models target A14+ iPhone and iPad and M1+ Macs |
| **Install** | pip (ane_transformers) |
| **Links** | [repository](https://github.com/apple-aiml-research/ml-ane-transformers) · [benchmark](https://machinelearning.apple.com/research/neural-engine-transformers) |

## Verdict

Apple's case study supports the up-to figure: 2.84x lower latency at the tutorial's sequence length 128 and batch 1, rising to 10x lower latency and 14x lower peak memory at sequence 512 and batch 8. The data is from 2022 on iOS 16, and no independent re-measurement on current OS versions was found.

**Why tier C:** First-party; the repo's unit tests measure the speed-up, but per-configuration results are published mainly as charts and Xcode report screenshots.

## Use it when

- Deploying encoder Transformers (classification, embeddings) to iPhone, iPad or Mac through Core ML
- Longer sequences and larger batches, where the gain grows toward 10x

## Skip it when

- Autoregressive LLM decoding, which needs KV-cache handling this reference does not cover
- Devices older than A14 or M1
- Teams that need an OSI license: the Apple license here is not OSI-approved

## How it is fast

The model is rewritten to use the (B, C, 1, S) channels-first layout the Neural Engine prefers, with linear layers as 1x1 convolutions and attention split per head into einsum operations that need no transposes or reshapes. Chunking keeps intermediate tensors in the Neural Engine's cache, which cuts both latency and peak memory.

## What it costs

- Requires re-authoring the model in the reference layout before conversion
- Longer first-load compilation

## Problems with the evidence

- 2022 data on iOS 16; Core ML has since added fused attention and stateful models, so today's as-is baseline is likely faster
- The 10x and 14x figures are peaks read from interactive charts
- Code untouched since 2022-08; the 2026-09 commit only updated root files after the move to apple-aiml-research
- Load and compile times increase because the optimized model has more operations

## Evidence

<details>
<summary>5 quotes from the sources, checked 2026-10-28</summary>

> Applying these optimizations resulted in a forward pass that is up to 10 times faster with a simultaneous reduction of peak-memory consumption of 14 times on iPhone 13.
>
> — [machinelearning.apple.com/research/neural-engine-transformers](https://machinelearning.apple.com/research/neural-engine-transformers)

> Notably, this model, which works out-of-the-box and on device using Core ML already, is up to 10 times faster and consumes 14 times less memory after our optimizations.
>
> — [machinelearning.apple.com/research/neural-engine-transformers](https://machinelearning.apple.com/research/neural-engine-transformers)

> Based on the figure above, the latency is improved by a factor of 2.84 times for the sequence length of 128 and batch size of 1 that were chosen for the tutorial.
>
> — [github.com/apple-aiml-research/ml-ane-transformers/blob/590eb359136…](https://github.com/apple-aiml-research/ml-ane-transformers/blob/590eb35913622cdef217ebc5329047aab389ac98/README.md)

> Higher sequence lengths, such as 512, and batch sizes, such as 8, will yield up to **10 times lower latency** and **14 times lower peak memory consumption**.
>
> — [github.com/apple-aiml-research/ml-ane-transformers/blob/590eb359136…](https://github.com/apple-aiml-research/ml-ane-transformers/blob/590eb35913622cdef217ebc5329047aab389ac98/README.md)

> The figure below shows a performance report generated for this model on an iPhone 13 Pro Max with iOS 16.0 installed.
>
> — [github.com/apple-aiml-research/ml-ane-transformers/blob/590eb359136…](https://github.com/apple-aiml-research/ml-ane-transformers/blob/590eb35913622cdef217ebc5329047aab389ac98/README.md)

</details>
