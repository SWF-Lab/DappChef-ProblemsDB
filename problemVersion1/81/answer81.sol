// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

pragma solidity ^0.8.0;

contract EscowedToken {
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


contract answer81 {
    address public buyer;
    address public seller;
    address public arbiter;
    uint public amount;
    bool public approvedByBuyer;
    bool public approvedByArbiter;
    EscowedToken escowed;
    
    constructor() {
        escowed = new EscowedToken(tx.origin);
        buyer = tx.origin;
        seller = tx.origin;
        arbiter = tx.origin;
        amount = 50;
        escowed.transferFrom(tx.origin, address(this), 50);
    }
    
    function approveByBuyer() public {
        require(msg.sender == buyer);
        approvedByBuyer = true;
    }
    
    function approveByArbiter() public {
        require(msg.sender == arbiter);
        approvedByArbiter = true;
    }
    
    function releaseAmount() public {
        require(approvedByBuyer && approvedByArbiter, "not approved");
        escowed.transfer(buyer, amount);
    }
    
    function refundAmount() public {
        require(!approvedByBuyer || !approvedByArbiter, "has already approved");
        escowed.transfer(seller, amount);
    }
}
