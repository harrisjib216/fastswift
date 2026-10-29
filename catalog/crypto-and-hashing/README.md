# Crypto and hashing

<sub>[fastswift](../../README.md) › [Catalog](../README.md)</sub>

## [Cryptographic hashes and ciphers](crypto-hashes-and-ciphers/README.md)

**The default:** CryptoKit and CommonCrypto.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**CryptoSwift**](crypto-hashes-and-ciphers/krzyzanowskim-cryptoswift.md) | Pure-Swift crypto algorithms; measured 3.5x to 57x slower than CommonCrypto, so use it for portability or missing algorithms, not speed. | B | ❌ Doesn't hold up |

## [Non-cryptographic hashes](non-crypto-hashes/README.md)

**The default:** Swift's Hasher (SipHash) and hashValue.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**SwiftXXHash (xxHash XXH3/XXH64)**](non-crypto-hashes/jaesung-jung-swiftxxhash.md) | Swift wrapper for the official xxHash C library; XXH3 hashes bytes about 10x faster than SipHash in xxHash's x86 benchmark. | A | 🟡 Holds up in part |

## [Random numbers](random-numbers/README.md)

**The default:** SystemRandomNumberGenerator.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**CwlUtils (Xoshiro)**](random-numbers/mattgallagher-cwlutils-xoshiro.md) | Swift Xoshiro256** generator from CwlUtils; 69x faster than arc4random_buf, the source behind SystemRandomNumberGenerator. | A | ✅ Holds up |
| [**SwiftWyhash (WyRand)**](random-numbers/lemire-swiftwyhash.md) | Pure-Swift wyrand generator; about 50x faster than Double.random(in:) with the system generator for bulk random arrays. | B | ✅ Holds up |
