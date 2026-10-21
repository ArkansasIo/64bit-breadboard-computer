# Toolchain

## Suggested tools

- NASM assembler
- GNU binutils or LLVM tools
- objcopy/objdump
- serial terminal
- Git
- emulator/test harness
- multimeter, oscilloscope, and logic analyzer for hardware bring-up

## Common commands

```bash
nasm -f elf64 program.asm -o program.o
ld program.o -o program
objdump -d program
objcopy -O binary firmware.elf firmware.bin
```

The final command is valid only when the ELF and link addresses match the selected firmware layout. Confirm the output image format with the boot platform.

## Workflow

```text
Assembly source -> NASM -> ELF/object -> linker
                                  |          |
                              disassemble  firmware image
                                             |
                                        emulator/test
                                             |
                                          hardware
```