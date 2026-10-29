# xcodes (aria2 downloads)

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Build and tooling](../README.md) › [Developer tools](README.md)</sub>

**Tier C** (first-party numbers) · ✅ Holds up · Open source · `Swift` · `MIT` · 🟢 active

> Command-line Xcode installer that downloads over up to 16 connections with aria2, claimed 3-5x faster than URLSession.

| | |
|---|---|
| **Beats** | Single-connection URLSession download of Xcode (xcodes without aria2, or a browser download) |
| **Claimed result** | Downloads Xcode 3-5x faster than URLSession using up to 16 connections |
| **Workload** | Downloading Xcode .xip archives from Apple's servers |
| **Metric** | time |
| **Adoption** | 4.9k stars |
| **Last commit** | 2026-09-14 |
| **Platforms** | macOS |
| **Install** | Homebrew (brew install xcodesorg/made/xcodes), plus brew install aria2 |
| **Links** | [repository](https://github.com/XcodesOrg/xcodes) · [benchmark](https://github.com/XcodesOrg/xcodes) |

## Verdict

With aria2 installed, xcodes downloads Xcode over up to 16 connections and claims 3-5x faster than URLSession. The claim is first-party and unmeasured in public, but the mechanism is straightforward; the gain depends on the network and per-connection limits.

**Why tier C:** First-party README claim with no timings, network or method.

## Use it when

- Installing or switching Xcode versions on CI machines or several developer Macs
- Networks where a single HTTP connection does not saturate the link

## Skip it when

- Networks or proxies that throttle per client rather than per connection
- Environments that disallow third-party download tools or Apple ID logins from scripts

## How it is fast

When aria2 is on the PATH, xcodes hands the download to it, which splits the file into ranges fetched over up to 16 parallel connections, getting around per-connection throughput limits. It can then extract with unxip instead of xip.

## What it costs

- Needs aria2 installed separately
- Requires Apple ID authentication for downloads

## Problems with the evidence

- No published measurement; 3-5x depends on network and server limits
- The speedup comes from aria2, a separate C++ download tool, not from xcodes' Swift code

## Evidence

<details>
<summary>1 quote from the sources, checked 2026-10-28</summary>

> It uses up to 16 connections to download Xcode 3-5x faster than URLSession.
>
> — [github.com/XcodesOrg/xcodes](https://github.com/XcodesOrg/xcodes)

</details>
