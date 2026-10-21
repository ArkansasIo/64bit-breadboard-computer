bits 64
default rel
%include "../include/oop.inc"

section .data
align 8
led_object:
    dq led_vtable
    dq 0x00                   ; state field at +8
    dq 8                      ; LED count at +16

section .rodata
align 8
led_vtable:
    dq led_set
    dq led_get

section .text
global _start

_start:
    lea rdi, [rel led_object]
    mov rsi, 0xA5
    OBJECT_CALL rdi, 0, rax

    OBJECT_CALL rdi, 8, rax
    ; returned state is in RAX

.halt:
    hlt
    jmp .halt

OBJECT_METHOD led_set
    mov [rdi + 8], rsi
    ret

OBJECT_METHOD led_get
    mov rax, [rdi + 8]
    ret
