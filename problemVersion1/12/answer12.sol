// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17;

contract Called {
  string public greet;

  function setGreet(string memory _greet) external payable {
    greet = _greet;
  }
  
  function getGreet() external view returns (string memory) {
    return greet;
  } 
}

contract answer12 {
  Called public called;
  bool public success; 
  
  receive() external payable {}

  function deployContract() external {
    called = new Called();
  }

  function callSetGreet(string memory _greet) external {
    (success, ) = address(called).call{value: 50000}(
      abi.encodeWithSignature("setGreet(string)", _greet)
    );
  }

  function getGreet() external view returns (string memory) {
    return called.getGreet();
  }
}