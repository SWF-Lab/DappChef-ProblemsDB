// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; 
contract answer5 { 
    address public owner;

    constructor() {
        owner = tx.origin;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    function changeOwner(address _user) external onlyOwner {
        owner = _user;
    }

    function getOwner() external view returns (address) {
        return owner;
    }
}