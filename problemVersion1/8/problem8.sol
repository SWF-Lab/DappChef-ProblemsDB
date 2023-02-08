// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17; 
// 1. The system will call the three functions first and they should all revert.
// 2. then the system call `addNumByOne` 
// 3. After that the system will call the three functions and they should all pass without any error message
// 4. DO NOTHNG after the requirements.
contract answer8 {
  uint256 public balance = 0;

  // TODO: Write a function named `testAssert` using `assert`


  // TODO: Write a function named `testRequire` using `require`, the error message should be "Required" if reverted.


  // TODO: Write a function named `testRevert` using `revert`, the error message should be "Reverted" if reverted.



  function addNumByOne() external {
    balance++;
  }
}