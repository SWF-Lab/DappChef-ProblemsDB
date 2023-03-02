// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer33 {
    error ZeroAddress();
    function assemblyCheckZeroAddr(address toCheck) public pure returns (bool success) {
        assembly {
            if iszero(toCheck) {
                let ptr := mload(0x40)
                mstore(ptr, 0xd92e233d00000000000000000000000000000000000000000000000000000000) // selector for `ZeroAddress()`)
                revert(ptr, 0x4)
            }
        }
        return true;
    }
}