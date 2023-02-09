// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17;

contract Greeting {
    string constant private GREETING = "Hello, My Name is Coco";  
    function returnGreeting() internal pure returns(string memory) {
        return GREETING;
    }
}

contract answer24 is Greeting {
    function greeting() public pure returns(string memory) {
        string memory result = returnGreeting();
        return result;
    } 
}