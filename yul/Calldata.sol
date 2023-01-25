// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract OtherContract {
    // 9a884bde
    function get21() public pure returns (uint256) {
        return 21;
    }

    // 0xb97b033c
    function get999() public pure returns (uint256) {
        return 999;
    }
}

contract ExternalCall {
    address f = address(new OtherContract());

    function makeExternalCall() public view returns (bytes32) {
        address t = f;
        assembly {
            // Function selectors are stored in the 
            mstore(0x00, 0x9a884bde)

            let success := staticcall(gas(), t, 0x1c, 0x20, 0x00, 0x20)
            return(0x00, 0x20)
        }
    }

    function getWithRevert() public view returns (uint256) {
        address t = f;
        assembly {
            mstore(0x00, 0xb97b033c)

            pop(staticcall(12000, t, 0x1c, 0x20, 0x00, 0x20))

            return(0x00, 0x20)
        }
    }
}