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
            doc /* The canary PCBA. Planned for canary step C1: the connector J1, with R1 between its
                 * two pins (nets CANARY_A, CANARY_B). The schematic has R1 only; J1 is drawn in
                 * task 5.18, and CK-F1 then compares it with the pin map below. */
            port j1 : CanaryHeader;
        }

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
        // J1 is not drawn in the KiCad schematic yet; CK-F1 (task 5.18) compares them.
        port def <'EE-PORT-0001'> CanaryHeader :> ConnectorPort {
            doc /* Planned: a 2-pin header, 2.54 mm pitch (task 5.18). */
            :>> connector = "PinHeader_1x02_P2.54mm";
            inout port a : PinSignal { :>> pin = "1"; :>> net = "CANARY_A"; }
            inout port b : PinSignal { :>> pin = "2"; :>> net = "CANARY_B"; }
        }
    }

    // The block diagram of the canary board: the board with its connectors (no circuit blocks
    // inside a board in iteration 1). `curatrix views build robarm-ee` renders it.
    view canaryBoard {
        @XdView { kind = "interconnection"; root = "RobArmEe::Canary::CanaryBoard"; }
        expose RobArmEe::Canary::CanaryBoard;
    }
}
