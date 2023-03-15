// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; 

contract answer44 {

    uint public userNum = 0;
    mapping(uint => Account) public Operators;
    function register(uint256 _num) public {
        for(uint i = 0; i < _num; i++){
            Operators[userNum] =  new Account(address(msg.sender));
            userNum += 1;
        }
    }

    uint public claimNum = 0;
    mapping(uint => bool) public claimed;
    function claim(uint256 _id, uint256 _num) public {
        require(!claimed[_id], "This operaotr has claimed!");
        Operators[_id].execute(address(this), getRegistrCallData(_num));
        claimed[_id] = true;
        claimNum += 1;
    }

    function getRegistrCallData(uint _id) internal pure returns (bytes memory) {
        return abi.encodeWithSelector(this.register.selector, _id);
    }
}

contract Account { 

    address payable public owner;

    constructor(address _owner) {
        owner = payable(_owner);
    }

    function transfer(address _target, uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable(_target).transfer(_amount);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
    
    function execute(address _target, bytes memory _data) external payable {
        (bool success, ) = _target.call{value: msg.value}(_data);
        require(success, "failed");
    }

    receive() external payable {}

}