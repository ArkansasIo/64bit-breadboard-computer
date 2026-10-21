# Bill of Materials (Planning Baseline)

Exact manufacturer part numbers are intentionally not specified until the CPU module and electrical interfaces have been selected.

| Item | Qty | Selection requirement |
|---|---:|---|
| x86-64 compute module | 1 | confirms CPU architecture and documented I/O |
| breadboards or prototyping boards | several | only for compatible low-speed circuits |
| regulated current-limited supply | 1 | sized to documented load |
| reset supervisor | 1 | matches rails and polarity |
| oscillator/divider | 1 set | only as supported by target interface |
| logic decoder/control ICs | TBD | voltage compatible |
| bus transceivers | TBD | voltage and timing compatible |
| firmware storage | 1+ | platform-compatible |
| RAM | 1+ | platform-compatible |
| UART interface | 1 | voltage and driver compatible |
| GPIO/LED circuitry | 1 set | includes appropriate resistors/buffers |
| timer/interrupt logic | TBD | platform-supported |
| pushbuttons and DIP switches | several | debounced and protected |
| test points/jumpers/connectors | as needed | labeled and rated for use |
| multimeter / oscilloscope / logic analyzer | 1 each recommended | measurement equipment |

Do not order a final BOM from this table alone. Choose actual parts from the selected module's electrical documentation and verify operating limits.