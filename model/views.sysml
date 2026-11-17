// Views of the EE model besides the board block diagrams (those sit next to their board def).
// `curatrix views build robarm-ee` renders them into views/; the documents embed them with
// `sysml-view` (tiacsys/xdmod#69, findings 3 and 4).
// SPDX-License-Identifier: Apache-2.0
package RobArmEeViews {
    private import XdTrace::*;

    // How the EE model refines the system model: boards and harnesses realize system elements,
    // connector ports conform to system interfaces, a board conforms to its space budget
    // (the trace links curatrix derives from `:>` and `dependency`, XD-ADR-0132, XD-ADR-0134).
    view eeAllocation {
        @XdView { kind = "allocation"; root = "RobArmEe::Canary"; }
    }

    // The variants of the canary board and what each serves (XD-ADR-0136).
    view canaryBoardVariants {
        @XdView { kind = "variants"; root = "RobArmEe::Canary::CanaryBoard"; }
    }
}
