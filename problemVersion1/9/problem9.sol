// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17;

// The system will only deploy `problem9()`, write the code in the constructor.
// The system will call `checkAns()` to check your answer.

contract toBeDeployed {
  bool public deployed;

  function setDeployed() external {
    deployed = true;
  }
  function getDeployed() external view returns (bool) {
    return deployed;
  }
}

contract problem9 {
  toBeDeployed public deployContract;

  constructor() {

    // TODO: Deploy the contract `toBeDeployed`

    // TODO: Call `setDeployed()` in toBeDeployed to set `deployed` to true.


  }

  function checkAns() external view returns (bool) {
    return deployContract.getDeployed();
  }
}