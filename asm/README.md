# Assembly Source

NASM examples live in `boot/`, `examples/`, and `include/`.

- `examples/fibonacci.asm`: register arithmetic/control-flow example.
- `examples/hello_serial.asm`: illustrative memory-mapped serial output for a custom platform implementing the repository's sample UART registers.
- `examples/gpio.asm`: illustrative GPIO loop for a matching custom platform.
- `boot/stage1.asm`: syntax/demo scaffold, not a usable universal PC boot sector.

Build commands and target-specific limitations are in `../docs/TOOLCHAIN.md` and `../docs/ASSEMBLY.md`. MMIO samples must not be run on an arbitrary host machine.