# Lua Object-Oriented Architecture

## Why Lua?

Lua provides a small, embeddable control language for the project's emulator, monitor, board configuration, and test automation. It is not used to pretend that a modern x86-64 processor can be electrically controlled through arbitrary Lua statements.

## Class model

The project uses a `Class.define(name, base)` helper. Classes are tables with metatables; instances inherit methods through `__index`.

```lua
local Device = Class.define('Device')
function Device:init(name) self.name = name end

local UART = Class.define('UART', Device)
function UART:send(byte) ... end

local console = UART('console')
```

## Object hierarchy

```text
Device
├── UART
├── GPIO
├── Timer
└── MemoryMappedDevice

Computer
├── CPU
├── Bus
├── Memory
└── Devices
```

## Design rules

- Keep device state inside objects.
- Expose explicit `read8`/`write8` or equivalent interfaces.
- Keep address decoding in the bus.
- Keep CPU emulation separate from physical hardware drivers.
- Make test doubles replaceable.
- Fail loudly on unmapped addresses.

## OOP in assembly

`asm/include/oop.inc` demonstrates a vtable-style object layout compatible with normal x86-64 calling conventions. This is educational and does not require a C++ compiler.