# Debugging and Bring-up

## Recommended order

1. **Power:** check polarity, rail voltages, current draw, and shorts with a current-limited supply.
2. **Clock/reset:** verify signals with a scope; ensure manual stepping is used only where electrically safe.
3. **CPU platform:** confirm documented boot behavior and status/debug output.
4. **Memory:** test only through supported access paths; use address and walking-bit tests.
5. **UART:** confirm voltage levels, baud settings, and transmit/receive wiring.
6. **GPIO:** exercise one output at a time with suitable current-limiting resistors/buffers.
7. **Timer/IRQ:** verify status and interrupt handling.
8. **Expansion:** add one board at a time.

## Isolation

Start with only the minimum supported platform. Add optional peripheral boards sequentially, recording the exact change and test result after each step.

## Record every issue

Capture symptom, expected behavior, measured signals, test conditions, module/board revision, firmware hash, and the smallest reproducible test.