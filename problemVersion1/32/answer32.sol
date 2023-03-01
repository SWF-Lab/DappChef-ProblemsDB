// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer32 {

    // TODO: given an int8, a, you should return a value with `a-234`, but should also make sure the compiler will not occur error.
    function underflow(int8 a) public pure returns(int8) {
        unchecked{         
            return (a - 122);
        }
    } 
}