// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17;

contract answer22 {
    address public immutable CALLER_1;
    address public constant CALLER_2 = address(0);
    
    constructor(address _caller) {
        CALLER_1 = _caller;
    }

    function get_CALLER_1() public view returns (address) {
        return (CALLER_1);
    }

    function get_CALLER_2() public pure returns (address) {
        return (CALLER_2);
    }
}