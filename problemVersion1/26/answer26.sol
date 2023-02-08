// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17;

contract Greeting {
    string constant private GREETING = "Hello, My Name is Coco";  
    function returnGreeting(string memory _input) public virtual pure returns(string memory) {
        return GREETING;
    }
}

contract answer25 is Greeting {
    function returnGreeting(string memory _input) public virtual override pure returns(string memory) {
        return _input;
    } 
}