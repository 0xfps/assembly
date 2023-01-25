// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract T {
    function f(string memory s) public pure returns (bytes memory) {
        // return bytes32(bytes(s));
        return bytes(s);
    }

    function g(string memory s) public pure returns (bytes32) {
        return bytes32(bytes(s));
    }

    function bytes32ToString(bytes32 _bytes32) public pure returns (string memory) {
        uint8 i = 0;
        while(i < 32 && _bytes32[i] != 0) {
            i++;
        }
        bytes memory bytesArray = new bytes(i);
        for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
            bytesArray[i] = _bytes32[i];
        }
        return string(bytesArray);
    }

    function bytes32ToString(bytes memory _bytes) public pure returns (string memory) {
        return string(_bytes);
    }
}