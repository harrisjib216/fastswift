# Random numbers

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Crypto and hashing](../README.md)</sub>

**The default:** SystemRandomNumberGenerator.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**CwlUtils (Xoshiro)**](mattgallagher-cwlutils-xoshiro.md) | Swift Xoshiro256** generator from CwlUtils; 69x faster than arc4random_buf, the source behind SystemRandomNumberGenerator. | A | ✅ Holds up |
| [**SwiftWyhash (WyRand)**](lemire-swiftwyhash.md) | Pure-Swift wyrand generator; about 50x faster than Double.random(in:) with the system generator for bulk random arrays. | B | ✅ Holds up |
