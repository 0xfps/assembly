// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract Box {
    uint256 private _value;

    event NewValue(uint256 newValue);

    function store(uint256 newValue) public {
        _value = newValue;
        emit NewValue(newValue);
    }

    function retrieve() public view returns (uint256) {
        return _value;
    }
}