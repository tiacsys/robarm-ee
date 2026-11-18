# robarm-ee

Electrical engineering of the robot arm example of [XDMOD](https://github.com/tiacsys/xdmod):
KiCad projects of the PCBAs, the wiring of the prototype setups, and the EE design document.

Status: **skeleton** (Phase 4). The structure, the checks and an empty document are in place; the
content comes in Phase 6.

## Layout

| Path | What |
|---|---|
| `pcba/<name>/` | one KiCad project per PCBA (with project-local library tables) |
| `proto/<config>/` | wiring of one prototype configuration (KiCad schematic or WireViz) |
| `harness/<name>/` | cables between boards (WireViz, if adopted) |
| `lib/` | local symbols, footprints and 3D models that the tiacsys libraries do not have |
| `tests/` | scripted EE checks |
| `generated/cad-needs.json` | needs read from the KiCad files (generated, committed) |
| `docs/ee-req/` | EE Requirements Specification |
| `docs/ee-design/` | EE Design: board and cable defs, allocation, overview |
| `docs/ee-test-spec/`, `docs/ee-test-report/` | EE Test Specification and Report |
| `docs/harnesses/` | Harnesses: every cable (ends, diagram, wiring, BOM) |
| `docs/pcbas/pcba-<board>/` | one document per board |
| `ids.yaml` | ID ledger for `EE-*` IDs |
| `checks.yaml` | what `curatrix check robarm-ee` runs |
| `claude/` | rules and skills for agents working in this repo |

In iteration 1 there is one document. It is split into requirements, one document per PCBA,
one per prototype setup, and test documents once that content exists.

## Use

This repo is a west project of the [robarm-manifest](https://github.com/tiacsys/robarm-manifest)
workspace. Run every command from the workspace root:

```sh
curatrix launch kicad pcba/<name>/<name>.kicad_pro   # KiCad with the workspace libraries
curatrix gen cad-needs robarm-ee                     # update generated/cad-needs.json
curatrix check robarm-ee --stage local               # all checks, as before a push
```

KiCad uses only the libraries in the workspace (`libs/kicad/`), never the user's own setup. See
`pcba/README.md` for the library tables.

## Licence

Apache-2.0, see `LICENSE`.
