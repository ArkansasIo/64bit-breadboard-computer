# Breadboard Computer Wiring Architecture

## System blocks

```text
             +-------------------+
             |  POWER + RESET    |
             |  5V / 3V3 / GND   |
             +---------+---------+
                       |
                +------v------+
                | CLOCK / STEP|
                +------+------+
                       |
        +--------------+---------------+
        |                              |
+-------v--------+              +------v-------+
| ADDRESS LATCH  |              | DATA REG     |
| 273 / 574      |              | 574          |
+-------+--------+              +------+-------+
        |                              |
+-------v--------+              +------v-------+
| ADDRESS DECODE |              | DATA TRANS   |
| 138 / 139      |              | 245          |
+-------+--------+              +------+-------+
        |                              |
        +--------------+---------------+
                       |
                +------v------+
                | SRAM / I/O  |
                +------+------+ 
                       |
       +---------------+----------------+
       |               |                |
+------v-----+   +-----v------+   +-----v------+
| GPIO       |   | UART       |   | TIMER      |
| 574 / 244  |   | UART bridge|   | 4040 / 74xx|
+------------+   +------------+   +------------+

             +----------------------+
             | x86-64 COMPUTE      |
             | MODULE / SBC        |
             +----------------------+
```

## Bus rules

1. Only one active driver may drive a shared bus at a time.
2. Every IC receives local 0.1 uF decoupling.
3. All modules share a defined ground reference.
4. 3.3 V signals must remain within the receiving device's limits.
5. Long breadboard wires are for low-speed educational buses only.
6. The x86-64 module connects through a documented low-speed/debug interface.

## Address section

Initial address width: A0-A15.

- 74HCT273/574 devices latch address bytes.
- 74HCT245 provides controlled bus isolation.
- 74HCT138 decodes high address bits into memory/I/O selects.
- LEDs are driven from buffers, not directly from the address bus.

## Data section

Initial visible data width: D0-D7.

- 74HCT245 controls direction.
- 74HCT574 captures data.
- 74HCT244 isolates input devices.
- Additional 8-bit banks may extend the visible bus.

## Memory section

Use a parallel SRAM module for the first working prototype. Connect:

- A0-A15 -> SRAM address inputs.
- D0-D7 -> SRAM data inputs/outputs through a transceiver.
- `/CS` -> decoded memory select.
- `/OE` -> read control.
- `/WE` -> write control.

Check the exact SRAM module voltage and timing before wiring it.

## GPIO section

Output path:

`Bus -> 74HCT574 -> LED/resistor bank`

Input path:

`Switch bank -> pull resistors -> 74HCT244 -> Bus`

## UART section

`Breadboard UART -> level shifter if needed -> USB-UART bridge -> development PC`

Use a 3.3 V-safe bridge and verify logic levels before connecting.

## Front panel

Expose:

- address LEDs
- data LEDs
- clock LED
- reset LED
- run/halt LED
- UART activity LEDs
- GPIO LEDs
- STEP/RUN/HALT/RESET switches

## Bring-up procedure

### Stage 1 — power

Measure +5 V and +3.3 V rails with no ICs installed.

### Stage 2 — clock

Install the oscillator and verify frequency with an oscilloscope or logic analyzer.

### Stage 3 — reset

Verify reset assertion and release.

### Stage 4 — one register

Build one 8-bit register and prove load/hold behavior.

### Stage 5 — bus

Add one transceiver and test direction/enable controls.

### Stage 6 — decoder

Add one 74HCT138 and validate all select outputs.

### Stage 7 — memory

Attach SRAM and perform read/write tests at low speed.

### Stage 8 — peripherals

Add GPIO, timer, and UART one subsystem at a time.

### Stage 9 — compute module

Only after the breadboard subsystem is electrically verified should the x86-64 module be connected.
