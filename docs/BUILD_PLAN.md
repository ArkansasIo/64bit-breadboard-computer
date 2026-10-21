# Build Plan

## Phase 0 — Freeze requirements
- choose an actual x86-64 compute module/platform
- inspect its manuals and available interfaces
- freeze voltage domains, connectors, reset and clock design
- validate whether external ROM/RAM or MMIO devices are supported

## Phase 1 — Power and reset
- build regulated, current-limited power
- validate power-good/reset supervisor
- measure rails and reset sequencing

## Phase 2 — Interface and observation
- build adapter only for documented signals
- add labeled test points and safe buffering
- validate continuity and voltage levels

## Phase 3 — Firmware/memory
- use the platform's supported boot chain
- implement diagnostic output
- run memory tests through supported interfaces

## Phase 4 — Peripheral boards
- add UART
- add GPIO/front panel
- add timer and interrupt path where supported

## Phase 5 — Software
- assembler examples
- platform-specific linker/ROM packaging
- POST tests
- monitor and diagnostic utilities

## Phase 6 — Verification and documentation
- capture scope traces and measurements
- record part numbers and revisions
- publish verified schematics and wiring only after validation
- automate syntax/static tests in CI