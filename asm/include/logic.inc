%ifndef BREADBOARD_LOGIC_INC
%define BREADBOARD_LOGIC_INC

; Simple boolean/bit logic helpers.
%macro SET_BIT 2
    bts %1, %2
%endmacro

%macro CLEAR_BIT 2
    btr %1, %2
%endmacro

%macro TOGGLE_BIT 2
    btc %1, %2
%endmacro

%macro TEST_BIT 2
    bt %1, %2
%endmacro

%macro MIN_U64 3
    mov %3, %1
    cmp %1, %2
    cmova %3, %2
%endmacro

%macro MAX_U64 3
    mov %3, %1
    cmp %1, %2
    cmovb %3, %2
%endmacro

%macro CLAMP_U64 4
    mov %4, %1
    cmp %4, %2
    cmovb %4, %2
    cmp %4, %3
    cmova %4, %3
%endmacro

%endif
