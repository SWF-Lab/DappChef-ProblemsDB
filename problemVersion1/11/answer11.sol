// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Called {
  uint256 public balance = 0;

  receive() external payable {
    balance = msg.value;
  }

  function getBalance() external view returns (uint256) {
    return balance;
  }
}

contract answer11 {
  Called public called;
  bool public success; 
  
  receive() external payable {}

  function deployContract() external {
    called = new Called();
  }

  function sendETHtoCalled() external {
    (success, ) = address(called).call{value: 50000}("");
  }

  function checkAns() external view returns(uint256) {
    require(success, "transfer not success");
    return called.getBalance();
  }

}