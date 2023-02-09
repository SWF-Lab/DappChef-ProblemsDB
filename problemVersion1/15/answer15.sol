// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17;
contract answer15 {
    address public owner;
    uint public foo;

    constructor(address _owner, uint _foo) payable {
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