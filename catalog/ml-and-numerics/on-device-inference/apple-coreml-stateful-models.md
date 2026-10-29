# Core ML stateful models (KV cache as model state)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [ML and numerics](../README.md) › [On-device inference](README.md)</sub>

**Tier B** (independent measurement) · ✅ Holds up · Ships with Apple's SDKs · `Swift` · `Apple SDK` · 🟢 active

> Core ML states keep an LLM's KV cache inside the model, decoding about 13x faster than passing the cache as inputs at 2K context.

| | |
|---|---|
| **Beats** | Core ML LLM with the key-value cache passed as model inputs and outputs (the pre-macOS 15 / iOS 18 pattern) |
| **Claimed result** | ~13 times faster decode at 2048 context: 16.26 tokens/s vs 1.25 tokens/s (Llama-3.1-8B-Instruct, M1 Max); with block-wise int4 weights added, ~33 tokens/s vs 0.19 tokens/s for the naive export; independent: 45% lower Whisper Large v3 Turbo decoder latency (8.4 ms →4.6 ms on M3 ANE) |
| **Workload** | Llama-3.1-8B-Instruct on the GPU, 7-token prompt and about 100 generated tokens, context sizes 128 to 8192; Whisper Large v3 Turbo text-decoder forward pass on the Neural Engine. |
| **Metric** | throughput (decode tokens/s) and latency |
| **Hardware** | Mac with M1 Max (Apple); MacBook Pro with M3 Max (Argmax) |
| **OS** | macOS Sequoia 15.2 beta |
| **Toolchain** | Core ML Tools conversion; Swift runner using Core ML's MLTensor APIs |
| **Measured** | 2024-11-01 |
| **Platforms** | iOS 18+, macOS 15+, tvOS 18+, watchOS 11+, visionOS 2+ |
| **Install** | built into iOS 18+ and macOS 15+ |
| **Links** | [documentation](https://developer.apple.com/documentation/coreml/mlstate) · [benchmark](https://machinelearning.apple.com/research/core-ml-on-device-llama) |

## Verdict

Apple measured about 13x faster decoding at a 2048-token context for Llama 3.1 8B on an M1 Max, and Argmax independently measured a 45% latency cut for the Whisper decoder on the M3 Neural Engine. The gain is much smaller at short contexts, where copying the cache costs little.

**Why tier B:** Apple's numbers are first-party, and Argmax, a separate company, published an independent measurement of the same feature in its WhisperKit paper.

## Use it when

- Autoregressive decoders (LLMs, Whisper text decoders) deployed through Core ML
- Long contexts, where the cache copy dominates per-token time

## Skip it when

- Apps that must run on iOS 17 / macOS 14 or earlier
- Very short contexts, where the I/O cache costs little
- Stateless models such as encoders and classifiers

## How it is fast

With states, the key-value cache tensors live inside the model and are updated in place during prediction instead of being copied out as outputs and back in as inputs on every token. For an 8B model the cache can reach about 1 GB at 8K context, so removing the copies removes most of the per-token overhead.

## What it costs

- Models must be re-exported with state inputs
- Raises the minimum OS to iOS 18 / macOS 15

## Problems with the evidence

- Apple's numbers come from a macOS 15.2 beta on one M1 Max
- Whether the update happens in place depends on the compute backend and the surrounding operations
- The ~33 tokens/s figure also includes fused attention and int4 quantization, not just state

## Evidence

<details>
<summary>8 quotes from the sources, checked 2026-10-28</summary>

> In this example we use Llama-3.1-8B-Instruct, a popular mid-size LLM
>
> — [machinelearning.apple.com/research/core-ml-on-device-llama](https://machinelearning.apple.com/research/core-ml-on-device-llama)

> throughput: 1.25 tokens/s
>
> — [machinelearning.apple.com/research/core-ml-on-device-llama](https://machinelearning.apple.com/research/core-ml-on-device-llama)

> throughput: 16.26 tokens/s
>
> — [machinelearning.apple.com/research/core-ml-on-device-llama](https://machinelearning.apple.com/research/core-ml-on-device-llama)

> We now see that the performance is improved ~13 times, compared to key-value cache as I/O for 2048 context size.
>
> — [machinelearning.apple.com/research/core-ml-on-device-llama](https://machinelearning.apple.com/research/core-ml-on-device-llama)

> throughput: 0.19 tokens/s
>
> — [machinelearning.apple.com/research/core-ml-on-device-llama](https://machinelearning.apple.com/research/core-ml-on-device-llama)

> this model can be run locally on a Mac with M1 Max with about ~33 tokens/s decoding speed
>
> — [machinelearning.apple.com/research/core-ml-on-device-llama](https://machinelearning.apple.com/research/core-ml-on-device-llama)

> using a Mac with M1 Max running macOS Sequoia 15.2 Beta
>
> — [machinelearning.apple.com/research/core-ml-on-device-llama](https://machinelearning.apple.com/research/core-ml-on-device-llama)

> This leads to a 45% latency reduction (8.4 ms →4.6 ms on M3 ANE) for the Whisper Large v3 Turbo Text Decoder forward pass compared to our previous implementation that passed the key-value cache as input tensors to the model.
>
> — [arxiv.org/html/2507.10860](https://arxiv.org/html/2507.10860)

</details>
