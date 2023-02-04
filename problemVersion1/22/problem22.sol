// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17;

// TODO: you should declare two global addresses, caller1 and caller2.
contract problem22 {
    
    address public immutable caller1;

    //TODO: you should initialize this constant variable with zero address.
    address public constant caller2 = address(0);

    constructor(address _caller) {
        //TODO: you should assign the input value to the immutable address in the constructor.   
        caller1 = _caller;     
    }

    function get_caller1() public view returns (address) {
        return (caller1);
    }

    function get_caller2() public pure returns (address) {
        return (caller2);
    }
}