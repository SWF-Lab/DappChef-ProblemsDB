// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Cont'd
// Finish the ERC20
interface IERC20 {
  event Transfer(address indexed from, address indexed to, uint256 value);
  
  event Approval(address indexed owner, address indexed spender, uint256 value);
  
  function totalSupply() external view returns (uint256);
  
  function balanceOf(address account) external view returns (uint256);
  
  function transfer(address to, uint256 amount) external returns (bool);
  
  function allowance(address owner, address spender) external view returns (uint256);
  
  function approve(address spender, uint256 amount) external returns (bool);
  
  function transferFrom(address from, address to, uint256 amount) external returns (bool);
}


contract answer17 is IERC20 {
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

    function allowance(address _owner, address spender) public view returns (uint256){
      return _allowances[_owner][spender];
    }
  
    function approve(address spender, uint256 amount) external returns (bool){
        address _owner = msg.sender;
        _approve(_owner, spender, amount);
        return true;
    }

    function _approve(address _owner, address spender, uint256 amount) internal virtual {
        require(_owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
  
    function transferFrom(address from, address to, uint256 amount) external returns (bool){
        _spendAllowance(from, to, amount);
        _transfer(from, to, amount);
        return true;
    }

    function _spendAllowance(address _owner, address spender, uint256 amount) internal virtual {
        uint256 currentAllowance = _allowances[_owner][spender];
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(_owner, spender, currentAllowance - amount);
            }
        }
    }

    function _transfer(address from, address to, uint256 amount) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
            // Overflow not possible: the sum of all balances is capped by totalSupply, and the sum is preserved by
            // decrementing then incrementing.
            _balances[to] += amount;
        }

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual {}

    function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual {}
}


