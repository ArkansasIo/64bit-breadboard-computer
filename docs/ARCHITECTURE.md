# System Architecture

## Layering

1. **Execution:** x86-64 processor executes the Intel 64 instruction set.
2. **CPU interface:** adapter for the selected compute module, including voltage translation and connectors where necessary.
3. **Chipset:** clock/reset observation, address decode, transaction monitoring, interrupt routing, and peripheral select.
4. **Memory:** boot ROM/flash and system RAM.
5. **Peripherals:** serial console, GPIO, timer, debug registers, expansion.
6. **Front panel:** run/reset/step controls and status LEDs.

## Block diagram

```text
+-------------+     +-----------------+     +-------------------+
| x86-64 CPU  |---->| Interface board |---->| Breadboard chipset|
+-------------+     +-----------------+     +----+----+----+----+
                                                   |    |    |
                                                  ROM  RAM  I/O
                                                           |
                                               +-----------+---------+
                                               |           |         |
                                             UART        GPIO      TIMER
                                               |           |         |
                                              Host       LEDs      IRQ route
```

## Logical address map

The initial proposed map is documented in [MEMORY_MAP.md](MEMORY_MAP.md). It must be adjusted to the selected platform's actual physical memory layout.

## Clock and reset

Use a reset supervisor and documented clock source. A manual single-step clock is useful only for low-speed logic in a compatible interface; it must not be assumed safe for a modern CPU clock input. CPU clocking must follow the module's electrical and timing requirements.

## Interrupts

Candidate peripheral sources are UART receive, timer expiration, and GPIO input. Actual routing depends on the processor module and its interrupt architecture.

## Front panel

Expose power-good, reset, clock activity, memory/I/O activity, UART activity, interrupt, fault, and GPIO state with LEDs or a logic analyzer header. Use buffered indicators where loading could disturb a signal.