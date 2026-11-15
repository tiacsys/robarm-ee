# Prototype wiring

One folder per prototype configuration, `proto/<config>/`, with the wiring of that setup
(for example the NUCLEO-G474RE board, the PCA9685 and MCP3208 breakouts, servos and
potentiometers). The wiring is a KiCad schematic, or a WireViz YAML file if WireViz is adopted
(D74, D112). Its elements are `EE-CMP` needs whose `Configs` field names the prototype
configuration. Library tables follow the same rules as in `pcba/README.md`.
