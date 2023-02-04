// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17;

contract answer22 {
    address public immutable caller1;
    address public constant caller2 = address(0);
    
    constructor(address _caller) {
        caller1 = _caller;
    }

    function get_caller1() public view returns (address) {
        return (caller1);
    }

    function get_caller2() public pure returns (address) {
        return (caller2);
    }
}