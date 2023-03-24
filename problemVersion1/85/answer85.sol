// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract StableCoin {
  uint256 public totalSupply = 10000; 
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

contract LeveragedToken {
  uint256 public totalSupply = 1000; 
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

contract answer85 {
    uint public leverageRatio = 500;
    address public owner;
    uint256 public erc20Price = 100;

    StableCoin public stableCoin;
    LeveragedToken public erc20;

    struct Position {
        uint collateral;
        uint debt;
        uint openPrice;
    }

    mapping(address => Position) public positions;

    constructor() {
      stableCoin = new StableCoin(msg.sender);
      erc20 = new LeveragedToken(address(this));
    }

    function open(uint256 _collateral) external {

        uint256 amount = (_collateral * leverageRatio) / (erc20Price * 100) ;
        positions[msg.sender] = Position(_collateral, amount, erc20Price);
        stableCoin.transferFrom(msg.sender, address(this), _collateral);
        erc20.transfer(msg.sender, amount);

    }

    function close() external {
        Position memory position = positions[msg.sender];
        require(position.collateral > 0, "No open position");


        uint collateral = position.collateral;
        uint debt = position.debt;
        uint openPrice = position.openPrice;

        uint256 premiumRatio = (100 - (erc20Price * 100) / openPrice) * (leverageRatio / 100); 
        uint256 giveBack = premiumRatio * collateral / 100;
        erc20.transferFrom(msg.sender, address(this), debt);
        stableCoin.transfer(msg.sender, giveBack);

        delete positions[msg.sender];
    }

    function liquidate(address user) external {
        Position memory position = positions[user];
        require(position.collateral > 0, "No open position");
        uint openPrice = position.openPrice;
        require((100 - (erc20Price * 100) / openPrice) * (leverageRatio / 100) >= 100, "position is safe");
        erc20.transferFrom(user, address(this), position.debt);
        delete positions[user];
    }

    function setPrice(uint256 _price) external {
      erc20Price = _price;
    }
    function getStableBalanceOf() external view returns (uint256) {
      return stableCoin.balanceOf(msg.sender);
    }
    function getERC20BalanceOf() external view returns (uint256) {
      return erc20.balanceOf(msg.sender);
    }
}
