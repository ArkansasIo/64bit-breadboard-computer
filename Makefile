.PHONY: asm lua test clean

BUILD := build

asm:
	mkdir -p $(BUILD)
	nasm -f elf64 asm/examples/fibonacci.asm -o $(BUILD)/fibonacci.o
	nasm -f elf64 asm/examples/logic.asm -o $(BUILD)/logic.o
	nasm -f elf64 asm/examples/oop_device.asm -o $(BUILD)/oop_device.o
	nasm -f elf64 asm/lib/memory.asm -o $(BUILD)/memory.o
	nasm -f elf64 asm/lib/string.asm -o $(BUILD)/string.o
	nasm -f bin asm/boot/stage1.asm -o $(BUILD)/stage1.bin
	test "$$(wc -c < $(BUILD)/stage1.bin)" -eq 512

lua:
	lua lua/examples/oop_demo.lua
	lua lua/examples/computer_demo.lua

test: asm lua
	lua lua/tests/smoke.lua

clean:
	rm -rf $(BUILD)
