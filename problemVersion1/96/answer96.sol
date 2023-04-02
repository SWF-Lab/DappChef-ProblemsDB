// SPDX-License-Identifier: GPL-3.0-only
// Copyright (c) Tim Daubenschütz.
// Reference: https://github.com/attestate/indexed-sparse-merkle-tree
pragma solidity ^0.8.17;

uint256 constant SIZE = 255;
uint256 constant BUFFER_LENGTH = 1;
uint256 constant DEPTH = 8;

contract answer96 {
    function bitmap(uint256 index) public pure returns (uint8) {
        uint8 bytePos = (uint8(BUFFER_LENGTH) - 1) - (uint8(index) / 8);
        return (bytePos + 1) << (uint8(index) % 8);
    }

    function empty() public pure returns (bytes32) {
        return 0;
    }

    function validate(
        bytes32[] memory _proofs,
        uint8 _bits,
        uint256 _index,
        bytes32 _leaf,
        bytes32 _expectedRoot
    ) public pure returns (bool) {
        return (compute(_proofs, _bits, _index, _leaf) == _expectedRoot);
    }

    function write(
        bytes32[] memory _proofs,
        uint8 _bits,
        uint256 _index,
        bytes32 _nextLeaf,
        bytes32 _prevLeaf,
        bytes32 _prevRoot
    ) public pure returns (bytes32) {
        require(
            validate(_proofs, _bits, _index, _prevLeaf, _prevRoot),
            "update proof not valid"
        );
        return compute(_proofs, _bits, _index, _nextLeaf);
    }

    function hash(bytes32 a, bytes32 b) public pure returns (bytes32) {
        if (a == 0 && b == 0) {
            return 0;
        } else {
            return keccak256(abi.encode(a, b));
        }
    }

    function compute(
        bytes32[] memory _proofs,
        uint8 _bits,
        uint256 _index,
        bytes32 _leaf
    ) public pure returns (bytes32) {
        require(_index < SIZE, "_index bigger than tree size");
        require(_proofs.length <= DEPTH, "Invalid _proofs length");

        for (uint256 d = 0; d < DEPTH; d++) {
            if ((_index & 1) == 1) {
                if ((_bits & 1) == 1) {
                    _leaf = hash(_proofs[d], _leaf);
                } else {
                    _leaf = hash(0, _leaf);
                }
            } else {
                if ((_bits & 1) == 1) {
                    _leaf = hash(_leaf, _proofs[d]);
                } else {
                    _leaf = hash(_leaf, 0);
                }
            }

            _bits = _bits >> 1;
            _index = _index >> 1;
        }
        return _leaf;
    }

    function fillup(bytes32 LEAF) public pure returns (bytes32) {
        bytes32 LEAF_HASH = keccak256(abi.encode(LEAF));

        bytes32[] memory ones = new bytes32[](DEPTH);
        ones[0] = LEAF_HASH;
        ones[1] = keccak256(abi.encode(ones[0], ones[0]));
        ones[2] = keccak256(abi.encode(ones[1], ones[1]));
        ones[3] = keccak256(abi.encode(ones[2], ones[2]));
        ones[4] = keccak256(abi.encode(ones[3], ones[3]));
        ones[5] = keccak256(abi.encode(ones[4], ones[4]));
        ones[6] = keccak256(abi.encode(ones[5], ones[5]));
        ones[7] = keccak256(abi.encode(ones[6], ones[6]));

        bytes32 prevRoot = empty();
        for (uint256 i = 0; i < (2 ** DEPTH) - 1; i++) {
            bytes32[] memory proofs = new bytes32[](DEPTH);

            uint8 bits;
            uint256 pointer = i;
            for (uint8 j = 0; j < DEPTH; j++) {
                if (pointer % 2 == 0) {
                    //proofs[j] = zeros[j];
                } else {
                    bits += bitmap(j);
                    proofs[j] = ones[j];
                }
                pointer = pointer / 2;
            }

            prevRoot = write(proofs, bits, i, LEAF_HASH, 0, prevRoot);
        }

        return prevRoot;
    }
}
