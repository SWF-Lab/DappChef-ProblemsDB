// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17; 
contract answer3 { 
    function biggerThanTen(uint256 num) public pure returns (bool) {
        return num > 10 ? true : false;
    }
}