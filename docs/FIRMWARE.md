# Firmware Architecture

## Conceptual boot stages

```text
Platform reset
    |
Platform firmware / reset vector
    |
Initialize required CPU mode and platform services
    |
Basic memory test
    |
Initialize UART and GPIO
    |
Timer/interrupt diagnostics
    |
Monitor / loader / application
```

The exact reset vector, boot mode, ROM image format, and transition to 64-bit long mode depend on the selected platform. The included `asm/boot/stage1.asm` is only a teaching scaffold and is not a drop-in BIOS replacement.

## Suggested power-on self-test codes

| Code | Meaning |
|---:|---|
| 0x01 | CPU started |
| 0x02 | firmware read succeeded |
| 0x03 | memory test passed |
| 0x04 | serial console initialized |
| 0x05 | GPIO test passed |
| 0x06 | timer test passed |
| 0x07 | interrupt test passed |
| 0x0F | system ready |

The display mechanism—LEDs, UART text, or debug register—is platform-specific.