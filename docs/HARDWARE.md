# Hardware Design

## Design boundary

The breadboard system is an educational chipset and peripheral backplane around a real x86-64 compute module. It does not reproduce the full modern CPU microarchitecture using discrete gates.

## Proposed modules

- **CPU module / interface:** x86-64 execution platform, connectors, safe voltage domains, reset, supported memory or I/O interface.
- **Power:** regulated supplies sized from selected hardware datasheets; current limit during bring-up.
- **Clock/reset:** source, supervisor, optional slow test clock for compatible logic, reset status.
- **Decode/control:** chip-select generation and transaction observation.
- **ROM:** firmware storage compatible with the chosen processor platform.
- **RAM:** working memory compatible with the chosen platform.
- **UART:** early diagnostic console.
- **GPIO:** LEDs, switches, and pushbuttons.
- **Timer/IRQ:** periodic events and interrupt testing where supported.
- **Front panel:** reset/run/step controls, status LEDs, test points.
- **Expansion:** defined connectors and ground/power allocation.

## Logical names

```text
CLK, RESET_N
A[63:0], D[63:0]
MEM_RD, MEM_WR, IO_RD, IO_WR
CS_ROM, CS_RAM, CS_UART, CS_GPIO, CS_TIMER
IRQ, NMI, DBG
```

These are abstract names, not a pinout. Map them to the selected module's real interfaces only after reading its datasheet.

## Layout guidance

Separate the project into small boards: power, clock/reset, CPU interface, decode, memory, UART, GPIO/front panel, and expansion. Keep fast signals short; use ground returns and signal-integrity practices appropriate to the actual bus.

## Schematic requirements

Each schematic revision should show actual part numbers, pin numbers, rail voltages, connector orientation, decoupling, pull-ups, test points, and design notes. Never publish an assumed CPU pinout as verified wiring.