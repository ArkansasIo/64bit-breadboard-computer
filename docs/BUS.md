# Bus Architecture

## Logical transaction model

This project documents a logical interface. The real bus width, signal polarity, protocol, and timing depend on the selected CPU module.

### Read
1. Requesting master presents an address.
2. Control signals indicate a read.
3. Decoder selects one target.
4. Target returns data or a completion response.
5. Request completes and selects are released.

### Write
1. Master presents address and data.
2. Control signals indicate a write.
3. Decoder selects one target.
4. Target captures data on the specified handshake/clock.
5. Request completes and all drivers release the bus as required.

## Contention

Never allow two outputs to drive a shared bus at once. The electrical interface must explicitly document ownership, enables, direction, voltage levels, turnaround time, and termination.

## Expansion connector (logical suggestion)

- address/data signals required by the chosen platform
- clock only if the bus specification permits it
- reset
- read/write and select/handshake signals
- interrupt request lines
- required supply rails
- multiple grounds

Do not route a full 64-bit high-speed CPU bus over solderless breadboard jumpers by assumption. If the selected module exposes a high-speed memory interconnect, use the specified board and connector rather than treating it as GPIO.