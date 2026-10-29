# Storage

<sub>[fastswift](../../README.md) › [Catalog](../README.md)</sub>

## [SQLite and object stores](sqlite-and-orms/README.md)

**The default:** Core Data and SwiftData.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**GRDB.swift (records against Core Data)**](sqlite-and-orms/groue-grdb-swift.md) | SQLite toolkit for Swift whose record types fetched rows about 1.9x faster than Core Data in its own Release-build harness. | A | ✅ Holds up |
| [**Realm Swift**](sqlite-and-orms/realm-realm-swift.md) | Embedded object database with its own engine; 3-6x faster than SwiftData on large writes but over 10x slower on relationship queries. | A | 🟡 Holds up in part |
| [**Lighter (Enlighter-generated SQLite bindings)**](sqlite-and-orms/lighter-swift-lighter.md) | Code generator that binds SQLite statements directly to Swift structs; 6.6x faster than GRDB with Codable in an independent rerun. | B | 🟡 Holds up in part |
| [**SQLiteData (StructuredQueries decoding over GRDB)**](sqlite-and-orms/pointfreeco-sqlite-data.md) | SwiftData-style observation over SQLite; decodes rows 2.2x faster than GRDB's hand-written mapping, but has no published SwiftData numbers. | C | 🟡 Holds up in part |
| [**Core Data (used directly instead of SwiftData)**](sqlite-and-orms/apple-coredata-nsmanagedobjectcontext.md) | Using Core Data directly skips SwiftData's model layer; developers report fetches about 20x faster, but only anecdotally. | D | 🟡 Holds up in part |

## [Caches and key-value stores](caches-and-key-value/README.md)

**The default:** UserDefaults, NSCache, NSKeyedArchiver and plain file writes.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Bodega (SQLiteStorageEngine)**](caches-and-key-value/mergesort-bodega.md) | Key-value store whose SQLite engine loads 1,000 objects in about 0.1 s against 0.25 s for one-file-per-object storage. | C | ✅ Holds up |
| [**MMKV**](caches-and-key-value/tencent-mmkv.md) | mmap-backed key-value store from WeChat; much faster than NSUserDefaults for bulk writes in a vendor chart, on par for reads. | D | 🟡 Holds up in part |
| [**YYCache (YYMemoryCache, YYDiskCache)**](caches-and-key-value/ibireme-yycache.md) | Objective-C memory and SQLite-backed disk cache; 2015 charts show it ahead of NSCache and file caches, numbers chart-only. | D | 🟡 Holds up in part |
