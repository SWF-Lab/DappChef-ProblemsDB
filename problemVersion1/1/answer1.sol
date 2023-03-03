// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; 
contract answer1 { 
    uint public myUint;
    bool public myBool;
    address public myAddress;
    string public myString;

    function getUint() public view returns (uint) {
      return myUint;
    }
    function getBool() public view returns (bool) {
      return myBool;
    }
    function getAddress() public view returns (address) {
      return myAddress;
    }
    function getString() public view returns (string memory) {
      return myString;
    }
}