// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17;

contract problem23 {
    uint256 public constant UINT = 138675023;
    int8 public constant INT = 18;
    address public constant CALLER = 0x0000000000000000000000000000000000000123;
    bytes4 public constant BYTES = 0x4fe13242;
    bytes32 public result;
    
    function hashInOrder() public {
        //TODO: you should use ONE keccak256 function to hash the above constant variables in order (UINT -> INT -> CALLER ...), and assign the value to result.
    }

    function get_result() public view returns(bytes32) {
        return result;
    }
}