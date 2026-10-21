bits 64
section .text

global mem_copy64
global mem_set64

; void mem_copy64(void *dst, const void *src, size_t qwords)
; SysV: RDI=dst, RSI=src, RDX=count
mem_copy64:
    test rdx, rdx
    jz .done
.loop:
    mov rax, [rsi]
    mov [rdi], rax
    add rsi, 8
    add rdi, 8
    dec rdx
    jnz .loop
.done:
    ret

; void mem_set64(void *dst, uint64_t value, size_t qwords)
; SysV: RDI=dst, RSI=value, RDX=count
mem_set64:
    test rdx, rdx
    jz .done
.loop:
    mov [rdi], rsi
    add rdi, 8
    dec rdx
    jnz .loop
.done:
    ret
