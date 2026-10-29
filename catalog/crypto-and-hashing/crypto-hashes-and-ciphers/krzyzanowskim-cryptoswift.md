# CryptoSwift

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Crypto and hashing](../README.md) › [Cryptographic hashes and ciphers](README.md)</sub>

**Tier B** (independent measurement) · ❌ Doesn't hold up · No open-source license · `Swift` · `NOASSERTION` · 🟢 active

> Pure-Swift crypto algorithms; measured 3.5x to 57x slower than CommonCrypto, so use it for portability or missing algorithms, not speed.

| | |
|---|---|
| **Beats** | CommonCrypto and CryptoKit |
| **Claimed result** | CryptoSwift slower, not faster: double SHA-256 loop 3.847 s vs 1.094 s with CommonCrypto (3.5x slower); 10 MB AES-256 encrypt 5255 ms vs 92 ms for CommonCrypto-based RNCryptor (57x slower) (derived from page data). Opposing data point: CryptoKit beta measured 40-80% slower, later 60% slower, than CryptoSwift in 2019 |
| **Workload** | Repeated SHA-256(SHA-256(data)) over small inputs in a proof-of-work loop; separately, AES-256 encryption of a 10 MB buffer |
| **Metric** | time |
| **Hardware** | 2016 MacBook Pro (SHA-256 thread); 2.6 GHz Intel Core i7 (AES table) |
| **OS** | macOS 10.14 for the CommonCrypto run |
| **Toolchain** | Xcode 11 beta for the CryptoKit comparison; other build settings not stated |
| **Measured** | 2019-08 |
| **Adoption** | 10.6k stars |
| **Last commit** | 2026-08-19 |
| **Platforms** | iOS 11+, macOS 10.13+, tvOS 11+, watchOS 4+, visionOS 1+, Linux, Android |
| **Install** | Swift Package Manager, Carthage, CocoaPods (deprecated) |
| **Links** | [repository](https://github.com/krzyzanowskim/CryptoSwift) · [benchmark](https://forums.swift.org/t/cryptokit-sha256-much-much-slower-than-cryptoswift/27983) |

## Verdict

Every published comparison found has CommonCrypto ahead: 3.5x on a SHA-256 loop and 57x on 10 MB AES-256 encryption. The one report of CryptoSwift beating CryptoKit was against the 2019 CryptoKit beta on tiny inputs, and on the same harness CommonCrypto was 3.5x faster than CryptoSwift.

**Why tier B:** Third-party measurements by users of the libraries (forum thread and a competing project's README), with code shown but little hardware or build detail.

## Use it when

- Algorithms or modes CryptoKit lacks (AES-CBC, AES-CTR, Blowfish, Rabbit) on platforms without CommonCrypto, such as Linux or Android
- Code that must share one Swift crypto API across Apple platforms, Linux and Android

## Skip it when

- Bulk encryption or hashing on Apple platforms; CryptoKit or CommonCrypto use hardware acceleration
- Debug builds: the author says unoptimized builds of crypto-heavy code are dramatically slower

## How it is fast

It is not faster. CryptoSwift implements AES, SHA and other primitives in portable Swift without hardware AES or SHA instructions. CommonCrypto and CryptoKit call Apple's corecrypto, which uses the CPU's AES and SHA extensions and hand-tuned assembly.

## What it costs

- Much lower throughput than hardware-backed implementations
- Pure-Swift code without the hardware acceleration and side-channel review of corecrypto or BoringSSL

## Problems with the evidence

- The 5255 ms AES figure is disputed by the CryptoSwift author as a likely debug build; even a much better release figure would remain far behind 92 ms
- The RNCryptor and CryptoSwift AES numbers were not measured with matched settings on matched hardware
- The CryptoKit-slower result came from the CryptoKit beta in Xcode 11, first in the iOS Simulator and then on macOS; profiling in the thread pointed to buffer allocation around the call
- No release-build, same-machine comparison of CryptoSwift, CommonCrypto and CryptoKit on Apple silicon was found
- GitHub reports the license as NOASSERTION: it is zlib-style text with an added acknowledgment requirement, not a standard OSI license

## Evidence

<details>
<summary>7 quotes from the sources, checked 2026-10-28</summary>

> It ran in 1.094s compared 3.847 for CryptoSwift on my computer
>
> — [forums.swift.org/t/cryptokit-sha256-much-much-slower-than-cryptoswi…](https://forums.swift.org/t/cryptokit-sha256-much-much-slower-than-cryptoswift/27983)

> not 3 times as slow but between 40-80% slower.
>
> — [forums.swift.org/t/cryptokit-sha256-much-much-slower-than-cryptoswi…](https://forums.swift.org/t/cryptokit-sha256-much-much-slower-than-cryptoswift/27983)

> CryptoKit being 60% slower than CryptoSwift.
>
> — [forums.swift.org/t/cryptokit-sha256-much-much-slower-than-cryptoswi…](https://forums.swift.org/t/cryptokit-sha256-much-much-slower-than-cryptoswift/27983)

> here are the results obtained when encrypting a 10MB file with AES-256 on a 2.6 GHz Intel Core i7.
>
> — [github.com/etienne-martin/WebCrypto.swift](https://github.com/etienne-martin/WebCrypto.swift)

> **RNCryptor** 92ms
>
> — [github.com/etienne-martin/WebCrypto.swift](https://github.com/etienne-martin/WebCrypto.swift)

> **CryptoSwift:** 5255ms
>
> — [github.com/etienne-martin/WebCrypto.swift](https://github.com/etienne-martin/WebCrypto.swift)

> Debug builds can be dramatically slower than optimized Release builds.
>
> — [github.com/krzyzanowskim/CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift)

</details>
