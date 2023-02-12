// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17;

contract answer27 {
    function getBytes() public pure returns (bytes16 a, bytes10 b, bytes6 c) {
        bytes memory hash = abi.encodePacked(getHash());

        assembly {
            // first 32 bytes always record the length of this variable
            // load the first 16 bytes
            a := mload(add(hash, 32))
            // next 10 bytes
            b := mload(add(hash, 48))
            // last 6 bytes
            c := mload(add(hash, 58))
        }
    }

    function getHash() public pure returns (bytes32) {
        return keccak256(abi.encodePacked("HASH/HASH/HASH/HASH"));
    }
}