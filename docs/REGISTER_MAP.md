# Peripheral Register Map (Illustrative)

These register offsets define a sample software interface only. A physical peripheral implementation and address decoder must be built and validated before use.

## UART base `0xF0000000`
| Offset | Name | Proposed purpose |
|---:|---|---|
| `0x00` | DATA | transmit/receive byte |
| `0x04` | STATUS | ready/busy flags |
| `0x08` | CONTROL | enable and interrupt control |
| `0x0C` | BAUD | baud divisor/configuration |

## GPIO base `0xF0001000`
| Offset | Name | Proposed purpose |
|---:|---|---|
| `0x00` | OUTPUT | output data |
| `0x04` | INPUT | sampled inputs |
| `0x08` | DIRECTION | per-bit direction |
| `0x0C` | CONTROL | mode/interrupt configuration |

## Timer base `0xF0002000`
| Offset | Name | Proposed purpose |
|---:|---|---|
| `0x00` | COUNT | current count |
| `0x04` | RELOAD | reload value |
| `0x08` | CONTROL | enable/prescale/interrupt |
| `0x0C` | STATUS | pending/expired flags |

Do not use these addresses in software until the custom memory map, access width, ordering, and register semantics are implemented.