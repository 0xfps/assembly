// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract Arr {
    uint256[] arr;
    uint256 ind;
    mapping(uint256 => uint256) poo;

    function pushToArray(uint256 num) public {
        arr.push(num);
    }

    function pushToMap(uint256 num) public {
        poo[ind] = num;
        ++ind;
    }

    function len() public view returns (uint256) {
        return arr.length;
    }

    function getArrVal(uint256 index) public view returns (uint256 val) {
        uint256 slot;

        assembly {
            slot := arr.slot
        }

        bytes32 loc = keccak256(abi.encode(slot));

        assembly {
            // Location is at keccak256(arr.slot) + (index)
            let rea := add(loc, index)
            val := sload(rea)
        }
    }

    function getMapVal(uint256 _ind) public view returns (uint256 val) {
        uint256 slot;

        assembly {
            slot := poo.slot
        }

        bytes32 loc = keccak256(abi.encode(_ind, slot));

        assembly {
            // Location is at keccak256(mappingKey, mappingSlot)
            val := sload(loc)
        }
    }
}