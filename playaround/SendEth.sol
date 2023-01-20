// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract SendETH {
    uint256 public value;

    function getETH() public payable {
        uint256 val;

        assembly {
            val := callvalue()
        }

        value = val;
    }
    
    function getBal() public view returns(uint256) {
        return address(this).balance;
    }
}