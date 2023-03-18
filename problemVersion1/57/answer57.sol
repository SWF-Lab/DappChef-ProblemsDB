// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract CollateralERC20 {
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

contract BorrowedERC20 {
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

contract answer57 {
    BorrowedERC20 public borrowedToken;
    CollateralERC20 public collateralToken;
    uint256 borrowRatio = 80;
    uint256 borrowedPrice = 100;
    uint256 collateralPrice = 100;
    mapping(address => address) public s_tokenToPriceFeed;
    address[] public s_allowedTokens;
    mapping(address => uint256) public deposits;
    mapping(address => uint256) public borrows;

    // 5% Liquidation Reward
    uint256 public constant LIQUIDATION_REWARD = 5;
    // At 80% Loan to Value Ratio, the loan can be liquidated
    uint256 public constant LIQUIDATION_THRESHOLD = 80;
    uint256 public constant MIN_HEALH_FACTOR = 1e18;


    constructor() {
      borrowedToken = new BorrowedERC20(address(this));
      collateralToken = new CollateralERC20(tx.origin);
    }


    function depositCollateral(uint256 amount) external {
        deposits[msg.sender] += amount;
        collateralToken.transferFrom(msg.sender, address(this), amount);
    }

    function withdraw(uint256 amount) external {
        require(deposits[msg.sender] >= amount, "Not enough funds");
        require(
          (deposits[msg.sender] - amount) * collateralPrice * borrowRatio / 100 > borrowedPrice * borrows[msg.sender], 
          "Not enough collateral"
        );
        deposits[msg.sender] -= amount;
        collateralToken.transfer(msg.sender, amount);
    }

    function borrow(uint256 amount) external {
        require(borrowedToken.balanceOf(address(this)) >= amount, "Not enough tokens to borrow");
        require(deposits[msg.sender] * collateralPrice * borrowRatio / 100 > borrowedPrice * amount, "Not enough collateral");
        borrows[msg.sender] += amount;
        borrowedToken.transfer(msg.sender, amount);
    }

    function repay(uint256 amount) external {
        borrows[msg.sender] -= amount;
        borrowedToken.transferFrom(msg.sender, address(this), amount);
    }

    function liquidate(address account) external {
        
      require(canBeLiquidated(account), "Account can't be liquidated!");
      uint256 reward = deposits[account] * LIQUIDATION_REWARD / 100;
      collateralToken.transfer(msg.sender, reward);
      delete borrows[msg.sender];
      delete deposits[msg.sender];

    }
    function canBeLiquidated(address _account) public view returns (bool) {
      uint256 borrowedValue = borrows[_account] * borrowedPrice;
      uint256 depositValue = deposits[_account] * collateralPrice;
      uint256 liquidatedValue = borrowedValue * LIQUIDATION_THRESHOLD * MIN_HEALH_FACTOR / 100;
      return depositValue * MIN_HEALH_FACTOR <= liquidatedValue ? true : false; 
    }



    function setPrice(uint256 _price1, uint256 _price2) external {
      borrowedPrice = _price1;
      collateralPrice = _price2;
    }
    function getCollateralBalanceOf() external view returns (uint256) {
      return collateralToken.balanceOf(msg.sender);
    }
    function getBorrowedTokenBalanceOf() external view returns (uint256) {
      return borrowedToken.balanceOf(msg.sender);
    }



}
