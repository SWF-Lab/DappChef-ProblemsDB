// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; 

contract answer100 {

    bytes20 public answer;

    function modExp(uint256 _b, uint256 _e, uint256 _m) internal returns (uint256 result) {
        assembly {
            // Free memory pointer
            let pointer := mload(0x40)
            // Define length of base, exponent and modulus. 0x20 == 32 bytes
            mstore(pointer, 0x20)
            mstore(add(pointer, 0x20), 0x20)
            mstore(add(pointer, 0x40), 0x20)
            // Define variables base, exponent and modulus
            mstore(add(pointer, 0x60), _b)
            mstore(add(pointer, 0x80), _e)
            mstore(add(pointer, 0xa0), _m)
            // Store the result
            let value := mload(0xc0)
            // Call the precompiled contract 0x05 = bigModExp
            if iszero(call(not(0), 0x05, 0, pointer, 0xc0, value, 0x20)) {
                revert(0, 0)
            }
            result := mload(value)
        }
    }

    function calculateHash(uint _base, uint _exp, uint _modulus) public {
        uint256 result = modExp(_base, _exp, _modulus);
        bytes memory encodedResult= abi.encodePacked(result);
        bytes20 hash = ripemd160(encodedResult);

        answer = hash;        
    }
}
