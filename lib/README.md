# Local libraries

Symbols, footprints and 3D models that are not in the tiacsys KiCad libraries (D88):

* `robarm.kicad_sym`: local symbols;
* `robarm.pretty/`: local footprints;
* `robarm.3dshapes/`: local 3D models.

Projects refer to them through `${KIPRJMOD}` (see `pcba/README.md`). The files are created with
the first part that needs them. `kicad-library-utils` (in `libs/kicad/`) can check them against
the KiCad library conventions.
