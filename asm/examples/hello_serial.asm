; Illustrative MMIO sample; requires a platform which implements the
; register map in ../include/hardware.inc. Not safe to run on an arbitrary PC.
bits 64
default rel

%include "../include/hardware.inc"

section .text
global _start

_start:
    lea rsi, [rel message]
.next:
    lodsb
    test al, al
    jz .halt

.wait:
    mov rdx, UART_STATUS
    mov eax, dword [rdx]
    test eax, 1                 ; example: TX-ready bit
    jz .wait

    mov rdx, UART_DATA
    mov byte [rdx], al
    jmp .next

.halt:
    cli
.loop:
    hlt
    jmp .loop

section .rodata
message db "X86-64 BREADBOARD", 13, 10, 0