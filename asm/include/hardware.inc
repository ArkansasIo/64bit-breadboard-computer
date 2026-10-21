; Logical MMIO constants for the educational design.
; These are illustrative addresses only. Do not use on a real system
; until the peripheral map is implemented and verified.

%define UART_BASE   0xF0000000
%define GPIO_BASE   0xF0001000
%define TIMER_BASE  0xF0002000
%define DEBUG_BASE  0xF0003000

%define UART_DATA   (UART_BASE + 0x00)
%define UART_STATUS (UART_BASE + 0x04)

%define GPIO_OUTPUT (GPIO_BASE + 0x00)
%define GPIO_INPUT  (GPIO_BASE + 0x04)
%define GPIO_DIR    (GPIO_BASE + 0x08)