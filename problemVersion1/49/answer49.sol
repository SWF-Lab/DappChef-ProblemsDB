// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer49 {
    LP public holdToken;
    StableCoin public dai;

    constructor() {
        holdToken = new LP();
        dai = new StableCoin();
    }

    /** Constructs the Data Structures */

    struct ClientInfo {
        uint256 startTime;
        uint256 stakingBalance;
        uint256 yieldBalance;
        bool isStaking;
    }

    mapping(address => ClientInfo) public ClientList;

    /** Getter Function */

    function getClientStartTime(address _addr) view public returns(uint256){
        return ClientList[_addr].startTime;
    }
    function getClientStakingBalance(address _addr) view public returns(uint256){
        return ClientList[_addr].stakingBalance;
    }
    function getClientYieldBalance(address _addr) view public returns(uint256){
        return ClientList[_addr].yieldBalance;
    }
    function getClientIsStaking(address _addr) view public returns(bool){
        return ClientList[_addr].isStaking;
    }

    /** Algorithms */

    function approveDAITransferFrom(uint256 _amount) public {
        uint256 old_allowance = dai.allowance(msg.sender, address(this));
        dai.approve(address(this), _amount + old_allowance);
    }

    function getAllowance() public view returns(uint256) {
        return dai.allowance(msg.sender, address(this));
    }

    function stakeTokens(uint256 _amount) public {
        require(_amount > 0, 'You cannot stake 0 tokens');

        uint256 oldDaiBal = dai.balanceOf(msg.sender);
        require( oldDaiBal > _amount, "insufficient DAI!");

        uint256 allowance = dai.allowance(msg.sender, address(this));
        require(allowance >= _amount, "Check the token allowance");
        
        dai.transferFrom(msg.sender, address(this), _amount);

        uint256 oldBalance = ClientList[msg.sender].stakingBalance;
        ClientList[msg.sender].stakingBalance = SafeMath.add(ClientList[msg.sender].stakingBalance, _amount);
        require(ClientList[msg.sender].stakingBalance > oldBalance, "Staking Bug!");

        ClientList[msg.sender].startTime = block.timestamp;
        ClientList[msg.sender].isStaking = true;
    }

    function calYield(address _address) public view returns(uint256){
        uint256 end = block.timestamp;
        uint256 totalTime = SafeMath.sub(end, ClientList[_address].startTime);
        return SafeMath.div(totalTime, 60);
        // Yield Per Minute
    }

    function withdrawYield() public {

        uint256 profit = calYield(msg.sender);
        uint256 withdraw = SafeMath.div(SafeMath.mul(ClientList[msg.sender].stakingBalance, profit), 100);

        if(ClientList[msg.sender].yieldBalance > 0){
            uint256 originalYBal = ClientList[msg.sender].yieldBalance;
            ClientList[msg.sender].yieldBalance = 0;
            withdraw = SafeMath.add(withdraw, originalYBal);
        }

        if(withdraw == 0 && ClientList[msg.sender].yieldBalance == 0){
            return ;
        }

        ClientList[msg.sender].startTime = block.timestamp;
        holdToken.transferFrom(address(this), msg.sender, withdraw);
    }

    function unstakeTokens() public {
        require(ClientList[msg.sender].isStaking, 'You are not staker!');
        
        uint256 balance = ClientList[msg.sender].stakingBalance;
        require(balance > 0, "There is no fund in your staking account!");

        ClientList[msg.sender].stakingBalance = 0;
        ClientList[msg.sender].isStaking = false;
        dai.transfer(msg.sender, balance);
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}


contract ERC20 is IERC20 {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name;
    string public symbol;
    uint8 public decimals = 18;

    constructor(string memory name_, string memory symbol_) {
        name = name_;
        symbol = symbol_;
    }

    function transfer(address recipient, uint amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool) {
        allowance[tx.origin][spender] = amount;
        emit Approval(tx.origin, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(address target, uint amount) public {
        balanceOf[target] += amount;
        totalSupply += amount;
        emit Transfer(address(0), target, amount);
    }

    function burn(address target, uint amount) public {
        balanceOf[target] -= amount;
        totalSupply -= amount;
        emit Transfer(target, address(0), amount);
    }
}

contract LP is ERC20 {

    uint256 public initialSupply = 10000;
    constructor() ERC20("MyToken", "MT") {
        mint(tx.origin, initialSupply);
    }
}

contract StableCoin is ERC20 {

    uint256 public initialSupply = 10000;
    constructor() ERC20("TestDAI", "tDAI") {
        mint(tx.origin, initialSupply);
    }
}

/**
 * @title SafeMath
 * @dev Unsigned math operations with safety checks that revert on error
 */
library SafeMath {
    /**
     * @dev Multiplies two unsigned integers, reverts on overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    /**
     * @dev Integer division of two unsigned integers truncating the quotient, reverts on division by zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Subtracts two unsigned integers, reverts on overflow (i.e. if subtrahend is greater than minuend).
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Adds two unsigned integers, reverts on overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    /**
     * @dev Divides two unsigned integers and returns the remainder (unsigned integer modulo),
     * reverts when dividing by zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}