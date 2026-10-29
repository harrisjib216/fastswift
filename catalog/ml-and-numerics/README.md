# ML and numerics

<sub>[fastswift](../../README.md) › [Catalog](../README.md)</sub>

## [On-device inference](on-device-inference/README.md)

**The default:** Core ML.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Core ML stateful models (KV cache as model state)**](on-device-inference/apple-coreml-stateful-models.md) | Core ML states keep an LLM's KV cache inside the model, decoding about 13x faster than passing the cache as inputs at 2K context. | B | ✅ Holds up |
| [**ane_transformers (Neural Engine Transformer reference)**](on-device-inference/apple-aiml-research-ml-ane-transformers.md) | Apple's PyTorch reference for Neural Engine-friendly Transformers; up to 10x faster than an as-is Core ML conversion of distilbert. | C | ✅ Holds up |
| [**Core AI (LLM runtime, Core ML successor)**](on-device-inference/apple-coreai-llm.md) | Apple's Core ML successor in iOS 27/macOS 27; decodes LLMs several times faster than Core ML conversions and ties MLX on dense models. | A | 🟡 Holds up in part |
| [**llama.cpp (Metal backend on Apple silicon)**](on-device-inference/ggml-org-llama-cpp.md) | C/C++ LLM runtime with a Metal backend; beats Core ML's Neural Engine path on burst decode but trails MLX Swift on Apple silicon. | A | 🟡 Holds up in part |
| [**MLX Swift (LLM decoding on the Apple silicon GPU)**](on-device-inference/ml-explore-mlx-swift.md) | Swift API for Apple's MLX array framework; decodes LLMs on the GPU faster than Core ML's Neural Engine path in short bursts. | A | 🟡 Holds up in part |
| [**ml-stable-diffusion (Core ML Stable Diffusion, SPLIT_EINSUM_V2 attention)**](on-device-inference/apple-aiml-research-ml-stable-diffusion.md) | Apple's Core ML port of Stable Diffusion; its SPLIT_EINSUM_V2 attention is claimed 10-30% faster on iPhone and iPad Neural Engines. | C | 🟡 Holds up in part |
| [**WhisperKit (argmax-oss-swift)**](on-device-inference/argmaxinc-argmax-oss-swift.md) | Whisper speech recognition in Swift on Core ML and the Neural Engine; faster than Apple's SpeechAnalyzer only with a less accurate model. | C | 🟡 Holds up in part |

## [Linear algebra and DSP](linear-algebra-and-dsp/README.md)

**The default:** Plain Swift loops over arrays.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Accelerate (BLAS and LAPACK)**](linear-algebra-and-dsp/apple-accelerate-blas.md) | Apple's tuned BLAS and LAPACK; Linpack over 24x faster than untuned code and SGEMM about 2.5x faster than Eigen on iPhone XS. | C | ✅ Holds up |
| [**Matft**](linear-algebra-and-dsp/jjjkkkjjj-matft.md) | NumPy-style arrays for Swift on Accelerate; 10-33x faster than NumPy on sin and power, slower on sorting and comparisons. | A | 🟡 Holds up in part |
| [**LASwift**](linear-algebra-and-dsp/alexandertar-laswift.md) | Matlab-style vector and matrix library over Accelerate; a 2017 Swift 3 benchmark puts it near NumPy, with no Swift-loop baseline. | B | 🟡 Holds up in part |
| [**Accelerate (vDSP and vForce element-wise math)**](linear-algebra-and-dsp/apple-accelerate-vdsp.md) | Apple's vectorized array math; claimed 3-10x over scalar loops, but optimized Swift loops match it on simple element-wise arithmetic. | C | 🟡 Holds up in part |
| [**Surge**](linear-algebra-and-dsp/jounce-surge.md) | Swift wrappers over Accelerate's vDSP, vForce and BLAS; claims near-Accelerate speed but publishes no numbers against plain loops. | D | 🟡 Holds up in part |
