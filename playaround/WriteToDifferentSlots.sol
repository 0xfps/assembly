// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

library M {
    struct D {
        uint256 data;
    }

    function getStorage(bytes32 slot) internal pure returns(D storage d) {
        bytes32 _slot = slot;
        assembly {
            d.slot := _slot
        }
    }    

    function writeToSlot(bytes32 slot, uint256 _val) internal {
        D storage d = getStorage(slot);
        d.data = _val;
    }

    function readFromSlot(bytes32 slot) internal view returns(uint256) {
        D storage d = getStorage(slot);
        return d.data;
    }
}

contract W {
    bytes32 public firstSlot = keccak256(bytes("SLOT1"));
    bytes32 public secondSlot = keccak256(bytes("SLOT2"));

    function w(bytes32 slot, uint256 num) public {
        M.writeToSlot(slot, num);
    }

    function r(bytes32 slot) public view returns(uint256) {
        return M.readFromSlot(slot);
    }
}