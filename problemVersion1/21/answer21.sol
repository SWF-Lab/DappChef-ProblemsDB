// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer21 {

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
        return (a, b, c, d, e, f, g);
    }

    function get_a() public view returns(address) {
        return a;
    }
    function get_b() public view returns(uint256) {
        return b;
    }
    function get_c() public view returns(uint128) {
        return c;
    }
    function get_d() public view returns(int32) {
        return d;
    }
    function get_e() public view returns(int8) {
        return e;
    }
    function get_f() public view returns(bool) {
        return f;
    }
    function get_g() public view returns(bytes1) {
        return g;
    }

}