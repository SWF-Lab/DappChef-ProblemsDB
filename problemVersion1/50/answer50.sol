// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer50 {
    event Start();
    event Bid(address indexed bidder, uint256 amount);
    event Withdraw(address indexed bidder, uint256 amount);
    event End(address winner, uint256 amount);

    address payable public seller;
    uint256 public nowTime;
    uint256 public endTime;
    bool public started;
    bool public ended;


    address public winner;
    uint256 public highestBid = 1000;
    mapping(address => uint256) public bids;

    constructor() {
      seller = payable(msg.sender);
    }

    function start() external {
        require(!started, "started");
        require(msg.sender == seller, "not seller");

        started = true;
        nowTime = 0;
        endTime = nowTime + 10;

        emit Start();
    }

    function bid() external payable {
        require(started, "The auction had not started");
        require(nowTime < endTime, "The auction had ended");
        uint256 newBid = bids[msg.sender] + msg.value;
        require(newBid > highestBid, "Your amount is lower than the highest bid.");

        winner = msg.sender;
        highestBid = msg.value;
        bids[msg.sender] = newBid;

        emit Bid(msg.sender, newBid);
    }

    function withdraw() external {
        require(msg.sender != winner, "Highest bidder cannot withdraw.");

        uint256 bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);

        emit Withdraw(msg.sender, bal);
    }

    function end() external {
        require(started, "The auction has not started");
        require(nowTime >= endTime, "The auction has not ended");
        require(!ended, "The auction had already ended");

        ended = true;

        emit End(winner, highestBid);
    }

    // These function is only for judging, in fact, time should be controlled by block.timestamp
    function setTimeToEnd() external {
      nowTime = endTime;
    }
    function getBiddersBid(address bidder) external view returns(uint256) {
      return bids[bidder];
    }

}