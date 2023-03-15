// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
contract Test {
    function test1() external pure returns (uint256) {
      return 1;
    }
    function test2() external pure returns (uint256) {
      return 2;
    }

    function getData1() external pure returns (bytes memory) {
        return abi.encodeWithSelector(this.test1.selector);
    }
    function getData2() external pure returns (bytes memory) {
      return abi.encodeWithSelector(this.test2.selector);
    }
}

contract answer53 {
  Test public testContract;
  bytes[] public datas = new bytes[](2);
  address[] public targets = new address[](2);

  function multiCall() external view returns (bytes[] memory) {
    require(datas.length == targets.length, "Length not equal");
    bytes[] memory results = new bytes[](datas.length);

    for (uint256 i; i < targets.length; i++) {
      (bool success, bytes memory result) = targets[i].staticcall(datas[i]);
      require(success, "call failed");
      results[i] = result;
    }
    return results;
  }

  function deployTest() external {
    testContract = new Test();
  }

  //0x6b59084d
  function getData1() external {
    targets[0] = address(testContract);
    datas[0] = testContract.getData1();
  }

  //0x66e41cb7
  function getData2() external {
    targets[1] = address(testContract);
    datas[1] = testContract.getData2();
  }
}