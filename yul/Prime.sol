// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract Prime {
    function isPrime(uint256 n) public pure returns (bool t) {
        assembly {
            t := 1

            if lt(n, 4) {
                t := 1
            }

            let half := add(div(n, 2), 1)
            for {let i := 2} lt(i, half) {i := add(i, 1)} {
                if iszero(mod(n, i)) {
                    t := 0
                    break
                }
            }
        }
    }
}