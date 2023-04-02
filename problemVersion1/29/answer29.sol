// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer29 {
    uint public num;
    address public sender;
    bool public called;

    Test test = new Test();
    function delegateCallTest(uint _num) public payable {
        (bool success, ) = address(test).delegatecall(
            abi.encodeWithSelector(Test.delegateCallByUser.selector, _num)
        );
        require(success);
    }

    function getValues() public view returns(uint256, address, bool) {
        return (num, sender, called);
    }
}

contract Test {
    uint public num;
    address public sender;
    bool public called;

    function delegateCallByUser(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        called = true;
    }
}
