# 8-Bit Microcomputer

The repository now contains an independent educational 8-bit microcomputer model alongside the 64-bit design.

## Architecture

- 8-bit data path
- 16-bit address bus and 64 KiB address space
- Registers A, B, C, D; PC; SP; FLAGS
- ROM, RAM, UART, GPIO and timer
- Object-oriented Lua implementation
- QBit-8 source language and assembler
- Deterministic emulator and machine-code tools

## Memory map

```text
0000-7FFF  ROM
8000-EFFF  RAM
F000-F0FF  UART
F100-F1FF  GPIO
F200-F2FF  TIMER
FF00-FFFF  RAM/stack
```

## ISA

```text
00 NOP       01 LDA #imm   02 LDB #imm   03 LDC #imm
04 LDD #imm  05 LDA addr   06 STA addr   07 ADD B
08 SUB B     09 AND B      0A OR B       0B XOR B
0C INC A     0D DEC A      0E JMP addr   0F JZ addr
10 JNZ addr  11 JC addr    12 JNC addr   13 CMP B
14 OUT addr  15 IN addr    16 PUSH A     17 POP A
18 CALL addr 19 RET        1A SHL A      1B SHR A
1C ROL A     1D ROR A      1E HLT
```

This is a project-specific educational CPU, not an emulation of a commercial processor.