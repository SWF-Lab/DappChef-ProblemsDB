// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer14 {
    
    event Calling(address indexed sender, uint256 indexed number, bool indexed flag, string message, string postfix);

    function emitCalling(address account, uint256 number, bool flag, string memory message) public {
        emit Calling(account, number, flag, message, "Meow");
    }
}