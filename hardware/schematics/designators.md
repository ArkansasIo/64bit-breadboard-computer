# Hardware Designators and Connector Reference

## IC designators

| Ref | Part | Role |
|---|---|---|
| U1 | 74HCT14 | Clock/reset signal conditioning |
| U2 | 74HC4040 | Clock divider |
| U3 | 74HC74 | Step/control latch |
| U4 | 74HCT273/574 | Address register low |
| U5 | 74HCT273/574 | Address register high |
| U6 | 74HCT273/574 | Address expansion |
| U7 | 74HCT273/574 | Address expansion |
| U8 | 74HCT245 | Data bus transceiver A |
| U9 | 74HCT245 | Data bus transceiver B |
| U10 | 74HCT245 | Peripheral transceiver |
| U11 | 74HCT574 | Data output register |
| U12 | 74HCT244 | Data input buffer |
| U13 | 74HCT138 | Memory decoder |
| U14 | 74HCT138 | I/O decoder |
| U15 | 74HCT157 | Bus/source multiplexer |
| U16 | 74HCT574 | GPIO output register |
| U17 | 74HCT244 | GPIO input buffer |
| U18 | 74HC4040/161 | Timer counter |
| U19 | UART interface | Serial interface |

## Connector designators

| Ref | Name | Signals |
|---|---|---|
| J1 | POWER5 | +5V/GND |
| J2 | POWER3V3 | +3V3/GND |
| J3 | DEBUG | CLOCK/RESET/HALT/TRACE |
| J4 | ADDRESS | A0-A15 |
| J5 | DATA | D0-D7 |
| J6 | CONTROL | RD/WR/MEMSEL/IOSEL |
| J7 | GPIO | GPIO0-GPIO7 |
| J8 | UART | TX/RX/GND |
| J9 | EXPANSION | Future address/data/control |
| J10 | FRONT PANEL | LEDs/switch controls |

## Resistor designators

- R1-R16: address LED current limiting
- R17-R24: data LED current limiting
- R25-R32: status LED current limiting
- R33-R40: switch pull-ups
- R41-R48: reset/control pull-ups
- R49-R64: spare signal conditioning

## Capacitor designators

- C1-C19: 0.1 uF local IC decoupling
- C20-C27: 10 uF board-level bulk bypass
- C28-C31: 470 uF supply bulk filtering
- C32: reset timing capacitor

## Switch designators

- SW1: RESET
- SW2: STEP
- SW3: RUN
- SW4: HALT
- SW5: LOAD
- SW6: EXAMINE
- SW7-SW22: address/data entry switches

## LED designators

- D1-D16: address indicators
- D17-D24: data indicators
- D25-D32: system status
- D33-D40: GPIO/peripheral indicators

## Important implementation note

The designators establish a logical build reference. They do not replace manufacturer datasheets. Before inserting any IC, verify the exact device suffix, package, supply voltage, absolute maximum ratings, input thresholds, output drive limits, and pinout.
