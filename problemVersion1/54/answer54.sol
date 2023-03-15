// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer54 {
  event Log(address); 
  bytes[] public answers = new bytes[](2);

  //["0x6b59084d", "0x66e41cb7"]
  function delegateCall(bytes[] calldata data) external returns (bytes[] memory) {
    bytes[] memory results = new bytes[](data.length);

    for(uint256 i = 0; i < data.length; i++) {
      (bool success, bytes memory reply) = address(this).delegatecall(data[i]);
      require(success, "delegate call not success");
      answers[i] = reply;
      results[i] = reply;
    } 
    return results;
  }

  function test1() external returns (uint256) {
    emit Log(msg.sender);
    return 1;
  }
  function test2() external pure returns (uint256) {
    return 2;
  }

  function getAns() external view returns(bytes[] memory) {
    return answers;
  }
}