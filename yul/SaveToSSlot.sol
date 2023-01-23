// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract Save {
    uint256 a; // Slot 0.
    uint256 b; // Slot 1.
    // Slot 2 ** 256 - 1.

    function getSlot() public pure returns (uint256 z) {
        assembly {
            z := a.slot
        }
    }

    function writeToSSlot(uint256 num) public {
        assembly {
            sstore(0x23, num)
        }
    }

    function readFromSSlot() public view returns (uint256 val) {
        assembly {
            val := sload(0x23)
        }
    }
}

contract MultiSave {
    uint128 A = 4;
    uint96 B = 3;
    uint16 C = 2;
    uint8 D = 8;

    function get() public view returns (bytes32 d) {
        assembly {
            // Get the value in the entire slot.
            let DD := sload(D.slot) // 0
            // 0x0008000200000000000000000000000300000000000000000000000000000004
            let c := shl(0x10, DD)
            // 0x0002000000000000000000000003000000000000000000000000000000040000
            d := shr(mul(30, 8), c)
            // Returns the value of C.
        }
    }

    function readSlot() public view returns (bytes32 v) {
        assembly {
            v := sload(0)
        }
    }

    function getOffsets() public pure returns (
        uint256 slot, uint256 offset
    ) {
        assembly {
            slot := D.slot
            offset := D.offset
        }
    }
}