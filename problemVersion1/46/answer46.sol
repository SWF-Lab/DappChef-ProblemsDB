// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title SocialRecoveryWallet
 * @author verum
 */
contract answer46 {
    /************************************************
     *  STORAGE
     ***********************************************/

    /// @notice true if hash of guardian address, else false
    mapping(address => bool) public isGuardian;
    mapping(uint => Account) public Guardians;

    /// @notice stores the guardian threshold
    uint256 public threshold;

    /// @notice owner of the wallet
    address public owner;

    /// @notice true iff wallet is in recovery mode
    bool public inRecovery;

    /// @notice round of recovery we're in
    uint256 public currRecoveryRound;

    /// @notice mapping for bookkeeping when swapping guardians
    mapping(address => uint256) public guardianToRemovalTimestamp;

    struct Recovery {
        address proposedOwner;
        uint256 recoveryRound; // recovery round in which this recovery struct was created
        bool usedInExecuteRecovery; // set to true when we see this struct in RecoveryExecute
    }

    /// @notice mapping from guardian address to most recent Recovery struct created by them
    mapping(address => Recovery) public guardianToRecovery;

    /************************************************
     *  MODIFIERS & EVENTS
     ***********************************************/

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }

    modifier onlyGuardian() {
        require(isGuardian[msg.sender], "only guardian");
        _;
    }

    modifier notInRecovery() {
        require(!inRecovery, "wallet is in recovery mode");
        _;
    }

    modifier onlyInRecovery() {
        require(inRecovery, "wallet is not in recovery mode");
        _;
    }

    constructor() {
        for (uint i = 0; i < 3; i++) {
            Guardians[i] = new Account(address(msg.sender));
            isGuardian[address(Guardians[i])] = true;
        }

        threshold = 2;
        owner = 0xB42faBF7BCAE8bc5E368716B568a6f8Fdf3F84ec;
    }

    /************************************************
     *  Recovery
     ***********************************************/

    function executeExternalTx(
        address callee,
        uint256 value,
        bytes memory data
    ) external onlyOwner returns (bytes memory) {
        (bool success, bytes memory result) = callee.call{value: value}(data);
        require(success, "external call reverted");
        return result;
    }

    function initiateRecovery(
        address _proposedOwner
    ) external onlyGuardian notInRecovery {
        // we are entering a new recovery round
        currRecoveryRound++;
        guardianToRecovery[msg.sender] = Recovery(
            _proposedOwner,
            currRecoveryRound,
            false
        );
        inRecovery = true;
    }

    function supportRecovery(
        address _proposedOwner
    ) external onlyGuardian onlyInRecovery {
        guardianToRecovery[msg.sender] = Recovery(
            _proposedOwner,
            currRecoveryRound,
            false
        );
    }

    function cancelRecovery() external onlyOwner onlyInRecovery {
        inRecovery = false;
    }

    function executeRecovery(
        address newOwner
    ) public onlyGuardian onlyInRecovery {

        for (uint i = 0; i < 3; i++) {
            Recovery memory recovery = guardianToRecovery[address(Guardians[i])];

            require(
                recovery.recoveryRound == currRecoveryRound,
                "round mismatch"
            );
            require(
                recovery.proposedOwner == newOwner,
                "disagreement on new owner"
            );
            require(
                !recovery.usedInExecuteRecovery,
                "duplicate guardian used in recovery"
            );

            guardianToRecovery[address(Guardians[i])].usedInExecuteRecovery = true;
        }

        inRecovery = false;
        owner = newOwner;
    }

    /************************************************
     *  Guardian Management
     ***********************************************/

    function transferGuardianship(
        address newGuardian
    ) external onlyGuardian notInRecovery {
        // Don't let guardian queued for removal transfer their guardianship
        require(
            guardianToRemovalTimestamp[msg.sender] == 0,
            "guardian queueud for removal, cannot transfer guardianship"
        );
        isGuardian[msg.sender] = false;
        isGuardian[newGuardian] = true;
    }

    function initiateGuardianRemoval(address guardianAddr) external onlyOwner {
        // verify that the hash actually corresponds to a guardian
        require(isGuardian[guardianAddr], "not a guardian");

        // removal delay fixed at 3 days
        guardianToRemovalTimestamp[guardianAddr] = block.timestamp + 3 days;
    }

    function executeGuardianRemoval(
        address oldGuardianAddr,
        address newGuardianAddr
    ) external onlyOwner {
        require(
            guardianToRemovalTimestamp[oldGuardianAddr] > 0,
            "guardian isn't queued for removal"
        );
        require(
            guardianToRemovalTimestamp[oldGuardianAddr] <= block.timestamp,
            "time delay has not passed"
        );

        // Reset this the removal timestamp
        guardianToRemovalTimestamp[oldGuardianAddr] = 0;

        isGuardian[oldGuardianAddr] = false;
        isGuardian[newGuardianAddr] = true;
    }

    function cancelGuardianRemoval(address guardianAddr) external onlyOwner {
        guardianToRemovalTimestamp[guardianAddr] = 0;
    }

    function supportsInterface(
        bytes4 interfaceId
    ) external pure returns (bool) {
        if (
            interfaceId == 0x01ffc9a7 || // ERC165 interfaceID
            interfaceId == 0x150b7a02 || // ERC721TokenReceiver interfaceID
            interfaceId == 0x4e2312e0 // ERC1155TokenReceiver interfaceID
        ) {
            return true;
        }
        return false;
    }

    /************************************************
     *  guardianOp for Testing
     ***********************************************/

    function guardianOp_initiateRecovery() public {
        Guardians[0].execute(
            address(this),
            abi.encodeWithSelector(this.initiateRecovery.selector, msg.sender)
        );
    }

    function guardianOp_supportRecovery() public {
        for (uint i = 1; i < 3; i++) {
            Guardians[i].execute(
                address(this),
                abi.encodeWithSelector(
                    this.supportRecovery.selector,
                    msg.sender
                )
            );
        }
    }

    function guardianOp_executeRecovery() public {
        Guardians[0].execute(
            address(this),
            abi.encodeWithSelector(
                this.executeRecovery.selector,
                msg.sender
            )
        );
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
