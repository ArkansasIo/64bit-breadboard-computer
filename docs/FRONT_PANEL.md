# Front Panel

## Indicators

| LED | Meaning |
|---|---|
| POWER | supply present |
| CLK | permitted clock/activity indicator |
| RESET | reset asserted |
| MEM | memory activity, if safely observable |
| I/O | peripheral transaction |
| UART | serial activity |
| IRQ | interrupt test signal |
| FAULT | firmware or test failure |
| RUN | firmware has entered its main loop |

## Controls

| Control | Function |
|---|---|
| RESET | request a platform-safe reset |
| STEP | step a compatible test clock/logic circuit; not automatically the CPU clock |
| RUN | resume the test circuit |
| DIP[7:0] | GPIO/debug input |

Use buffers or dedicated logic indicators to avoid loading timing-sensitive CPU signals. Document active-high/active-low polarity on the actual schematic.