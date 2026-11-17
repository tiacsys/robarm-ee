// EE domain model (XD-ADR-0130): the canary board. It refines the system model of
// robarm-syseng by specialization; curatrix derives `realizes` / `conforms` from `:>`
// (XD-ADR-0132). The KiCad project pcba/canary-board/ names the board by its ID (TraceID, a
// reference only, XD-ADR-0128).
// SPDX-License-Identifier: Apache-2.0
package RobArmEe {
    doc /* The electrical domain model of the robot arm. */
    private import XdTrace::*;
    private import XdDomain::*;

    public package Canary {
        // The canary board realizes the canary unit. CanaryUnit has no ports in the system model,
        // so the board redefines none; its connector conforms to no SYS-IF (allowed for ports,
        // XD-ADR-0133).
        part def <'EE-PCBA-0001'> CanaryBoard :> RobArmProduct::Canary::CanaryUnit, Pcba {
            doc /* The canary PCBA (canary step C1): the connector J1, with R1 between its two pins
                 * (nets CANARY_A, CANARY_B). J1 carries Port = EE-PORT-0001 in the schematic, and
                 * CK-F1 compares its pins and nets with the pin map below. */
            port j1 : CanaryHeader;
        }
        // The board conforms to its space budget (task 5.28, XD-ADR-0134): box, holes and the
        // position of J1 in the system model. Outline and holes in the .kicad_pcb come from the
        // skeleton of the canary assembly by the StepUp push of a co-design change; EE places J1
        // at the budget's position. A budget is no connector, so it is not a port of the board.
        dependency from CanaryBoard to RobArmProduct::Canary::CanaryBoardSpace;

        // The two variants of the canary board (XD-ADR-0136): KiCad assembly variants of the same
        // names in pcba/canary-board/. They differ only in R1 (fitted in `default`, DNP in `alt`).
        // Each names the configuration and the system usage it serves; curatrix computes the
        // table "configuration -> variant per usage" and checks it (CK-B8). `alt` serves no pair
        // yet: the canary has one configuration and one usage, and `default` serves it. CK-B8
        // still checks that `alt` is in the KiCad project; it is not reported as unused
        // (iteration 1).
        part def CanaryBoardDefault :> CanaryBoard, DomainVariant {
            doc /* R1 fitted. */
            :>> variantName = "default";
        }
        dependency from CanaryBoardDefault to RobArmConfigs::canary,
            RobArmProduct::Canary::CanaryContext::canaryUnit;

        part def CanaryBoardAlt :> CanaryBoard, DomainVariant {
            doc /* R1 not fitted (DNP). */
            :>> variantName = "alt";
        }

        // The canary connector J1 and its pin map (pin number and net name per signal).
        // J1 in the KiCad schematic names this port def (Port = EE-PORT-0001); CK-F1 compares them.
        port def <'EE-PORT-0001'> CanaryHeader :> ConnectorPort {
            doc /* A 2-pin header, 2.54 mm pitch: J1 of the canary board. */
            :>> connector = "PinHeader_1x02_P2.54mm";
            inout port a : PinSignal { :>> pin = "1"; :>> net = "CANARY_A"; }
            inout port b : PinSignal { :>> pin = "2"; :>> net = "CANARY_B"; }
        }

        // The canary harness (task 5.22): one cable from J1 of the canary board to a bought part,
        // so the harness chain (WireViz YAML, CK-F1 against both ends, `curatrix cam`, the
        // harness-canary-cable document) runs on the canary. harness/canary-cable/canary-cable.yml
        // names the cable by its ID (metadata TraceID) and each end by its port (`Port:` in the
        // connector notes).

        // An external part (XD-ADR-0135): a bought two-wire test lead with a 2-pin plug. It has a
        // port with a pin map, but no KiCad project.
        part def CanaryTestLead :> ExternalPart {
            doc /* A bought test lead: a 2-pin Dupont plug on two wires to the bench meter. */
            port plug : CanaryLeadPlug;
        }
        port def <'EE-PORT-0002'> CanaryLeadPlug :> ConnectorPort {
            doc /* The 2-pin plug of the test lead, 2.54 mm pitch. */
            :>> connector = "Dupont 1x02 male";
            inout port a : PinSignal { :>> pin = "1"; :>> net = "CANARY_A"; }
            inout port b : PinSignal { :>> pin = "2"; :>> net = "CANARY_B"; }
        }

        // The cable def (EE-HAR): its ends mate with J1 of the board and with the lead's plug, so
        // curatrix derives `connects` to both ports. It realizes the canary unit (a board, a part
        // and a bit of firmware; no orphans, XD-RULE-0010). That is a canary shortcut: harnesses of
        // the arm realize their own system element or conform to an interface, not a whole unit.
        part def <'EE-HAR-0001'> CanaryCable :> Cable {
            doc /* Two wires, 2-pin socket housings at both ends. */
            port boardEnd : ~CanaryHeader;
            port leadEnd : ~CanaryLeadPlug;
        }
        dependency from CanaryCable to RobArmProduct::Canary::CanaryUnit;
    }

    // The block diagram of the canary board: the board with its connectors (no circuit blocks
    // inside a board in iteration 1). `curatrix views build robarm-ee` renders it.
    view canaryBoard {
        @XdView { kind = "interconnection"; root = "RobArmEe::Canary::CanaryBoard"; }
        expose RobArmEe::Canary::CanaryBoard;
    }
}
