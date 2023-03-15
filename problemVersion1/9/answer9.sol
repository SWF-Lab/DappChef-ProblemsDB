// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract toBeDeployed {
  bool public deployed;

  function setDeployed() external {
    deployed = true;
  }
  function getDeployed() external view returns (bool) {
    return deployed;
  }
}

contract answer9 {
  toBeDeployed public deployContract;

  constructor() {
    deployContract = new toBeDeployed();
    deployContract.setDeployed();
  }

  function checkAns() external view returns (bool) {
    return deployContract.getDeployed();
  }
}