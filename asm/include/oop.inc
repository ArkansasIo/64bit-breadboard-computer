%ifndef BREADBOARD_OOP_INC
%define BREADBOARD_OOP_INC

; A lightweight C++-style object layout:
; object[0] = vtable pointer
; object[8..] = instance fields
;
; Method ABI: RDI = self, then normal System V AMD64 arguments.

%macro OBJECT_VTABLE 1
    section .rodata
%1:
%endmacro

%macro OBJECT_CALL 3
    ; object register, vtable slot byte offset, destination scratch register
    mov %3, [%1]
    call [%3 + %2]
%endmacro

%macro OBJECT_METHOD 1
%1:
    ; RDI contains self
%endmacro

%macro OBJECT_FIELD 3
    ; destination, object register, byte offset
    mov %1, [%2 + %3]
%endmacro

%endif
