# CPU Interface

## Overview

The CPU is replaceable. The interface board adapts its supported buses and control signals to observable low-speed educational circuitry.

```text
+-------------------+
| x86-64 compute    |
| module            |
+---------+---------+
          |
+---------v---------+
| module-specific   |
| interface adapter |
+---------+---------+
          |
+---------v---------+
| peripheral/backplane |
+-------------------+
```

## Selection checklist

- [ ] Confirm x86-64 instruction execution and required mode support.
- [ ] Document exposed memory/peripheral interface.
- [ ] Document all power rails and sequencing.
- [ ] Confirm I/O voltage thresholds and drive limits.
- [ ] Confirm reset polarity and boot behavior.
- [ ] Confirm clock input/output rules and timing.
- [ ] Confirm interrupt/debug access.
- [ ] Verify thermal and power requirements.
- [ ] Establish safe connector pinout and ground allocation.
- [ ] Determine whether the platform supports external ROM/RAM at all.

Do not assume a modern Intel processor package exposes a breadboard-friendly 64-bit bus. Many systems hide memory and I/O behind high-speed interfaces, integrated controllers, or a system-on-module.