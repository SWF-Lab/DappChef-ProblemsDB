// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer13 {
  struct Food {
    string name;
    uint256 price;
  }

  Food[] public foods;

  function createFood(string calldata _name, uint256 _price) external {
    foods.push(Food(_name, _price));
  }

  function checkAns() external view returns (string memory, uint256) {
    return (foods[0].name, foods[0].price);
  }

}