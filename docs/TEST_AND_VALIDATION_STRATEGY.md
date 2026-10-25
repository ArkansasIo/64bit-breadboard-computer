# Test and validation strategy

## Goals

Validate source artifacts separately from physical hardware. Tests must be repeatable and must not access real hardware addresses during host-side execution.

## Software test layers

### Assembly checks
- Assemble every standalone NASM example.
- Fail on missing include files or malformed instructions.
- Confirm the bootstrap scaffold is exactly 512 bytes.
- Treat that size check as a format/scaffold check only, not evidence of PC boot compatibility.

### Lua model checks
- Memory reads and writes at valid addresses.
- Rejection of out-of-range addresses and invalid values.
- Little-endian behavior for multi-byte reads/writes.
- CPU reset, instruction-pointer progression, NOP, and HLT behavior.
- Unknown opcode behavior is explicit and tested.
- Bus/device integration tests for mapped registers.

### Repository integrity
- README links resolve to tracked files/directories.
- All referenced Lua entry points exist.
- All `.asm` includes resolve in CI.
- Generated files stay outside source control.

## Hardware test gates

Only run these after the exact module, power supply, levels, connectors, and protection circuit have been selected and reviewed.

| Gate | Evidence required |
| --- | --- |
| Power-off inspection | Visual inspection and continuity checks recorded |
| Power rails | Measured voltage, ripple, polarity, current limit, and conditions |
| Reset/clock | Measured timing against the selected module's datasheet |
| UART | Known loopback or console exchange |
| GPIO | Input/output state verified through a buffered interface |
| Timer/interrupt | Measured signal and documented processor-side handling |
| End-to-end | Repeatable boot/application test with logs and board revision |

## Failure reporting

Every hardware issue should include board revision, part numbers, wiring/schematic revisions, instruments, test conditions, observed values, expected values, and whether the test is safe to repeat. Do not mark hardware acceptance tests as passed without measurements.

## Safety

Never assume modern CPU pins tolerate generic breadboard voltage levels or slow/manual clock signals. Use the module manufacturer's specifications and appropriate level translation, buffering, current limiting, and ESD protection. Work with power removed while changing wiring.
