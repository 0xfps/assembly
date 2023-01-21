// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract W {
    function add(uint256 x, uint256 y) public pure returns (uint256) {
        assembly {
            let sum := add(x, y)
            mstore(0x80, sum)
            return(0x80, 0x20)
        }
    }

    function div(uint256 x, uint256 y) public pure returns (uint256) {
        // Compressed.
        // Read from bottom up.
        assembly {
            mstore(0x80, div(x, y))
            return(0x80, 0x20)
        }
    }

    function forLoop(uint8 n) public pure returns (uint256) {
        assembly {
            let limit := n
            let sum
            for {let i := 0} lt(i, n) {i := add(i, 1)} {
                sum := add(sum, add(i, n))
            }
            mstore(0x90, sum)
            return(0x90, 0x20)
        }
    }

    function whileLoop(uint8 n) public pure returns (uint256) {
        assembly {
            let sum
            let i
            for {} lt(i, n) {} {
                sum := add(sum, add(i, n))
                i := add(i, 1)
            }
            mstore(0x91, sum)
            return(0x90, 0x20)
        }
    }

    function infiniteLoop() public pure {
        assembly {
            let sum
            let i
            for {} gt(i, 2) {} {
                sum := add(sum, add(i, sum))
                i := add(i, 1)
            }
            mstore(0x91, sum)
            return(0x90, 0x20)
        }
    }
}