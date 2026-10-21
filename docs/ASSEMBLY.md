# x86-64 Assembly Programming

Examples use NASM syntax. Register examples include RAX, RBX, RCX, RDX, RSI, RDI, RBP, RSP, R8–R15, RIP, and RFLAGS.

## Arithmetic

```asm
mov rax, 42
mov rbx, 8
add rax, rbx        ; RAX = 50
```

## Assemble and link a hosted ELF program

```bash
nasm -f elf64 program.asm -o program.o
ld program.o -o program
```

This produces a hosted executable only when the source includes appropriate process/ABI entry and exit behavior. Hardware firmware has a different entry point, linker layout, privilege/mode setup, and I/O mechanism.

## Memory-mapped I/O

If a platform actually maps a device at a physical address, software can access its register through a pointer in the correct CPU mode. The MMIO address and register width must come from the verified hardware design. Do not run the sample MMIO programs on an arbitrary PC: the example addresses are illustrative and may fault or target unrelated memory.

## Learning order

Registers and flags; arithmetic; branches; stack; calls and returns; addressing; ABI; interrupts; MMIO; linker scripts; firmware entry; protected mode and long mode; emulator/test harness.