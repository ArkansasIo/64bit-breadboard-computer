bits 64
section .text

global strlen
; size_t strlen(const char *s), RDI -> string, RAX = length
strlen:
    xor rax, rax
.loop:
    cmp byte [rdi + rax], 0
    je .done
    inc rax
    jmp .loop
.done:
    ret

global memcmp8
; int memcmp8(a,b,n), RDI=a, RSI=b, RDX=n
memcmp8:
    xor rcx, rcx
.loop:
    cmp rcx, rdx
    jae .equal
    mov al, [rdi + rcx]
    mov r8b, [rsi + rcx]
    cmp al, r8b
    jb .less
    ja .greater
    inc rcx
    jmp .loop
.less:
    mov eax, -1
    ret
.greater:
    mov eax, 1
    ret
.equal:
    xor eax, eax
    ret
