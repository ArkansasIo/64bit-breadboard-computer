# Lua Runtime and Object-Oriented Layer

Lua is used as the high-level scripting language for the educational monitor, emulator/test harness, board description, and automation layer.

The project uses Lua tables plus metatables for object-oriented programming. Hardware-facing code stays explicit and deterministic; Lua does not directly imply access to physical CPU pins.

## Layout

```text
lua/
├── class.lua
├── core/
│   ├── computer.lua
│   ├── cpu.lua
│   ├── bus.lua
│   └── memory.lua
├── devices/
│   ├── uart.lua
│   ├── gpio.lua
│   └── timer.lua
├── monitor.lua
├── examples/
│   ├── oop_demo.lua
│   └── computer_demo.lua
└── tests/
    └── smoke.lua
```

Run with a Lua 5.4 interpreter:

```bash
lua lua/examples/oop_demo.lua
lua lua/tests/smoke.lua
```
