// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; 
contract answer8 {
  uint256 public balance = 0;

  function testAssert() external view {
    assert(balance == 1);
  }

  function testRequire() external view {
    require(balance == 1, "Required");
  }

  function testRevert() external view {
    if(balance == 0){
      revert("Reverted");
    }
  }

  function addNumByOne() external {
    balance++;
  }
}