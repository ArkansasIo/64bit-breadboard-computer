bits 64
default rel
%include "../include/logic.inc"

section .text
global _start

_start:
    mov rax, 0b1010
    SET_BIT rax, 0
    CLEAR_BIT rax, 3
    TOGGLE_BIT rax, 1

    mov rbx, 100
    mov rcx, 42
    MIN_U64 rbx, rcx, rdx      ; RDX = 42
    MAX_U64 rbx, rcx, r8       ; R8  = 100
    CLAMP_U64 rbx, 50, 90, r9  ; R9  = 90

.halt:
    hlt
    jmp .halt
