# Caches and key-value stores

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Storage](../README.md)</sub>

**The default:** UserDefaults, NSCache, NSKeyedArchiver and plain file writes.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Bodega (SQLiteStorageEngine)**](mergesort-bodega.md) | Key-value store whose SQLite engine loads 1,000 objects in about 0.1 s against 0.25 s for one-file-per-object storage. | C | ✅ Holds up |
| [**MMKV**](tencent-mmkv.md) | mmap-backed key-value store from WeChat; much faster than NSUserDefaults for bulk writes in a vendor chart, on par for reads. | D | 🟡 Holds up in part |
| [**YYCache (YYMemoryCache, YYDiskCache)**](ibireme-yycache.md) | Objective-C memory and SQLite-backed disk cache; 2015 charts show it ahead of NSCache and file caches, numbers chart-only. | D | 🟡 Holds up in part |
