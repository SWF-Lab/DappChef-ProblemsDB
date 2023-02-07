// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer47 {
    mapping(address => uint256) public balance;

    receive() external payable {
        balance[msg.sender] += msg.value;
    }

    function deposit(address recipient) public payable {
        balance[recipient] += msg.value;
    }

    function getNowStake() public view returns (uint256) {
        return balance[msg.sender];
    }

    function withdraw(uint256 amount, address payable withdrawer) public {
        require(withdrawer == msg.sender);
        balance[withdrawer] -= amount;

        (bool sent, ) = withdrawer.call{value:amount}("");
        require(sent, "Failed to send Ether");
    }

    function withdraw(uint256 amount) public {
        balance[msg.sender] -= amount;

        (bool sent, ) = address(msg.sender).call{value:amount}("");
        require(sent, "Failed to send Ether");
    }
}