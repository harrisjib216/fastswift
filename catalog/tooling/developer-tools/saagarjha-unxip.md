# unxip

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md) › [Developer tools](README.md)</sub>

**Tier C** (first-party numbers) · 🟡 Holds up in part · Open source · `Swift` · `LGPL-3.0` · 🟢 active

> Swift tool that extracts Xcode .xip files about 2-3x faster than xip(1) and Archive Utility, per its author.

| | |
|---|---|
| **Beats** | xip(1) and Archive Utility (Apple's Bom) for extracting Xcode .xip files |
| **Claimed result** | About 2-3x less time decompressing and about 25% less disk space than Bom (xip, Archive Utility); up to 70% faster on some systems (xcodes) |
| **Workload** | Extracting Xcode .xip archives to disk |
| **Metric** | time |
| **OS** | macOS 12+ |
| **Adoption** | 973 stars |
| **Last commit** | 2026-09-12 |
| **Platforms** | macOS 12+ |
| **Install** | Homebrew, MacPorts, release binary, or swiftc -O unxip.swift |
| **Links** | [repository](https://github.com/saagarjha/unxip) · [benchmark](https://github.com/saagarjha/unxip) |

## Verdict

The author claims about 2-3x less decompression time and about 25% less disk use than xip, with no published timings. xcodes, which ships unxip, independently says 'up to 70% faster on some systems', which points the same way but suggests a smaller and hardware-dependent gain.

**Why tier C:** First-party claim without timings, hardware or method; the second source is a downstream user with a vaguer figure.

## Use it when

- Installing Xcode versions on CI machines or developer Macs, where extraction takes minutes
- Machines with many cores and fast APFS storage

## Skip it when

- When the XIP's signature must be verified: unxip does no signature checking
- Non-APFS or slow disks, where the author warns behavior is less tested

## How it is fast

unxip treats extraction as a pipeline of async streams (raw XIP data, decompressed chunks, files) built on Swift Concurrency, so decompression and disk writes overlap across cores. It writes the extracted files with compression, which is where the space saving comes from.

## What it costs

- Skips signature verification, so use a checksum or trusted download source
- LGPL-3.0, which matters if you embed libunxip

## Problems with the evidence

- No timings, hardware or Xcode archive version are published for the 2-3x claim
- 'Up to 70% faster on some systems' (xcodes) is ambiguous and suggests the gain varies by machine

## Evidence

<details>
<summary>3 quotes from the sources, checked 2026-10-28</summary>

> Its goal is to outperform Bom (which powers `xip(1)` and Archive Utility) in both performance and on-disk usage, and (at the time of writing) does so by a factor of about 2-3x in time spent decompressing and about 25% in space.
>
> — [github.com/saagarjha/unxip](https://github.com/saagarjha/unxip)

> Xcodes now includes the ability to unxip up to 70% faster on some systems.
>
> — [github.com/XcodesOrg/xcodes](https://github.com/XcodesOrg/xcodes)

> For simplicity, unxip does not perform any signature verification
>
> — [github.com/saagarjha/unxip](https://github.com/saagarjha/unxip)

</details>
