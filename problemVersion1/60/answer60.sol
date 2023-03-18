// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MockERC20 {
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

contract StableCoin {
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

contract answer60 {
    enum OptionType { 
        CALL, 
        PUT 
    }
    
    enum OptionState {
        Open,
        Bought,
        Cancelled,
        Exercised
    }

    struct Option {
        address writer;
        address owner;
        uint256 price;
        uint256 amount;
        uint256 strikePrice;
        uint256 expiration;
        OptionType optionType;
        OptionState optionState;
    }

    mapping (uint256 => Option) public options;
    uint256 private optionId_ = 0;
    uint256 public nowTime = 16848341;
    MockERC20 public erc20;
    StableCoin public stableCoin;

    function init() external {
      erc20 = new MockERC20(msg.sender);
      stableCoin = new StableCoin(msg.sender);
    }

    function createPutOption(uint256 amount, uint256 price, uint256 strikePrice, uint256 expiration) 
        external 
        returns (uint256)
    {
        require(expiration > nowTime, "Option has expired");
        require(amount > 0, "Invalid amount");

        options[optionId_] = Option(
          msg.sender, msg.sender, price, amount, strikePrice, expiration, OptionType.PUT, OptionState.Open
        );
        optionId_ ++;
        return optionId_ - 1;
    }

    function buyPutOption(uint256 _optionId) external {
      Option memory option = options[_optionId];
      require(option.optionType == OptionType.PUT, "NOT A PUT");

      uint256 totalPrice = option.amount * option.strikePrice;
      stableCoin.transferFrom(msg.sender, option.writer, option.price);
      stableCoin.transferFrom(option.writer, address(this), totalPrice);

      options[_optionId].owner = msg.sender;
      options[_optionId].optionState = OptionState.Bought;
    }

    function exercisePutOption(uint256 _optionId, uint256 amount) external {
      Option memory option = options[_optionId];
      require(msg.sender == option.owner, "not buyer");
      require(option.optionState == OptionState.Bought, "not bought");
      require(option.expiration <= nowTime, "hasnt expire");

      require(option.amount >= amount, "not enough amount");
      uint256 totalPrice = amount * option.strikePrice;
      stableCoin.transferFrom(address(this), msg.sender, totalPrice);
      erc20.transferFrom(msg.sender, option.writer, amount);

      uint256 lastStableCoin = option.amount * option.strikePrice - totalPrice;
      erc20.transferFrom(address(this), option.writer, lastStableCoin);

      options[_optionId].optionState = OptionState.Exercised; 
    }
    
    function cancelOption(uint256 _optionId) external {
      Option memory option = options[_optionId];
      require(msg.sender == option.writer, "not writer");
      require(option.expiration < nowTime, "hasnt expired");
      require(option.optionState == OptionState.Bought, "not bought or exercised");
      stableCoin.transfer(msg.sender, option.amount * option.strikePrice);
      options[_optionId].optionState = OptionState.Cancelled; 
    }

    function addTime() external {
      nowTime += 1;
    }
    function getERC20BalanceOf(address addr) external view returns (uint256) {
      return erc20.balanceOf(addr);
    }
    function getStableCoinBalanceOf(address addr) external view returns (uint256) {
      return stableCoin.balanceOf(addr);
    }
}
