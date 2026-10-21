# Breadboard Build Manual

## Scope

This manual turns the component specification into a physical prototype sequence. It intentionally starts with an 8-bit observable bus and expands toward a 64-bit x86-64 compute module.

## Board allocation

| Board | Function | Suggested contents |
|---|---|---|
| BB1 | Power/clock/reset | regulators, oscillator, reset, Schmitt trigger |
| BB2 | Address low byte | U1-U3 registers/transceivers |
| BB3 | Address high byte | U4-U6 registers/transceivers |
| BB4 | Data bus | U7-U9 transceivers/registers |
| BB5 | Decode/control | U10-U13 decoders, gates |
| BB6 | Memory | SRAM, EEPROM, memory control |
| BB7 | GPIO/timer | GPIO registers, input buffers, counter |
| BB8 | Front panel | LEDs, switches, status logic |

## Designator convention

Use these designators in the physical build and label the IC sockets.

- U1: 74HCT14 clock/reset Schmitt trigger
- U2: 74HC4040 clock divider
- U3: 74HC74 step latch
- U4-U7: 74HCT273/574 address registers
- U8-U10: 74HCT245 bus transceivers
- U11: 74HCT574 data output register
- U12: 74HCT244 data input buffer
- U13-U14: 74HCT138 address decoders
- U15: 74HCT157 multiplexer
- U16-U17: GPIO register/input buffer
- U18: timer counter
- U19: UART/serial interface logic

These are logical designators. Verify exact package pinouts from the selected manufacturer's datasheet before physical wiring.

## Stage 0 — inventory

1. Count all ICs against `hardware/components/IC_BOM.csv`.
2. Inspect every IC for package damage.
3. Install DIP sockets where practical.
4. Label every breadboard rail.
5. Label each signal jumper at both ends.

## Stage 1 — power

1. Disconnect all signal wiring.
2. Set the bench supply to 5 V.
3. Verify polarity.
4. Power each breadboard rail.
5. Measure rail voltage at the far end of every board.
6. Add 0.1 uF decoupling near every IC socket.
7. Add bulk capacitors near each board power entry.

Do not proceed if any rail is outside the selected logic family's permitted supply range.

## Stage 2 — clock

Install U1, U2 and U3.

```text
OSCILLATOR -> U1 SCHMITT -> CLOCK
                         -> U2 DIVIDER
                         -> U3 STEP/ENABLE
```

Verify:

- oscillator frequency
- clean HIGH/LOW levels
- step pulse
- clock enable
- no unintended oscillation

## Stage 3 — reset

Build:

```text
RESET BUTTON
     |
     +---- RC network ---- U1 Schmitt ---- RESET_N
```

Verify that reset is asserted when the button is pressed and that the signal returns cleanly when released.

## Stage 4 — one 8-bit register

Use one 74HCT273 or 74HCT574.

Connect:

```text
DATA0..DATA7 -> register inputs
CLOCK        -> clock input
RESET_N      -> reset input where supported
OE/enable    -> controlled output path if using 574
```

Test with eight switches and eight LEDs through proper current-limiting resistors/buffers.

## Stage 5 — data bus

Install U8-U10 74HCT245 devices.

The transceivers provide:

- bus direction
- bus isolation
- controlled enable
- peripheral separation

Never enable two opposing bus drivers simultaneously.

## Stage 6 — address registers

Install U4-U7.

Use two register banks for A0-A15 initially. Reserve additional banks for future address expansion.

```text
CPU / CONTROL
     |
     v
A0..A15 -> ADDRESS LATCHES -> ADDRESS BUS
```

Verify each bit independently before connecting memory.

## Stage 7 — address decode

Install U13/U14.

Example conceptual decode:

```text
A15..A13
   |
   v
74HCT138
   |
   +---- MEMSEL_N
   +---- IOSEL_N
   +---- DEBUGSEL_N
```

Unused decoder outputs must have defined behavior according to the selected logic family and circuit design.

## Stage 8 — SRAM

Connect the selected SRAM module only after confirming its voltage and pinout.

```text
ADDRESS -> SRAM A inputs
DATA    <-> SRAM D inputs/outputs
MEMSEL  -> /CS
RD      -> /OE
WR      -> /WE
```

Start with very slow transactions.

Test patterns:

- `00`
- `FF`
- `AA`
- `55`
- walking 1
- walking 0
- address-as-data

## Stage 9 — GPIO

Output:

```text
DATA -> U16 register -> LED bank
```

Input:

```text
Switches -> U17 buffer -> DATA
```

Test every GPIO bit individually.

## Stage 10 — timer

Build the timer from U18 and associated control logic.

Test:

- reset to zero
- increment
- rollover
- enable/disable
- interrupt/event output

## Stage 11 — UART

Connect the UART bridge after the digital logic is stable.

Verify voltage levels before connecting a USB host.

Test sequence:

1. idle TX
2. transmit one byte
3. transmit repeated bytes
4. receive one byte
5. loopback
6. sustained low-speed traffic

## Stage 12 — front panel

Install:

- address LEDs
- data LEDs
- clock LED
- reset LED
- run LED
- halt LED
- UART activity LEDs
- GPIO LEDs

All LED banks must be buffered and current-limited.

## Stage 13 — x86-64 compute module

The compute module is connected only after the breadboard subsystem passes electrical validation.

Use a documented module interface such as:

```text
x86-64 module
    |
    +-- UART/debug
    +-- GPIO
    +-- low-speed control
    +-- storage
```

Do not attempt to connect an undocumented processor package directly to the breadboard.

## Stage 14 — logic analyzer

Capture:

- CLOCK
- RESET_N
- MEMSEL_N
- IOSEL_N
- RD_N
- WR_N
- DATA0
- DATA7

Compare the captured waveform sequence against the software model.

## Stage 15 — first program

The first hardware validation program should perform:

```text
RESET
LOAD register
WRITE SRAM
READ SRAM
WRITE GPIO
READ GPIO
TRANSMIT UART
HALT
```

## Troubleshooting

### Bus always reads FF

Check bus enable, direction, pull-ups, SRAM `/CS`, and `/OE`.

### Bus always reads 00

Check output enable, ground reference, data driver direction, and accidental short to ground.

### Random values

Check decoupling, switch bounce, floating inputs, long jumpers, and multiple active bus drivers.

### Reset loops

Check RC timing, Schmitt trigger polarity, supervisor output and power rail stability.

### Clock is unstable

Check oscillator module, ground, supply decoupling and excessive breadboard loading.

## Completion criteria

The breadboard prototype is considered electrically validated when it can:

- power on without excessive current draw
- produce a stable clock
- reset reliably
- latch address data
- transfer data across the bus
- decode memory/I/O selects
- read and write SRAM
- operate GPIO
- operate the timer
- transmit/receive UART data
- display front-panel state
- exchange debug information with the x86-64 compute module
