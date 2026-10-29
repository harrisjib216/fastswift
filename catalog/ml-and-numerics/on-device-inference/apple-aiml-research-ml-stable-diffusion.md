# ml-stable-diffusion (Core ML Stable Diffusion, SPLIT_EINSUM_V2 attention)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [ML and numerics](../README.md) › [On-device inference](README.md)</sub>

**Tier C** (first-party numbers) · 🟡 Holds up in part · Open source · `Python + Swift` · `MIT` · 🟢 active

> Apple's Core ML port of Stable Diffusion; its SPLIT_EINSUM_V2 attention is claimed 10-30% faster on iPhone and iPad Neural Engines.

| | |
|---|---|
| **Beats** | The same Stable Diffusion Core ML model converted with the SPLIT_EINSUM attention implementation |
| **Claimed result** | SPLIT_EINSUM_V2 yields 10-30% improvement for mobile devices; resulting end-to-end latency 7.9 s at 2.69 iter/s on iPhone 14 Pro Max |
| **Workload** | stable-diffusion-2-1-base at 512x512, end-to-end text-to-image generation; median of 5 back-to-back runs; best compute unit and attention implementation per device. |
| **Metric** | latency |
| **Hardware** | iPhone 12 mini to iPhone 14 Pro Max; iPad Pro M1 and M2 |
| **OS** | iOS 17.0, iPadOS 17.0 and macOS 14.0 Seed 8 public betas |
| **Measured** | 2023-08 |
| **Adoption** | 18.0k stars |
| **Last commit** | 2026-09-11 |
| **Platforms** | macOS 13.1+, iOS 16.2+ (memory improvements need iOS 17 / macOS 14) |
| **Install** | Swift Package Manager (StableDiffusion package); pip for model conversion |
| **Links** | [repository](https://github.com/apple-aiml-research/ml-stable-diffusion) · [benchmark](https://github.com/apple-aiml-research/ml-stable-diffusion/blob/ea2805dc1945be20561c77e5f6d1d9a5a637cda2/README.md) |

## Verdict

The 10-30% gain for SPLIT_EINSUM_V2 on mobile devices has no published before-and-after table. The README's tables list only the best attention and compute-unit pair per device, and on Macs the ORIGINAL attention on the GPU is the faster choice, so the gain applies to iPhone and iPad Neural Engine runs only.

**Why tier C:** First-party; devices and OS betas are stated and the Diffusers app benchmark branch is public, but the 10-30% figure itself has no data behind it in the text.

## Use it when

- Image generation on iPhone or iPad with cpuAndNeuralEngine
- Shipping a Swift app that must run Stable Diffusion without a server

## Skip it when

- Mac GPU runs: the README's Mac table uses ORIGINAL attention with CPU_AND_GPU
- Newer diffusion models the converter does not cover

## How it is fast

The attention layers are rewritten as split einsum operations whose data layout maps onto the Neural Engine without transposes and reshapes, and V2 refines that layout for mobile chips. Weights can be palettized to 6 bits or fewer, which Core ML on iOS 17 decompresses just in time to cut memory traffic.

## What it costs

- Changing the attention implementation requires re-converting the model
- Neural Engine compilation on first load can take minutes for .mlpackage files

## Problems with the evidence

- The 10-30% figure is stated without a table of SPLIT_EINSUM vs SPLIT_EINSUM_V2 latencies
- 2023 measurements on iOS 17 and macOS 14 betas
- Apple notes the best compute unit is model-version and hardware specific
- The 2026-09 commit only updated root files; the last code change was in 2025-07

## Evidence

<details>
<summary>4 quotes from the sources, checked 2026-10-28</summary>

> `--attention-implementation SPLIT_EINSUM_V2` yields 10-30% improvement for mobile devices, still targeting the Neural Engine.
>
> — [github.com/apple-aiml-research/ml-stable-diffusion/blob/ea2805dc194…](https://github.com/apple-aiml-research/ml-stable-diffusion/blob/ea2805dc1945be20561c77e5f6d1d9a5a637cda2/README.md)

> | iPhone 14 Pro Max     | `CPU_AND_NE`    |      `SPLIT_EINSUM_V2`       |      7.9               |        2.69              |
>
> — [github.com/apple-aiml-research/ml-stable-diffusion/blob/ea2805dc194…](https://github.com/apple-aiml-research/ml-stable-diffusion/blob/ea2805dc1945be20561c77e5f6d1d9a5a637cda2/README.md)

> - This benchmark was conducted by Apple and Hugging Face using public beta versions of iOS 17.0, iPadOS 17.0 and macOS 14.0 Seed 8 in August 2023.
>
> — [github.com/apple-aiml-research/ml-stable-diffusion/blob/ea2805dc194…](https://github.com/apple-aiml-research/ml-stable-diffusion/blob/ea2805dc1945be20561c77e5f6d1d9a5a637cda2/README.md)

> Note that the best performing compute unit is model version and hardware-specific.
>
> — [github.com/apple-aiml-research/ml-stable-diffusion/blob/ea2805dc194…](https://github.com/apple-aiml-research/ml-stable-diffusion/blob/ea2805dc1945be20561c77e5f6d1d9a5a637cda2/README.md)

</details>
