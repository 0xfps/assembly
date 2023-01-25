// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract ArraySumContract {
    // 0x1e2aea06
    function sumArray(uint256[] memory arr) public pure returns(uint256 arrSum) {
        assembly {
            let arrayLength := mload(arr)
            let arrayStart := add(arr, 0x20)
            let sum := 0

            for { let i := 0} lt(i, arrayLength) { i := add(i, 1) } {
                sum := add(sum, mload(arrayStart))
                arrayStart := add(arrayStart, 0x20)
            }

            arrSum := sum
        }
    }
}