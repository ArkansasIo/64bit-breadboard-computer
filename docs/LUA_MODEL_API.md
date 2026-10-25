# Lua model API and opcode contract

## Purpose

The Lua subsystem is a deterministic educational model for demonstrating memory access, a tiny fetch/decode/execute loop, and peripheral mapping. It is not an Intel 64 emulator and must not be used as a hardware control implementation without a separately reviewed interface layer.

## Memory contract

- Memory addresses are zero-based byte offsets in the simulated RAM array.
- `read8`/`write8` operate on one byte.
- `read64`/`write64` operate on eight bytes in little-endian order.
- Accesses must fit completely inside the allocated simulated RAM.
- Peripheral MMIO addresses in `Computer` are on the simulated bus and are not host physical addresses.

## CPU-model contract

The current interpreter supports the following opcodes only:

| Opcode | Name | Model behavior |
| --- | --- | --- |
| `0x90` | NOP | Advances RIP and increments model cycle count |
| `0xF4` | HLT | Advances RIP, marks the model halted, and increments model cycle count |

Any other byte currently raises an explicit unsupported-opcode error. Register fields are placeholders for future educational exercises; this subset does not decode real x86-64 instruction encodings generally.

## Reset and execution

`Computer:reset(entry)` resets the modeled CPU's halt flag, cycle count, RIP, and RFLAGS. `Computer:tick()` executes at most one modeled instruction if the CPU is not halted and advances the simulated timer once.

## Adding an opcode safely

1. Document the subset semantics here.
2. Implement one opcode path with explicit fetch length and state transitions.
3. Add a smoke assertion for RIP, affected registers/memory, halt behavior, and cycle count.
4. Add malformed/unsupported input tests.
5. Keep all examples deterministic and independent of the host machine's physical MMIO.
