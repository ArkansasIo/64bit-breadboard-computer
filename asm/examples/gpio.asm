; Illustrative MMIO GPIO blink loop. Requires a matching target platform.
bits 64
%include "../include/hardware.inc"

section .text
global _start
_start:
    mov rdx, GPIO_DIR
    mov eax, 0xFF
    mov dword [rdx], eax

.loop:
    mov rdx, GPIO_OUTPUT
    mov eax, 1
    mov dword [rdx], eax
    mov rcx, 1000000
.delay_on:
    dec rcx
    jnz .delay_on

    mov eax, 0
    mov dword [rdx], eax
    mov rcx, 1000000
.delay_off:
    dec rcx
    jnz .delay_off
    jmp .loop