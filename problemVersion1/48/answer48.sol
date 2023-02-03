// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.13;

contract answer48 {

    function verify(
        bytes32[] memory proof,
        bytes32 _root,
        bytes32 leaf
    ) public pure returns (bool) {
        return processProof(proof, leaf) == _root;
    }

    function processProof(bytes32[] memory proof, bytes32 leaf)
        internal
        pure
        returns (bytes32)
    {
        bytes32 computedHash = leaf;
        for (uint256 i = 0; i < proof.length; i++) {
            computedHash = computedHash < proof[i] ? _efficientHash(computedHash, proof[i]) : _efficientHash(proof[i], computedHash);
        }
        return computedHash;
    }

    function _efficientHash(bytes32 a, bytes32 b)
        private
        pure
        returns (bytes32 value)
    {
        assembly {
            mstore(0x00, a)
            mstore(0x20, b)
            value := keccak256(0x00, 0x40)
        }
    }
}