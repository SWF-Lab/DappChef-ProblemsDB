// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Greeting {
    string internal name = "Elizabeth";

    function getName() public view returns (string memory) {
        string memory output = string.concat("Hi, my name is ", name);
        return output;
    }
}

contract answer26 is Greeting {
    constructor(string memory _name) {
        name = _name;
    }
}