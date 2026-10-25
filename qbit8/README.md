# QBit-8

QBit-8 is the source language for the project's educational 8-bit microcomputer.

## Example

```q8
LDAI 10
LDBI 20
ADD
STA 0x8000
HLT
```

The Lua assembler converts source into 8-bit machine code. The `Micro8CPU` object executes the resulting byte stream against the shared memory and MMIO bus.

## Logic

Branches use CPU flags:

```q8
LDAI 0
JZ zero
LDAI 1
zero:
HLT
```

## Toolchain

```text
.q8 source -> lexer/parser/assembler -> machine bytes -> Micro8CPU -> memory/MMIO
```
