# robarm-ee: rules for agents

Read the workspace `CLAUDE.md` (copied from `xdmod/launch/CLAUDE.md`) first. This file adds the
rules of this repo. Run every command from the workspace root.

## What this repo is

Electrical design: one KiCad project per PCBA (`pcba/<name>/`), the wiring of each prototype
configuration (`proto/<config>/`), cables (`harness/`, if WireViz is adopted), local library
parts (`lib/`), scripted EE checks (`tests/`), and one document, `docs/ee-design/` (D135).

## Rules

- **Libraries:** KiCad uses only the workspace libraries. Library tables live in each project
  and use `${XD_KICAD_SYMBOLS}`, `${XD_KICAD_FOOTPRINTS}`, `${XD_KICAD_3DMODELS}`,
  `${XD_KICAD_TEMPLATES}` and `${KIPRJMOD}` (D88). Never an absolute path, never a global table.
  See `pcba/README.md`.
- **Start KiCad only through `curatrix launch kicad`**, which sets those variables and a
  workspace-local KiCad config.
- **The EE model** (`model/*.sysml`) owns the boards (`EE-PCBA`), connector ports with their pin
  maps (`EE-PORT`) and cables (`EE-HAR`) (XD-ADR-0128, XD-ADR-0130). A board def specializes its
  `SYS-EL` def from robarm-syseng and `XdDomain::Pcba`, and redefines every inherited port. After a
  model change: `curatrix gen model robarm-ee`, `curatrix views build robarm-ee`, commit
  `generated/` and `views/`.
- **Trace fields** are hidden symbol or sheet fields: `TraceID`, `Realizes`, `Satisfies`,
  `Conforms`, `Status`, `Configs`. The project text variable `TraceID` names the board def's
  `EE-PCBA` ID: a reference only, the need comes from the model (with `configs` from the
  `SYS-CFG` that configures the realized `SYS-EL`); no other variable goes next to it. EE and SW never link
  to each other: both link to the interfaces (`SYS-IF`) in robarm-syseng (D36).
- After a KiCad change: `curatrix gen cad-needs robarm-ee`, commit `generated/cad-needs.json`.
- Tests that verify system requirements or interfaces belong to robarm-integration (D115).

## Pitfalls

- KiCad writes its own lock and backup files (`*.lck`, `*-backups/`, `fp-info-cache`); never
  commit them.
- A hierarchical sheet used several times has one trace ID; its usages are listed as
  `instances` (D128).
- PR CI has no KiCad (D56). CAD-derived needs reach CI only through the committed
  `generated/cad-needs.json`, so keep it up to date.
