# Harnesses

One folder per cable, `harness/<name>/`, with one WireViz YAML `<name>.yml` as its entry point
(XD-ADR-0127; WireViz is a pinned tool of xdmod). Each harness is 1:1 with a cable def of the EE
model (`XdDomain::Cable`, an `EE-HAR` ID), named in the YAML as `metadata: {TraceID: EE-HAR-....}`;
the folder is named after the def (`CanaryCable` -> `canary-cable`).

- Each connector names the `EE-PORT` it mates with (on our boards or on external parts) on a line
  `Port: EE-PORT-....` of its `notes`; its `pins` and `pinlabels` are the pin numbers and net names
  of that port's pin map. CK-F1 checks them and the wiring pin to pin against both ends; CK-F7
  checks the 1:1 with the model.
- `curatrix cam robarm-ee <name>` runs WireViz (diagram SVG and PNG, BOM) into
  `build/robarm-ee/cam/<name>/<version>/`; the version comes from tags `<name>/vX.Y.Z`.
- Each harness has its document `docs/harness-<name>/`.

Prototype jumper wiring stays a KiCad schematic per prototype setup (`proto/`, XD-ADR-0067).
