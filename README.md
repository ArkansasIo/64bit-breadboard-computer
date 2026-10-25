# 64-bit x86-64 Breadboard Computer

An educational 64-bit x86-64 computer project built around an x86-64 compute module and a visible breadboard chipset/backplane. The project includes architecture documentation, hardware plans, NASM assembly, assembly logic macros, an educational Lua object-oriented runtime/model, firmware scaffolding, UML diagrams, and CI validation.

> **Architectural constraint:** A complete modern x86-64 processor implemented from discrete breadboard logic is not a practical build. This project uses an x86-64 compute module for instruction execution and puts the educational, observable circuitry—clock/reset, interfaces, peripheral decode, GPIO, UART, timers, interrupt routing, test points, and front panel—on modular breadboards.

## Project layout

```text
.
├── README.md
├── LICENSE
├── Makefile
├── CONTRIBUTING.md
├── docs/
│   ├── ARCHITECTURE.md
│   ├── HARDWARE.md
│   ├── BUS.md
│   ├── MEMORY_MAP.md
│   ├── REGISTER_MAP.md
│   ├── CPU_INTERFACE.md
│   ├── FRONT_PANEL.md
│   ├── FIRMWARE.md
│   ├── ASSEMBLY.md
│   ├── ASM_LOGIC.md
│   ├── LUA_OOP.md
│   ├── TOOLCHAIN.md
│   ├── DEBUGGING.md
│   ├── BUILD_PLAN.md
│   ├── BOM.md
│   ├── SAFETY.md
│   ├── VALIDATION.md
│   ├── SOURCE_TREE.md
│   └── uml/*.puml
├── asm/
│   ├── boot/stage1.asm
│   ├── examples/
│   │   ├── fibonacci.asm
│   │   ├── gpio.asm
│   │   ├── hello_serial.asm
│   │   ├── logic.asm
│   │   └── oop_device.asm
│   ├── include/
│   │   ├── hardware.inc
│   │   ├── logic.inc
│   │   └── oop.inc
│   └── lib/
│       ├── memory.asm
│       └── string.asm
├── lua/
│   ├── class.lua
│   ├── monitor.lua
│   ├── core/*.lua
│   ├── devices/*.lua
│   ├── examples/*.lua
│   └── tests/smoke.lua
├── firmware/linker.ld
├── hardware/
└── tools/
```

## Assembly programming

The assembly layer is NASM x86-64 syntax. It contains bit logic, min/max/clamp macros, memory/string routines, MMIO examples, and a vtable-style object-oriented assembly example.

```bash
nasm -f elf64 asm/examples/logic.asm -o build/logic.o
nasm -f elf64 asm/examples/oop_device.asm -o build/oop_device.o
```

The MMIO addresses in examples are illustrative and must not be used on an arbitrary PC.

## Lua object-oriented programming

Lua 5.4 provides the high-level model/test layer. `lua/class.lua` implements a small inheritance helper using tables and metatables. CPU, bus, memory, UART, GPIO, timer, monitor, and computer objects are composed under `lua/core/` and `lua/devices/`.

```bash
lua lua/examples/oop_demo.lua
lua lua/tests/smoke.lua
```

The Lua CPU is intentionally a small educational model and does **not** implement the complete Intel 64 ISA. The physical system still requires a real x86-64 compute module.

## Build and test

```bash
make test
```

GitHub Actions assembles the NASM sources, checks the 512-byte bootstrap scaffold, and runs the Lua examples and smoke test.

## System overview

```text
                  +---------------------+
                  |    x86-64 CPU       |
                  |  64-bit execution   |
                  +----------+----------+
                             |
                   CPU interface adapter
                             |
                  +----------v----------+
                  |  Breadboard chipset |
                  | decode / reset / IRQ|
                  +----+----+----+------+
                       |    |    |
                      ROM  RAM  Peripherals
                               |   |   |
                             UART GPIO TIMER
                               |
                         Front panel/debug
```

## Hardware status

This repository defines a design baseline, not a validated pin-by-pin build. Before fabrication, select the exact x86-64 module and verify its electrical levels, memory interface, reset, clocks, timing, interrupt behavior, thermal requirements, and boot requirements from its manufacturer documentation. Never wire generic logical signals directly to processor pins without a verified interface design.

## Documentation

- [Project status and implementation roadmap](docs/PROJECT_STATUS_AND_ROADMAP.md)
- [Test and validation strategy](docs/TEST_AND_VALIDATION_STRATEGY.md)
- [Architecture](docs/ARCHITECTURE.md)
- [Hardware](docs/HARDWARE.md)
- [Bus](docs/BUS.md)
- [Memory map](docs/MEMORY_MAP.md)
- [Register map](docs/REGISTER_MAP.md)
- [CPU interface](docs/CPU_INTERFACE.md)
- [Assembly](docs/ASSEMBLY.md)
- [Assembly logic](docs/ASM_LOGIC.md)
- [Lua OOP](docs/LUA_OOP.md)
- [Firmware](docs/FIRMWARE.md)
- [Build plan](docs/BUILD_PLAN.md)
- [Validation](docs/VALIDATION.md)
- [Source tree](docs/SOURCE_TREE.md)
- [UML diagrams](docs/uml/)

## Development phases

1. Select CPU/compute module and freeze electrical interface.
2. Build and validate power, clock, and reset.
3. Add memory and address decode.
4. Add UART and minimal console.
5. Add GPIO/front-panel controls.
6. Add timer and interrupt tests.
7. Add expansion interfaces and diagnostics.
8. Record measurements, photos, exact part numbers, and revisioned schematics.
