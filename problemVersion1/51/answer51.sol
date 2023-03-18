// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer51 {
    uint private constant DURATION = 15;

    address payable public immutable seller;
    uint public immutable startingPrice;
    uint public immutable startAt;
    uint public immutable expiresAt;
    uint public immutable discountRate;
    bool public ended = false;

    // mock of block.timestamp
    uint256 public nowTime = 1677679389;

    constructor() {
        seller = payable(tx.origin);
        startingPrice = 1000;
        startAt = nowTime;
        expiresAt = nowTime + DURATION;
        discountRate = 10;

        require(startingPrice >= discountRate * DURATION, "starting price < min");
    }

    function getPrice() public view returns (uint) {
        uint256 timeElapsed = nowTime - startAt;
        uint256 discount = discountRate * timeElapsed;
        return startingPrice - discount;
    }

    function buy() external payable {
        require(!ended, "The auction had ended");
        require(nowTime < expiresAt, "auction had expired");

        uint256 price = getPrice();
        require(msg.value >= price, "not enough ETH");

        uint256 refund = msg.value - price;  
        if (refund > 0) {
            payable(msg.sender).transfer(refund);
        }
        ended = true;
    }

    //functions for judging
    function addNowTime(uint256 addTime) external {
      nowTime += addTime;
    }
}
