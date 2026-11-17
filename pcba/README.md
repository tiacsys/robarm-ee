# PCBAs

One folder per PCBA, `pcba/<name>/`, with one KiCad project: `<name>.kicad_pro`,
`<name>.kicad_sch`, `<name>.kicad_pcb`, plus the project's own `sym-lib-table` and
`fp-lib-table`. The number of PCBAs is decided in the system design (D28).

Each project is 1:1 with a board def in the EE model (`model/`, XD-ADR-0128). The project's text
variable `TraceID` names the board def's `EE-PCBA` ID; it is a reference only. Links (`realizes`)
and `configs` come from the model, so no other trace variable goes into the `.kicad_pro`
(`curatrix gen cad-needs` reports one).

## Library tables

KiCad must never use the libraries of the user's own KiCad setup (D88). Each project has its own
library tables, and they point only to:

* the tiacsys KiCad libraries in the workspace, through the variables `${XD_KICAD_SYMBOLS}`,
  `${XD_KICAD_FOOTPRINTS}`, `${XD_KICAD_3DMODELS}` and `${XD_KICAD_TEMPLATES}`;
* this repo's own library in `lib/`, through `${KIPRJMOD}` (the project folder).

`curatrix launch kicad` sets these variables (to `libs/kicad/*` in the workspace) and starts
KiCad with a workspace-local configuration, so no global library table is read.

Example `sym-lib-table` of `pcba/<name>/`:

```
(sym_lib_table
  (version 7)
  (lib (name "Device")(type "KiCad")(uri "${XD_KICAD_SYMBOLS}/Device.kicad_symdir")(options "")(descr ""))
  (lib (name "robarm")(type "KiCad")(uri "${KIPRJMOD}/../../lib/robarm.kicad_sym")(options "")(descr "robarm-ee local symbols"))
)
```

Example `fp-lib-table`:

```
(fp_lib_table
  (version 7)
  (lib (name "Resistor_SMD")(type "KiCad")(uri "${XD_KICAD_FOOTPRINTS}/Resistor_SMD.pretty")(options "")(descr ""))
  (lib (name "robarm")(type "KiCad")(uri "${KIPRJMOD}/../../lib/robarm.pretty")(options "")(descr "robarm-ee local footprints"))
)
```

List only the libraries the project uses. The KiCad 10 symbol libraries are folders
(`*.kicad_symdir`, one file per symbol), not single `.kicad_sym` files.

## Trace fields

Circuit blocks and components carry their trace ID in a hidden field `TraceID` (`EE-CMP-nnnn`),
and their links in the hidden fields `Realizes`, `Satisfies`, `Conforms`, `PartOf`, `Status` and
`Configs`. The PCBA itself gets its ID (`EE-PCBA-nnnn`) as a project text variable. KiCad also
copies the text variables into the `.kicad_pcb` as board properties; the `.kicad_pro` is the
source that curatrix reads. `curatrix gen cad-needs
robarm-ee` reads them into `generated/cad-needs.json`.
