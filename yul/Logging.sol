// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract Logging {
    event LogA(uint256 indexed a, uint256 indexed b);
    event LogB(uint256 indexed a, bool);

    function getHashAB() public pure returns (bytes32) {
        return keccak256(abi.encode("LogA(uint256,uint256)"));
    }

    function getHash() public pure returns (bytes32) {
        return keccak256(abi.encode("LogB(uint256,bool)"));
    }

    function emitLogA(bytes32 topic) public {
        assembly {
            log3(0x00, 0x00, topic, 5, 6)
            // No need for memory, the args are logged.
        }
    }

    function emitLogB(bytes32 topic) public {
        assembly {
            // Store one in the first 32 bytes of 0x00 memory location.
            mstore(0x00, 1)

            // read 1 from 0x00, i.e, the first 32 bytes of 0x00.
            log2(0x00, 0x20, topic, 5)
            // No need for memory, the args are logged.
        }
    }

    function boom() public {
        assembly {
            selfdestruct(caller())
        }
    }
}