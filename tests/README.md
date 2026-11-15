# EE checks

Scripted EE checks, for example the KiCad netlist against the pin maps of the system interfaces
(CK-F1) and the electrical rules check (CK-F4). Each check writes JUnit XML to
`build/robarm-ee/` and is listed as a command in `checks.yaml`. Tests of system requirements and
system interfaces that need real hardware belong to robarm-integration (D115).
