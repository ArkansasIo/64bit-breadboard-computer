# Physical Breadboard Bank Map

## BB1 — Power, Clock and Reset

```text
LEFT RAIL     +5V
RIGHT RAIL    GND
TOP           oscillator
CENTER        U1/U2/U3
BOTTOM        reset / status
```

Signals: `VCC5`, `VCC3V3`, `GND`, `CLOCK`, `STEP`, `RESET_N`, `RUN`, `HALT`.

## BB2 — Address Low

Contains U4 and U8-side isolation.

Signals:

`A0-A7`, `ADDR_LATCH`, `ADDR_OE_N`, `ADDR_DIR`.

## BB3 — Address High

Contains U5 and expansion address logic.

Signals:

`A8-A15`, `ADDR_LATCH`, `ADDR_OE_N`, `ADDR_DIR`.

## BB4 — Data Bus

Contains U8-U12.

Signals:

`D0-D7`, `DATA_DIR`, `DATA_OE_N`, `DATA_LATCH`.

## BB5 — Decode and Control

Contains U13-U15.

Generates:

- `MEMSEL_N`
- `IOSEL_N`
- `DEBUGSEL_N`
- `RD_N`
- `WR_N`
- peripheral enables

## BB6 — Memory

Contains the selected SRAM and optional EEPROM/FRAM.

Keep the memory board physically close to the address and data buses.

## BB7 — Peripheral Board

Contains:

- GPIO output register
- GPIO input buffer
- timer counter
- UART interface

## BB8 — Front Panel

Contains:

- address LEDs
- data LEDs
- status LEDs
- switches
- mode controls

## Expansion board

Reserve a future board for:

- additional address width
- additional data banks
- DMA experiments
- interrupt controller
- SPI/I2C peripherals

## Physical layout rule

Place boards in signal-flow order:

```text
POWER -> CLOCK -> ADDRESS -> DATA -> DECODE -> MEMORY -> I/O -> FRONT PANEL
```

The x86-64 compute module should be physically separated from the long breadboard bus wiring and connected through a short, documented interface.
