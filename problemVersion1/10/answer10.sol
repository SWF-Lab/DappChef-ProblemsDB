// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Called {
  bool public called = false;

  function setCalled() external {
    called = true;
  }
  function getCalled() external view returns (bool) {
    return called;
  }
}

interface ICalled {
  function setCalled() external;
  function getCalled() external view returns (bool);
}

contract answer10 {
  Called public calledContract;

  constructor() {
    calledContract = new Called();
  }

  function setCalled() external {
    ICalled(address(calledContract)).setCalled();
  }

  function checkAns() external view returns (bool) {
    return ICalled(address(calledContract)).getCalled();
  }
}