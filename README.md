# 64-bit x86-64 Breadboard Computer

An educational 64-bit x86-64 computer project built around an x86-64 compute module and a visible breadboard chipset/backplane. The project includes architecture documentation, hardware plans, NASM assembly examples, firmware scaffolding, and UML diagrams.

> **Important architectural constraint:** Building a complete modern x86-64 processor from discrete breadboard logic is not a practical project. This design uses an x86-64 compute module for instruction execution and puts the educational, observable circuitry—clock/reset, interfaces, memory/peripheral decode, GPIO, UART, timers, interrupt routing, test points, and front panel—on modular breadboards.

## Project layout

```text
.
├── README.md
├── LICENSE
├── docs/
│   ├── ARCHITECTURE.md
│   ├── HARDWARE.md
│   ├── BUS.md
│   ├── MEMORY_MAP.md
│   ├── CPU_INTERFACE.md
│   ├── FRONT_PANEL.md
│   ├── FIRMWARE.md
│   ├── ASSEMBLY.md
│   ├── TOOLCHAIN.md
│   ├── DEBUGGING.md
│   ├── BUILD_PLAN.md
│   ├── BOM.md
│   ├── SAFETY.md
│   └── uml/
│       ├── system.puml
│       ├── boot-sequence.puml
│       ├── bus.puml
│       └── software-stack.puml
├── asm/
│   ├── boot/stage1.asm
│   ├── examples/hello_serial.asm
│   ├── examples/gpio.asm
│   ├── examples/fibonacci.asm
│   └── include/hardware.inc
├── firmware/linker.ld
├── hardware/schematics/README.md
├── hardware/wiring/README.md
└── tools/README.md
```

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

## Software

The example source uses NASM syntax. A hosted ELF program can be assembled with:

```bash
nasm -f elf64 program.asm -o program.o
ld program.o -o program
```

A raw ROM image requires a platform-specific linker/packaging flow. The included bootstrap is a scaffold, not a universal x86-64 firmware image. See [docs/TOOLCHAIN.md](docs/TOOLCHAIN.md) and [docs/FIRMWARE.md](docs/FIRMWARE.md).

## Hardware status

This repository defines a design baseline, not a validated pin-by-pin build. Before fabricating or wiring the system, choose the exact x86-64 module and check its datasheets for electrical levels, memory interface, reset, clocks, timing, interrupt behavior, and boot requirements. Do not wire generic logical signals directly to processor pins without an interface specification.

## Documentation

- [Architecture](docs/ARCHITECTURE.md)
- [Hardware design](docs/HARDWARE.md)
- [Bus architecture](docs/BUS.md)
- [Memory map](docs/MEMORY_MAP.md)
- [CPU interface](docs/CPU_INTERFACE.md)
- [Assembly programming](docs/ASSEMBLY.md)
- [Firmware](docs/FIRMWARE.md)
- [Build plan](docs/BUILD_PLAN.md)
- [Bill of materials](docs/BOM.md)
- [Electrical safety](docs/SAFETY.md)
- [UML diagrams](docs/uml/)

## Development phases

1. Select CPU/compute module and freeze electrical interface.
2. Build and validate power, clock, and reset.
3. Add memory and address decode.
4. Add UART and a minimal console.
5. Add GPIO/front-panel controls.
6. Add timer and interrupt tests.
7. Add expansion interfaces and improve diagnostics.
8. Record measurements, photos, exact part numbers, and revisioned schematics.
