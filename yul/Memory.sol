// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

/*
NOTE

0x00 - 0x3f : Scratch space, everything here is ephemeral.
0x40 - 0x5f : Free memory pointer.
0x60 - 0x7f : Empty.
0x80 - 0xff : Where the fun happens, every memory array, or struct or variable is stored here.

To get the next free memory space, we use the 0x40 pointer, it is really important.

Avoid the 0x40, if you must use it, make sure to update it by calling mstore(0x40, newLocation).
If you're writing to memory with struct or array, or bytes32, then no problem, it updates by itself.

Play around from 0x80!!

return(location, length)
if length < 32 bytes, error.
if length > 32 bytes, it returns only 32 bytes.

keccak256(location, length) returns 32 byte value.
*/

contract Mem {
    struct Point {
        uint256 x;
        uint256 y;
    }

    event MemoryPointer(bytes32);
    event MemoryPointerMSize(bytes32, bytes32);

    function highAccess() public pure {
        assembly {
            // Loading a large memory location will run out of gas.
            pop(mload(0xffffffffffffffff))
        }
    }

    function mstore8() public pure {
        assembly {
            mstore8(0x00, 7)
            mstore(0x00, 7)
        }
    }

    function memPointer() public {
        bytes32 x40;
        assembly {
            // Free memory pointer.
            x40 := mload(0x40)
        }

        emit MemoryPointer(x40);

        Point memory p = Point({x: 5, y: 7});

        assembly {
            // Free memory pointer.
            x40 := mload(0x40)
        }

        emit MemoryPointer(x40);
    }

    function memPointerV2() public {
        bytes32 x40;
        bytes32 _msize;
        assembly {
            // Free memory pointer.
            x40 := mload(0x40)
            _msize := msize()
        }

        emit MemoryPointerMSize(x40, _msize);

        Point memory p = Point({x: 5, y: 7});

        assembly {
            // Free memory pointer.
            x40 := mload(0x40)
            _msize := msize()
        }

        emit MemoryPointerMSize(x40, _msize);


        assembly {
            pop(mload(0xff))
            x40 := mload(0x40)
            _msize := msize()
        }

        emit MemoryPointerMSize(x40, _msize);
    }

    function fixedArray() public {
        bytes32 x40;
        assembly {
            // Free memory pointer.
            x40 := mload(0x40)
        }

        emit MemoryPointer(x40);

        uint256[2] memory arr = [uint256(5), uint256(6)];

        assembly {
            // Free memory pointer.
            x40 := mload(0x40)
        }

        emit MemoryPointer(x40);
    }

    function abiEncode() public {
        bytes32 x40;
        assembly {
            // Free memory pointer.
            x40 := mload(0x40)
        }

        emit MemoryPointer(x40);

        bytes memory x = abi.encode(uint256(6), uint256(12));

        assembly {
            // Free memory pointer.
            x40 := mload(0x40)
        }

        emit MemoryPointer(x40);
    }

    function abiEncodePacked() public {
        bytes32 x40;
        assembly {
            // Free memory pointer.
            x40 := mload(0x40)
        }

        emit MemoryPointer(x40);

        bytes memory x = abi.encodePacked(uint256(6), uint256(12));

        assembly {
            // Free memory pointer.
            x40 := mload(0x40)
        }

        emit MemoryPointer(x40);
    }
}