# Project status and implementation roadmap

This repository is an educational design baseline. The current software checks validate assembly syntax, selected Lua model behavior, and a 512-byte bootstrap scaffold; they do not establish that a physical computer is operational.

## Implemented source areas

- NASM x86-64 assembly examples and helper macros
- A small Lua CPU/computer model
- Interface, memory-map, register-map, hardware, assembly, and validation documentation
- Breadboard schematic notes, a component inventory, and a wiring netlist
- GitHub Actions source checks

## Important scope boundaries

1. The Lua CPU is a small educational interpreter/model, not a complete Intel 64 emulator.
2. `asm/boot/stage1.asm` is a 512-byte scaffold, not a general-purpose PC boot sector or BIOS.
3. The memory map, register map, and wiring descriptions are proposed logical abstractions until the exact compute module and peripheral parts have been selected and verified.
4. A successful CI run is not hardware validation.

## Recommended implementation sequence

### Phase 1 — Reproducible software checks
- Keep NASM and Lua checks deterministic.
- Test memory boundaries and 64-bit values.
- Test every supported CPU-model opcode and halt/reset behavior.
- Add checks that all README links and referenced files exist.
- Publish build artifacts with exact tool versions.

### Phase 2 — Freeze the hardware target
- Select the x86-64 compute module and cite its official datasheet.
- Record supply rails, I/O voltage levels, reset requirements, boot process, and interfaces.
- Choose level translators/buffers and protection before connecting any signals.
- Replace generic placeholder addresses with a revisioned peripheral register map.

### Phase 3 — Bring-up modules independently
- Power regulation and protection, measured before inserting the compute module.
- Reset supervisor and status indicators.
- UART console and GPIO, each independently tested.
- Timer and interrupt signaling, only when supported by the selected module.
- Add test points and document measured waveforms.

### Phase 4 — Release readiness
- Version schematics, BOM, assembly instructions, firmware, and software together.
- Keep a bring-up log with equipment, conditions, measured values, and pass/fail criteria.
- Distinguish simulated, assembled, electrically tested, and operational status in release notes.

## Definition of done

A software milestone passes only when the CI checks succeed. A hardware milestone passes only when the selected design's electrical requirements and each acceptance test are measured and documented. Do not treat the design as ready to power on based only on the repository's logical netlist.
