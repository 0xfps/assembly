// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract SendEth {
    receive() external payable {
        uint256 e = 1 ether;
        assembly {
            if lt(callvalue(), e) {
                revert(0, 0)
            }
        }
    }

    function sendEth(address a) public {
        assembly {
            if iszero(selfbalance()){
                revert(0, 0)
            }

            let s := call(gas(), a, selfbalance(), 0, 0, 0, 0)

            if iszero(s) {
                revert(0, 0)
            }
        }
    }
}