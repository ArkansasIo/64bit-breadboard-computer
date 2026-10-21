# Source Tree

```text
64bit-breadboard-computer/
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
├── firmware/linker.ld
├── lua/
│   ├── class.lua
│   ├── monitor.lua
│   ├── core/
│   │   ├── bus.lua
│   │   ├── computer.lua
│   │   ├── cpu.lua
│   │   └── memory.lua
│   ├── devices/
│   │   ├── gpio.lua
│   │   ├── timer.lua
│   │   └── uart.lua
│   ├── examples/
│   │   ├── computer_demo.lua
│   │   └── oop_demo.lua
│   └── tests/smoke.lua
├── hardware/
│   ├── schematics/README.md
│   └── wiring/README.md
├── docs/
│   ├── architecture and hardware documents
│   ├── ASM_LOGIC.md
│   ├── LUA_OOP.md
│   ├── REGISTER_MAP.md
│   ├── VALIDATION.md
│   └── uml/*.puml
├── Makefile
└── .github/workflows/assembly-check.yml
```

The Lua CPU is intentionally a small educational model; it is not an implementation of the complete Intel 64 architecture. The physical build uses a real x86-64 execution module and a separately documented breadboard chipset.