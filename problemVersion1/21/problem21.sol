// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17;

contract globalVariables {

    address public a;
    uint256 public b;
    uint128 public c;
    int32 public d;
    int8 public e;
    bool public f;
    bytes1 public g;

    // TODO: you should complete this function which changes the value of several global variables and return their values in order.
    function changeValue(
        //TODO: you should complete the parameter field with correct input types.
    ) public returns (
        address,
        uint256,
        uint128,
        int32,
        int8,                                   
        bool,
        bytes1
    ) 
    {  
        //TODO: you should write the statements to change the values of global variables declared in the contract.
        return ( a, b, c, d, e, f, g);
    }

}