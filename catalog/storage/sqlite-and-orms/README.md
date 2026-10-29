# SQLite and object stores

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Storage](../README.md)</sub>

**The default:** Core Data and SwiftData.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**GRDB.swift (records against Core Data)**](groue-grdb-swift.md) | SQLite toolkit for Swift whose record types fetched rows about 1.9x faster than Core Data in its own Release-build harness. | A | ✅ Holds up |
| [**Realm Swift**](realm-realm-swift.md) | Embedded object database with its own engine; 3-6x faster than SwiftData on large writes but over 10x slower on relationship queries. | A | 🟡 Holds up in part |
| [**Lighter (Enlighter-generated SQLite bindings)**](lighter-swift-lighter.md) | Code generator that binds SQLite statements directly to Swift structs; 6.6x faster than GRDB with Codable in an independent rerun. | B | 🟡 Holds up in part |
| [**SQLiteData (StructuredQueries decoding over GRDB)**](pointfreeco-sqlite-data.md) | SwiftData-style observation over SQLite; decodes rows 2.2x faster than GRDB's hand-written mapping, but has no published SwiftData numbers. | C | 🟡 Holds up in part |
| [**Core Data (used directly instead of SwiftData)**](apple-coredata-nsmanagedobjectcontext.md) | Using Core Data directly skips SwiftData's model layer; developers report fetches about 20x faster, but only anecdotally. | D | 🟡 Holds up in part |
