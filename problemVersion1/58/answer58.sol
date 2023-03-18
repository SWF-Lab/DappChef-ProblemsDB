// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Token1 {
  uint256 public totalSupply = 300; 
  mapping(address => uint256) public balanceOf;

  constructor(address owner) {
    balanceOf[owner] = totalSupply;
  }

  function transferFrom(address from, address to, uint256 amount) external {
    balanceOf[from] -= amount;
    balanceOf[to] += amount;
  }
  function transfer(address to, uint256 amount) external {
    balanceOf[msg.sender] -= amount;
    balanceOf[to] += amount;
  }
}

contract Token2 {
  uint256 public totalSupply = 100; 
  mapping(address => uint256) public balanceOf;

  constructor(address owner) {
    balanceOf[owner] = totalSupply;
  }

  function transferFrom(address from, address to, uint256 amount) external {
    balanceOf[from] -= amount;
    balanceOf[to] += amount;
  }
  function transfer(address to, uint256 amount) external {
    balanceOf[msg.sender] -= amount;
    balanceOf[to] += amount;
  }
}

contract answer58 {
    Token1 public token1Contract;
    Token2 public token2Contract;
    address public token1;
    address public token2;
    
    mapping(address => mapping(address => uint256)) public reserves;
    mapping(address => mapping(address => mapping(address => uint256))) public deposits;

    function init() external {
      token1Contract = new Token1(msg.sender);
      token2Contract = new Token2(msg.sender);
      token1 = address(token1Contract);
      token2 = address(token2Contract);
    }

    function exchange1for2(uint256 amount1) external {
        require(amount1 > 0, "amount1 < 0");
        require(reserves[token1][token2] > 0 && reserves[token2][token1] > 0, "Invalid token pair");

        uint256 amount2 = amount1 * reserves[token2][token1] / reserves[token1][token2];
        require(amount2 > 0, "Invalid exchange amount");

        token1Contract.transferFrom(msg.sender, address(this), amount1);
        token2Contract.transfer(msg.sender, amount2);

        reserves[token1][token2] += amount1;
        reserves[token2][token1] -= amount2;
    }

    function addReserves1(uint256 amount1) external {
        require(amount1 > 0, "Invalid reserve amount");
        token1Contract.transferFrom(msg.sender, address(this), amount1);
        reserves[token1][token2] += amount1;
        deposits[token1][token2][msg.sender] += amount1;
    }

    function addReserves2(uint256 amount2) external {
        require(amount2 > 0, "Invalid reserve amount");
        token2Contract.transferFrom(msg.sender, address(this), amount2);
        reserves[token2][token1] += amount2;
        deposits[token2][token1][msg.sender] += amount2;
    }

    function removeReserves1(uint256 amount1) external {
        require(amount1 > 0, "Invalid reserve amount");
        require(deposits[token1][token2][msg.sender] >= amount1, "Insufficient deposits");
        token1Contract.transfer(msg.sender, amount1);
        reserves[token1][token2] -= amount1;
        deposits[token1][token2][msg.sender] -= amount1;
    }
    function removeReserves2(uint256 amount2) external {
        require(amount2 > 0, "Invalid reserve amount");
        require(deposits[token2][token1][msg.sender] >= amount2, "Insufficient deposits");
        token1Contract.transfer(msg.sender, amount2);
        reserves[token2][token1] -= amount2;
        deposits[token2][token1][msg.sender] -= amount2;
    }

    function getToken1Balance(address _addr) external view returns (uint256) {
      return token1Contract.balanceOf(_addr);
    }
    function getToken2Balance(address _addr) external view returns (uint256) {
      return token2Contract.balanceOf(_addr);
    }
    function getReserves1() external view returns(uint256) {
      return reserves[token1][token2];
    }
    function getReserves2() external view returns(uint256) {
      return reserves[token2][token1];
    }

}
