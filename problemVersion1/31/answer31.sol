// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer31 {

    // TODO: given an uint8, a, you should add 234 to `a` but should also make sure the compiler will not occur error.
    function overflow(uint8 a) public pure returns(uint8) {
        unchecked{           
            return a + 234;
        }
    } 
}