# 64-bit x86-64 Breadboard Computer

An educational 64-bit x86-64 computer project built around an x86-64 compute module and a visible breadboard chipset/backplane. The project includes architecture documentation, hardware plans, NASM assembly, assembly logic macros, an educational Lua object-oriented runtime/model, firmware scaffolding, UML diagrams, CI validation, and an independent 8-bit microcomputer subsystem.

> **Architectural constraint:** A complete modern x86-64 processor implemented from discrete breadboard logic is not a practical build. This project uses an x86-64 compute module for instruction execution and puts the educational, observable circuitry—clock/reset, interfaces, peripheral decode, GPIO, UART, timers, interrupt routing, test points, and front panel—on modular breadboards.

## 8-bit microcomputer

The `lua/micro8/` and `qbit8/` directories implement a complete educational 8-bit CPU model with a 16-bit address bus, 64 KiB memory, registers, flags, stack, branching, arithmetic/bit operations, memory-mapped UART/GPIO/timer, and QBit-8 machine-code assembly.

```bash
lua qbit8/tests/smoke.lua
```

See [8-bit microcomputer architecture](docs/8BIT_MICROCOMPUTER.md) and [QBit-8](qbit8/README.md).

## Project layout

```text
.
├── README.md
├── docs/
│   └── 8BIT_MICROCOMPUTER.md
├── asm/
├── lua/
│   ├── class.lua
│   ├── core/*.lua
│   ├── devices/*.lua
│   └── micro8/
│       ├── memory.lua
│       ├── bus.lua
│       ├── cpu.lua
│       ├── devices.lua
│       └── computer.lua
├── qbit8/
│   ├── assembler.lua
│   ├── README.md
│   ├── examples/*.q8
│   └── tests/smoke.lua
└── hardware/
```

## Assembly programming

The assembly layer is NASM x86-64 syntax. It contains bit logic, min/max/clamp macros, memory/string routines, MMIO examples, and a vtable-style object-oriented assembly example.

```bash
nasm -f elf64 asm/examples/logic.asm -o build/logic.o
nasm -f elf64 asm/examples/oop_device.asm -o build/oop_device.o
```

The MMIO addresses in examples are illustrative and must not be used on an arbitrary PC.

## Lua object-oriented programming

Lua 5.4 provides the high-level model/test layer. `lua/class.lua` implements inheritance with tables and metatables. The 8-bit CPU, memory, bus, computer, UART, GPIO, and timer are also composed as Lua objects.

```bash
lua lua/examples/oop_demo.lua
lua lua/tests/smoke.lua
lua qbit8/tests/smoke.lua
```

The Lua 64-bit CPU remains an intentionally small educational model and does not implement the complete Intel 64 ISA.

## Build and test

```bash
make test
```

GitHub Actions assembles the NASM sources, checks the bootstrap scaffold, and runs Lua examples and smoke tests.

## Documentation

- [8-bit microcomputer architecture](docs/8BIT_MICROCOMPUTER.md)
- [QBit-8 language](qbit8/README.md)
- [Project status and implementation roadmap](docs/PROJECT_STATUS_AND_ROADMAP.md)
- [Test and validation strategy](docs/TEST_AND_VALIDATION_STRATEGY.md)
- [Lua model API](docs/LUA_MODEL_API.md)
