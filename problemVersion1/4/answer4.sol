// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; 
contract answer4 { 
    mapping(address => uint256) balanceOf;
    mapping(address => mapping(uint256 => bool)) AddressOwnNum;
    
    function setBalanceOf(address _user, uint256 _balance) public {
      balanceOf[_user] = _balance;
    }

    function setAddressOwnNFT(address _user, uint256 _num) public {
      AddressOwnNum[_user][_num] = true;
    }

    function getBalanceOf(address _user) public view returns (uint256) {
      return balanceOf[_user];
    }

    function getAddressOwnNum(address _user, uint256 _num) public view returns (bool) {
      return AddressOwnNum[_user][_num];
    }
}