// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; 
contract answer6 {
    event Log(string method, uint256 amount);

    fallback(bytes calldata input) external payable returns (bytes memory) {
      emit Log("fallback", msg.value);
      return input;
    }

    receive() external payable {
      emit Log("receive", msg.value);
    }
}