# 64-bit Breadboard Computer — Component Specification

This document defines the physical component set for the educational 64-bit computer. The design uses a **modern x86-64 compute module** as the processor and implements the visible computer architecture—clocking, reset, buses, memory, I/O, front panel, and support logic—with breadboard-friendly components.

> **Important:** Do not place a bare modern Intel/AMD x86-64 CPU on a solderless breadboard. Modern CPUs require high-density packages, controlled power delivery, multilayer PCBs, high-speed signal integrity, and dedicated firmware. The breadboard system below connects to a suitable x86-64 module or SBC through documented low-speed interfaces.

## 1. Core breadboard components

| Category | Component | Qty | Purpose |
|---|---|---:|---|
| Breadboards | Full-size solderless breadboard | 8 | Main logic banks |
| Breadboards | Half-size solderless breadboard | 4 | Control/I/O modules |
| Wiring | 22 AWG solid-core jumper wire kit | 1 | Power and bus wiring |
| Wiring | Male-male Dupont jumpers | 1 kit | Module connections |
| Wiring | Female-male Dupont jumpers | 1 kit | Module-to-board connections |
| Power | 5 V regulated bench supply | 1 | Logic rail |
| Power | 3.3 V regulated supply | 1 | Modern I/O rail |
| Power | Breadboard power modules | 4 | Local regulated rails |
| Protection | Inline resettable fuse/polyfuse | 2 | Supply protection |
| Protection | 0.1 uF ceramic capacitors | 100 | IC decoupling |
| Protection | 10 uF electrolytic capacitors | 20 | Local bulk bypass |
| Protection | 470 uF electrolytic capacitors | 4 | Rail bulk filtering |

## 2. Logic family

Use **74HCT/74HC** logic for the educational breadboard subsystem. Prefer HCT when interfacing 5 V TTL-style signals and HC where CMOS levels are appropriate. Keep 3.3 V devices on the 3.3 V side of the interface.

### Recommended IC inventory

| IC | Qty | Function |
|---|---:|---|
| 74HCT00 | 10 | Quad NAND gates |
| 74HCT02 | 6 | Quad NOR gates |
| 74HCT04 | 8 | Hex inverters |
| 74HCT08 | 10 | Quad AND gates |
| 74HCT32 | 8 | Quad OR gates |
| 74HCT86 | 8 | Quad XOR gates |
| 74HCT157 | 12 | Quad 2:1 multiplexers |
| 74HCT138 | 8 | 3-to-8 decoders |
| 74HCT139 | 4 | Dual 2-to-4 decoders |
| 74HCT245 | 12 | Octal bidirectional bus transceivers |
| 74HCT244 | 8 | Octal buffers |
| 74HCT273 | 8 | Octal registers |
| 74HCT574 | 8 | Octal tri-state registers |
| 74HCT595 | 8 | Serial-in/parallel-out registers |
| 74HCT165 | 8 | Parallel-in/serial-out registers |
| 74HC161 | 8 | 4-bit synchronous counters |
| 74HC163 | 8 | 4-bit synchronous counters |
| 74HC4040 | 4 | Ripple/binary counters |
| 74HC74 | 8 | Dual D flip-flops |
| 74HC393 | 4 | Dual 4-bit counters |

## 3. Memory

The breadboard should not implement modern DDR memory as discrete chips. Use a documented SRAM/FRAM or memory module for the educational memory bus.

### Suggested memory devices

- 32 KB or 128 KB parallel SRAM module for low-speed experiments.
- SPI FRAM module for nonvolatile configuration storage.
- EEPROM such as a 28C-series device for firmware experiments.
- Optional external SDRAM/DDR module behind the x86-64 compute module.

For a first breadboard prototype, use **parallel SRAM** because address and data signals are easy to observe with LEDs or logic analyzers.

## 4. Clock system

### Components

- 1 MHz oscillator module for initial bring-up.
- 10 MHz oscillator module for expanded tests.
- 74HC74 divider stages.
- 74HC4040 divider.
- Debounced single-step pushbutton.
- 10 kOhm pull-up resistors.
- 100 nF capacitor for switch debounce.
- 74HCT14 Schmitt-trigger inverter for clean clock edges.
- Clock enable/hold switch.
- Red/green LEDs for RUN/HALT status.

### Rule

Start at **1 MHz or slower** for breadboard logic. Do not attempt high-speed CPU buses on solderless breadboard wiring.

## 5. Reset and control

Components:

- Momentary normally-open pushbutton.
- 10 kOhm resistor.
- 100 nF capacitor.
- 74HCT14 Schmitt trigger.
- Optional supervisor/reset IC.
- Red reset LED.
- Green power-good LED.

Reset must be asserted during power-up and released only after rails are stable.

## 6. Address bus

For the educational low-speed bus expose:

- A0–A15 address lines initially.
- Optional A16–A31 expansion connector.
- 74HCT245 transceivers.
- 74HCT273/574 address latches.
- 74HCT138 address decoders.
- 220–470 Ohm series resistors where appropriate for LED observation.

A complete 64-bit physical address bus should **not** be routed across a solderless breadboard. The 64-bit CPU interface is represented by the compute module, while the breadboard expansion bus is intentionally narrower.

## 7. Data bus

Initial educational bus:

- D0–D7: primary 8-bit visible bus.
- D8–D15: optional expansion.
- 74HCT245 transceivers.
- 74HCT574 registers.
- LED bus monitor banks.

For a 64-bit logical data path, use the x86-64 module's native interface and expose selected low-speed debug signals instead of trying to route all 64 bits through long breadboard jumpers.

## 8. Front-panel LEDs

Recommended per-bit display:

- 16 red LEDs for address bus.
- 16 yellow LEDs for data/control diagnostics.
- 8 green LEDs for system status.
- 8 blue LEDs for peripheral state.
- 330 Ohm resistor for each LED.

Use buffer ICs between buses and LEDs so the LEDs do not load the logic signals.

## 9. Switches

- 16 address-entry toggle switches.
- 8 data-entry toggle switches.
- LOAD switch.
- EXAMINE switch.
- DEPOSIT switch.
- STEP switch.
- RUN/HALT switch.
- RESET switch.
- NMI/debug switch.

Debounce all mechanical switches before they enter synchronous logic.

## 10. Serial I/O

Use a USB-to-UART or UART bridge module rather than implementing USB directly on the breadboard.

Recommended:

- 3.3 V UART bridge.
- Level shifter if the breadboard subsystem uses 5 V logic.
- UART RX/TX LEDs.
- 1 kOhm LED resistors.
- Optional RS-232 level converter such as a MAX3232 module.

## 11. GPIO

Build a visible GPIO bank from:

- 74HCT574 output register.
- 74HCT244 input buffer.
- 8 toggle switches.
- 8 LEDs.
- 330 Ohm LED resistors.
- 10 kOhm pull resistors.

Map the bank through the conceptual GPIO register block documented in `docs/REGISTER_MAP.md`.

## 12. Timer

The breadboard timer can use:

- 74HC4040 counter.
- 74HC74 divider/latch.
- 74HCT138 decoder.
- 74HCT245 bus interface.
- LED count display.

The software timer model in `lua/devices/timer.lua` mirrors this hardware concept.

## 13. Bus arbitration

For multiple bus masters:

- 74HCT138 request decoder.
- 74HCT157 multiplexers.
- 74HCT245 transceivers.
- 74HCT74 request/acknowledge latches.
- Tri-state enable control.

Never enable two bus drivers onto the same physical bus simultaneously.

## 14. Level shifting

For 5 V ↔ 3.3 V boundaries, use a dedicated level-shifter module or suitable transceiver. Do not assume that every 5 V output is safe for a 3.3 V input.

## 15. Pull resistors

Stock:

- 1 kOhm: LED/current limiting and selected signal conditioning.
- 4.7 kOhm: I2C/open-drain pull-up applications.
- 10 kOhm: switches, resets, enables.
- 47 kOhm: weak configuration pulls.

## 16. Connectors

Provide labelled headers for:

- +5V
- +3V3
- GND
- RESET
- CLOCK
- A[0:15]
- D[0:7]
- RD
- WR
- IOSEL
- MEMSEL
- IRQ
- NMI
- UART TX/RX
- GPIO[0:7]
- DEBUG

## 17. Recommended physical board arrangement

```text
+----------------------------------------------------------------+
| POWER / CLOCK / RESET                                         |
+----------------------+----------------------+------------------+
| ADDRESS BUS          | CONTROL / DECODE     | FRONT PANEL     |
| 74HCT245 / 273       | 138 / 157 / 74xx     | LEDs + switches |
+----------------------+----------------------+------------------+
| DATA BUS             | MEMORY               | GPIO / TIMER    |
| 245 / 574            | SRAM / EEPROM        | 574 / 244 / 4040|
+----------------------+----------------------+------------------+
| UART / SERIAL        | DEBUG / LOGIC ANALYZER| x86-64 MODULE  |
+----------------------+----------------------+------------------+
```

## 18. Build order

1. Build and verify power rails.
2. Add clock and reset.
3. Build one 8-bit register.
4. Build the 8-bit data bus.
5. Add bus transceivers.
6. Add address latches.
7. Add address decoding.
8. Add SRAM.
9. Add GPIO.
10. Add UART.
11. Add front-panel controls.
12. Connect the x86-64 compute module through a documented interface.
13. Validate every signal with a logic analyzer before increasing clock frequency.

## 19. Safety

- Power off before changing wiring.
- Never connect 5 V to a 3.3 V-only input.
- Use current limiting resistors on LEDs.
- Add decoupling capacitors at every logic IC.
- Keep motor/relay loads off the logic rails unless properly isolated.
- Never connect an unknown CPU pin directly to a breadboard rail.
- Verify every connector with a multimeter before attaching the compute module.
