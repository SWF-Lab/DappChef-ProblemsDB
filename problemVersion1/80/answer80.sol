// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Contract that will be created by the factory
contract Token {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    address public owner;

    mapping(address => uint256) public balanceOf;

    constructor(string memory _name, string memory _symbol, uint256 _totalSupply, address _owner) {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply;
        owner = _owner;

        balanceOf[_owner] = _totalSupply;
    }

    function transfer(address _to, uint256 _value) public {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    }
}

// Factory contract
contract answer80 {
    address[] public tokens;
    mapping(string => address) symbols;

    function createToken(string memory _name, string memory _symbol, uint256 _totalSupply) public {
        require(symbols[_symbol] == address(0), "Symbol already used");
        address newToken = address(new Token(_name, _symbol, _totalSupply, msg.sender));
        symbols[_symbol] = newToken;
        tokens.push(newToken);
    }

    function checkAns(string memory _symbol) external view returns (bool) {
      return tokens[0] == symbols[_symbol] ? true : false;
    }
}