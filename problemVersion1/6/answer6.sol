// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17; 
contract answer6 {
    event Log(string method, uint256 amount);

    fallback(bytes calldata input) external payable returns (bytes memory) {
      emit Log("fallback", msg.value);
      return input;
    }

    receive() external payable {
      emit Log("recieve", msg.value);
    }

    // function emitLog() external {
    //   emit Log("test",1000000);
    // }
}