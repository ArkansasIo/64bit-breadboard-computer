# x86-64 Assembly Logic Library

The project includes reusable NASM macros for boolean operations and simple integer selection.

## Bit operations

- `SET_BIT value, bit`
- `CLEAR_BIT value, bit`
- `TOGGLE_BIT value, bit`
- `TEST_BIT value, bit`

These expand to x86 bit-test instructions such as `BTS`, `BTR`, `BTC`, and `BT`.

## Selection helpers

- `MIN_U64 a, b, dst`
- `MAX_U64 a, b, dst`
- `CLAMP_U64 value, min, max, dst`

They use `CMP` plus conditional moves to avoid branches in simple hot paths.

## Object-oriented assembly

`oop.inc` defines a minimal object/vtable convention:

```text
object +0  = vtable pointer
object +8  = first field
object +16 = second field
...

RDI = self
RSI/RDX/... = method arguments
```

The example `asm/examples/oop_device.asm` implements `set()` and `get()` methods through a vtable.