# Electrical Safety

These documents are a design guide, not a substitute for manufacturer datasheets or competent hardware review.

- Use a current-limited supply during initial power-up.
- Verify polarity and ground continuity before applying power.
- Do not assume 5 V and 3.3 V logic are interchangeable.
- Use level translators if required by the selected parts.
- Prevent multiple outputs from driving a shared line simultaneously.
- Use ESD precautions for CPU modules and memory.
- Keep fast signals short and follow the applicable signal-integrity requirements.
- Do not exceed board, connector, wire, or breadboard current ratings.
- Never connect an assumed logical signal directly to a CPU pin.
- Disconnect power before rewiring.
- Stop if any component heats unexpectedly or measured behavior differs materially from its datasheet.