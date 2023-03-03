// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Called {
  string public message;

  function setMessage(string memory _message) external {
    message = _message;
  }
}

contract ProxyContract {
  address immutable called;

  constructor(address _called) { 
    called = _called; 
  }

  fallback(bytes calldata callData) external payable returns (bytes memory resultData)
  {
    bool success;
    (success, resultData) = called.delegatecall(callData);
    if (!success) {
      assembly { 
        revert(add(resultData, 0x20), mload(resultData)) 
      }
    }
  }
}

contract answer56 {
  Called called = new Called();
  ProxyContract proxy = new ProxyContract(address(called));
  Called proxified = Called(address(proxy));

  function test() external {
    proxified.setMessage("hi");
  }
  function getAns() external view returns (string memory) {
    return proxified.message();
  }
}