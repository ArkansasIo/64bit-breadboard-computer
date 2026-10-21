# Memory Map

This is an **illustrative custom peripheral map**, not a universal Intel PC physical map. Confirm that the chosen boot environment and processor module support it.

| Range | Size | Suggested purpose |
|---|---:|---|
| 0x0000_0000–0x000F_FFFF | 1 MiB | boot ROM window (platform-dependent) |
| 0x0010_0000–0x00FF_FFFF | 15 MiB | RAM window (illustrative) |
| 0xF000_0000–0xF000_0FFF | 4 KiB | UART |
| 0xF000_1000–0xF000_1FFF | 4 KiB | GPIO |
| 0xF000_2000–0xF000_2FFF | 4 KiB | timer |
| 0xF000_3000–0xF000_3FFF | 4 KiB | debug registers |
| 0xF000_4000–0xF000_4FFF | 4 KiB | expansion slot 0 |

Modern x86-64 firmware may use an entirely different map, and an ordinary PC-class CPU typically does not expose a simple raw parallel address/data bus. Treat the table as a logical target for an adapted platform or educational simulator until validated.