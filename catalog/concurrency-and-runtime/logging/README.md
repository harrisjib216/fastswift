# Logging

<sub>[fastswift](../../../README.md) › [Catalog](../../README.md) › [Concurrency and runtime](../README.md)</sub>

**The default:** print and NSLog.

| Entry | What it is | Tier | Verdict |
|---|---|:-:|---|
| [**Chronicle**](saagarjha-chronicle.md) | Experimental in-process structured logger claiming a few dozen nanoseconds per message; no published comparison with os_log or print. | C | 🟡 Holds up in part |
| [**CocoaLumberjack**](cocoalumberjack-cocoalumberjack.md) | Logging framework that claimed an order-of-magnitude win over NSLog in 2010 benchmarks; untested against today's NSLog or os.Logger. | D | 🟡 Holds up in part |
