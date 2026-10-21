# Breadboard Netlist

This is the logical netlist for the low-speed educational subsystem. Pin numbers are intentionally omitted because exact IC package variants must be verified against their manufacturer datasheets before physical assembly.

## Power

- `VCC5` -> 5 V logic rail
- `VCC3V3` -> 3.3 V logic rail
- `GND` -> common ground
- `RESET_N` -> active-low system reset
- `CLOCK` -> system clock
- `STEP` -> debounced single-step pulse

## Address bus

- `ADDR0` through `ADDR15`
- `ADDR_HOLD0` through `ADDR_HOLD15`
- `MEMSEL_N`
- `IOSEL_N`
- `DEBUGSEL_N`

## Data bus

- `DATA0` through `DATA7`
- `DATA_DIR`
- `DATA_OE_N`
- `DATA_LATCH`

## Memory control

- `MEMSEL_N`
- `RD_N`
- `WR_N`
- `SRAM_OE_N`
- `SRAM_WE_N`
- `SRAM_CS_N`

## GPIO

- `GPIO0` through `GPIO7`
- `GPIO_DIR`
- `GPIO_OE_N`
- `GPIO_LATCH`

## UART

- `UART_TX`
- `UART_RX`
- `UART_CTS`
- `UART_RTS`

## Interrupt/debug

- `IRQ0`
- `IRQ1`
- `NMI_N`
- `HALT`
- `RUN`
- `TRACE`

## Front panel

- `FP_ADDR_LED0` through `FP_ADDR_LED15`
- `FP_DATA_LED0` through `FP_DATA_LED7`
- `FP_RUN_LED`
- `FP_HALT_LED`
- `FP_RESET_LED`
- `FP_CLOCK_LED`

## Device ownership

| Signal group | Primary owner |
|---|---|
| ADDR0-15 | Address latch/transceiver |
| DATA0-7 | Data transceiver/register |
| MEMSEL_N | Address decoder |
| IOSEL_N | Address decoder |
| GPIO0-7 | GPIO register/buffer |
| UART_TX/RX | UART bridge |
| CLOCK | Clock generator |
| RESET_N | Reset circuit |
| IRQ0/IRQ1 | Peripheral interrupt logic |

## Physical wiring rules

- Use short wires for clock and reset.
- Route ground alongside signal groups where practical.
- Do not share a long jumper between unrelated high-activity signals.
- Label both ends of every jumper.
- Keep the power rails physically separated from noisy external loads.
- Never rely on wire color as the only identifier; use labels and the netlist.
