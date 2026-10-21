; Compute 20 Fibonacci steps in registers.
; The final result is left in RBX. This is a bare-metal example, not an OS ABI program.
bits 64
section .text
global _start
_start:
    xor rax, rax        ; F(0)
    mov rbx, 1          ; F(1)
    mov rcx, 20
.loop:
    mov rdx, rax
    add rdx, rbx
    mov rax, rbx
    mov rbx, rdx
    dec rcx
    jnz .loop
.halt:
    hlt
    jmp .halt