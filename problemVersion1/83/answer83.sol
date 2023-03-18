// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract StakingToken {
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

contract RewardToken {
  uint256 public totalSupply = 1000000; 
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

contract answer83 {
    StakingToken public stakingToken;
    RewardToken public rewardToken;
    uint256 public nowTime = 16848340;
    uint256 public rewardPerSecond = 1; 

    mapping(address => uint256) public stakedAmount;
    mapping(address => uint256) public stakedTimestamp;

    constructor() {
        stakingToken = new StakingToken(tx.origin);
        rewardToken = new RewardToken(address(this));
    }

    function stake(uint256 _amount) external {
        require(_amount > 0, "Staking amount must be greater than 0");
        uint256 currentTimestamp = nowTime;
        uint256 staked = stakedAmount[msg.sender];
        uint256 stakedAt = stakedTimestamp[msg.sender];
        if (staked > 0) {
            uint256 pendingReward = calculateReward(staked, nowTime, stakedAt);
            if (pendingReward > 0) {
                rewardToken.transfer(msg.sender, pendingReward);
            }
        }
        stakedAmount[msg.sender] = staked + _amount;
        stakedTimestamp[msg.sender] = currentTimestamp;
        stakingToken.transferFrom(msg.sender, address(this), _amount);
    }

    function unstake(uint256 _amount) external {
        require(stakedAmount[msg.sender] >= _amount, "Insufficient staked amount");
        uint256 currentTimestamp = nowTime;
        uint256 staked = stakedAmount[msg.sender];
        uint256 stakedAt = stakedTimestamp[msg.sender];
        uint256 pendingReward = calculateReward(staked, currentTimestamp, stakedAt);
        if (pendingReward > 0) {
            rewardToken.transfer(msg.sender, pendingReward);
        }
        stakedAmount[msg.sender] = staked - _amount;
        stakedTimestamp[msg.sender] = currentTimestamp;
        stakingToken.transfer(msg.sender, _amount);
    }

    function calculateReward(uint256 _amount, uint256 _currentTimestamp, uint256 _stakedTimestamp) 
        public 
        view
        returns (uint256) 
    {
        uint256 timeDiff = _currentTimestamp - _stakedTimestamp;
        uint256 reward = (_amount * rewardPerSecond * timeDiff);
        return reward;
    }

    function addTime() external {
      nowTime += 1;
    }
    function getRewardBalanceOf() external view returns (uint256) {
      return rewardToken.balanceOf(msg.sender);
    }
    function getStakingBalanceOf() external view returns (uint256) {
      return stakingToken.balanceOf(msg.sender);
    }
}