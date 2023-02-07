// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17; 
contract answer2 { 
    uint256 public x = 1;

    function addNumWithX(uint256 num) public view returns (uint256) {
      return num + x;
    }

    function addTwoNum(uint256 num1, uint256 num2) public pure returns (uint256) {
      return num1 + num2;
    }
}