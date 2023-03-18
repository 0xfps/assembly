// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract Called {
    // 0x0194db8e
    function sum(uint256[] calldata arr) public pure returns (uint256) {
        uint256 total;

        for (uint256 i = 0; i < arr.length; ++i) {
            total += arr[i];
        }

        return total;
    }

    function sum(uint256 x, uint256 y) public pure returns (uint256) {
        return x + y;
    }
}

contract Caller {
    uint256[] myarr = [1, 2, 3, 4];
    uint256 public Tot;

    function callContract(address c) public {
        (, bytes memory data) = c.call{value: 0}(abi.encodeWithSelector(0x0194db8e, myarr));
        uint256 total = abi.decode(data, (uint256));
        Tot = total;
    }

    function callContractWithAssembly(address c) public view returns (uint256 result) {
        uint256 k;
        assembly {
            // Load selector to memory.
            let mptr := mload(0x40)
            let oldMptr := mptr
            
            // The calldata doesn't include this 👇🏾.
            mstore(mptr, 0x0194db8e)
            // The calldata doesn't include this 👆🏾.

            // The calldata starts here.
            // The memory locations are 20 bytes ahead of the calldata because of the stored function selector in 0x00 - 0x1f of memory.
            mstore(add(mptr, 0x20), 0x20) // 0x00 in calldata, the array pointer points to 0x20 in calldata, which is 0x40 in memory.
            mstore(add(mptr, 0x40), 2) // 0x20 in calldata.
            mstore(add(mptr, 0x60), 2)
            mstore(add(mptr, 0x80), 3)

            mstore(0x40, add(mptr, 0xa0))

            let success := staticcall(
                gas(), 
                c, 
                add(oldMptr, 28), 
                mload(0x40), 
                0x00, 
                0x20
            )
            result := mload(0x00)
        }
    }

    function callSumWithAssembly(address c) public view returns (uint256 result) {
        uint256 k;
        assembly {
            // Load selector to memory.
            let mptr := mload(0x40)
            let oldMptr := mptr

            mstore(mptr, 0xcad0899b)
            mstore(add(mptr, 0x20), 2)
            mstore(add(mptr, 0x40), 2)

            mstore(0x40, add(mptr, 0x60))

            let success := staticcall(
                gas(), 
                c, 
                add(oldMptr, 28), 
                mload(0x40), 
                0x00, 
                0x20
            )
            result := mload(0x00)
        }
    }
}



// For strings.

// 0x2fcf0270 // This isn't included.
// 0x0000000000000000000000000000000000000000000000000000000000000020 // Where the array length is stored.
// 0x0000000000000000000000000000000000000000000000000000000000000005 // The length of the array.
// 0x48656c6c6f000000000000000000000000000000000000000000000000000000 // This is the actual string, strings are arrays.
