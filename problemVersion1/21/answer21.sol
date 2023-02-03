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

    function changeValue(
        address inputAddr,
        uint256 inputUint256,
        uint128 inputUin128,
        int32 inputInt32,
        int8 inputInt8,
        bool inputBool,
        bytes1 inputBytes1
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
        a = inputAddr;
        b = inputUint256;
        c = inputUin128;
        d = inputInt32;
        e = inputInt8;
        f = inputBool;
        g = inputBytes1;
        return ( a, b, c, d, e, f, g);
    }

}