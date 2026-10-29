# On-device inference

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [ML and numerics](../README.md)</sub>

**The default:** Core ML.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Core ML stateful models (KV cache as model state)**](apple-coreml-stateful-models.md) | Core ML states keep an LLM's KV cache inside the model, decoding about 13x faster than passing the cache as inputs at 2K context. | B | ✅ Holds up |
| [**ane_transformers (Neural Engine Transformer reference)**](apple-aiml-research-ml-ane-transformers.md) | Apple's PyTorch reference for Neural Engine-friendly Transformers; up to 10x faster than an as-is Core ML conversion of distilbert. | C | ✅ Holds up |
| [**Core AI (LLM runtime, Core ML successor)**](apple-coreai-llm.md) | Apple's Core ML successor in iOS 27/macOS 27; decodes LLMs several times faster than Core ML conversions and ties MLX on dense models. | A | 🟡 Holds up in part |
| [**llama.cpp (Metal backend on Apple silicon)**](ggml-org-llama-cpp.md) | C/C++ LLM runtime with a Metal backend; beats Core ML's Neural Engine path on burst decode but trails MLX Swift on Apple silicon. | A | 🟡 Holds up in part |
| [**MLX Swift (LLM decoding on the Apple silicon GPU)**](ml-explore-mlx-swift.md) | Swift API for Apple's MLX array framework; decodes LLMs on the GPU faster than Core ML's Neural Engine path in short bursts. | A | 🟡 Holds up in part |
| [**ml-stable-diffusion (Core ML Stable Diffusion, SPLIT_EINSUM_V2 attention)**](apple-aiml-research-ml-stable-diffusion.md) | Apple's Core ML port of Stable Diffusion; its SPLIT_EINSUM_V2 attention is claimed 10-30% faster on iPhone and iPad Neural Engines. | C | 🟡 Holds up in part |
| [**WhisperKit (argmax-oss-swift)**](argmaxinc-argmax-oss-swift.md) | Whisper speech recognition in Swift on Core ML and the Neural Engine; faster than Apple's SpeechAnalyzer only with a less accurate model. | C | 🟡 Holds up in part |
