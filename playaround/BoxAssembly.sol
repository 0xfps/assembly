// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract Box {
    uint256 private _value;

    event NewValue(uint256 newValue);

    function store(uint256 newValue) public {
        assembly {
            sstore(0x40, newValue)
            log1(0x70, 0x20, 0xac3e966f295f2d5312f973dc6d42f30a6dc1c1f76ab8ee91cc8ca5dad1fa60fd)
        }
    }

    function retrieve() public view returns (uint256) {
        assembly {
            let x := sload(0x40)
            // Free memory starts from 0x80.
            mstore(0x80, x)
            return(0x80, 0x20)
        }
    }
}