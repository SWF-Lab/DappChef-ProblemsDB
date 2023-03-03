// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; 
contract answer7 {

    function add(uint256 a, uint256 b) external pure returns (uint256) {
      return a + b;
    }

    function add(uint256 a, uint256 b, uint256 c) external pure returns (uint256) {
      return a + b + c;
    }
}