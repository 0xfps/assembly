// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract YulTypes {
    // A simple function that returns a number.
    function getNumber() external pure returns (uint256) {
        uint256 x;

        assembly {
            x := 42
        }

        return x;
    }

    function getHex() external pure returns (uint256) {
        uint256 x;

        assembly {
            x := 0xb
        }

        return x;
    }

    function demoString() external pure returns (string memory) {
        bytes32 myString;

        assembly {
            myString := "Hello World!"
        }

        return string(abi.encode(myString));

    }

    function demonstration() external pure returns (bool) {
        bool x;

        assembly {
            x := 0
        }

        return x;
    }
}