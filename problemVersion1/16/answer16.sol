// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IERC20 {
  event Transfer(address indexed from, address indexed to, uint256 value);
  
  event Approval(address indexed owner, address indexed spender, uint256 value);
  
  function totalSupply() external view returns (uint256);
  
  function balanceOf(address account) external view returns (uint256);
  
  function transfer(address to, uint256 amount) external returns (bool);
  
  // function allowance(address owner, address spender) external view returns (uint256);
  
  // function approve(address spender, uint256 amount) external returns (bool);
  
  // function transferFrom(address from, address to, uint256 amount) external returns (bool);
}


contract answer16 is IERC20 {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply = 100;
    address public owner;

    constructor() {
      owner = msg.sender;
      _balances[owner] = _totalSupply;
    }
    function totalSupply() external view returns (uint256) {
      return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256){
      return _balances[account];
    }

    function transfer(address recipient, uint256 amount) external returns (bool) {
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
}


