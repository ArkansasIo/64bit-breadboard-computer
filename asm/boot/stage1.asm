; Educational bootstrap scaffold only.
; A real x86-64 ROM image must match the selected platform's boot process.
; This file is not a universal BIOS, UEFI application, or PC boot sector.

bits 16
org 0

start:
    cli
    xor ax, ax
    mov ds, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Insert platform-specific boot protocol and mode-transition code here.
hang:
    hlt
    jmp hang

times 512-($-$$) db 0