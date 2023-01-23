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

    function get() public view returns (uint8 d) {
        assembly {
            // Get the value in the entire slot.
            let DD := sload(D.slot)

            // Make a right shift.
            let shifted := shr(mul(D.offset, 0x08), DD)

            d := and(0xffffffff, shifted)
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