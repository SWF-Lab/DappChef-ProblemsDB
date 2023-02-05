// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17;
contract problem15 {
    address public owner;
    uint public foo;

    // TODO: Declare a constructor to get 2 input parameters (first is for owner, second is for foo)
    // And in the constructor, you should give 2 input parameters to the owner and foo respectively
    constructor() payable {
        owner = _owner;
        foo = _foo;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function getFoo() public view returns (uint256) {
        return foo;
    }

}