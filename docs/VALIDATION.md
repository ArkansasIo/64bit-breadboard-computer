# Validation Plan

## Documentation and source checks
- [ ] every link in README points to an existing path
- [ ] NASM is installed in CI
- [ ] standalone examples assemble
- [ ] bootstrap output size is checked where applicable
- [ ] memory-map examples are flagged as illustrative

## Hardware validation
- [ ] selected CPU module and official datasheet recorded
- [ ] power rails and sequencing measured
- [ ] voltage compatibility checked
- [ ] reset/clock signals observed
- [ ] interfaces validated without contention
- [ ] UART/GPIO/timer tested one at a time
- [ ] schematic revision matches physical board

## Acceptance
Do not label a build operational until hardware tests have been measured and their results recorded. A successful assembly CI job verifies source syntax only, not physical hardware behavior.