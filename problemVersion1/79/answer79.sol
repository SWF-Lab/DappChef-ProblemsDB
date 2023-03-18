// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IVersioned {
    function getVersion() external view returns (uint256);
}

// Implementation contract
contract MyContractV1 is IVersioned {
    string public message;

    function setMessage(string memory newMessage) public {
        message = newMessage;
    }

    function getVersion() external pure override returns (uint256) {
        return 1;
    }
}

// Proxy contract
contract answer79 is IVersioned {
    // Address of the current implementation contract
    address public implementation;
    MyContractV1 v1;
    MyContractV2 v2;

    constructor() {
        v1 = new MyContractV1();
        implementation = address(v1);
    }

    // Fallback function to forward calls to implementation contract
    fallback() external  {
        address _impl = implementation;

        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let result := delegatecall(gas(), _impl, ptr, calldatasize(), 0, 0)
            let size := returndatasize()
            returndatacopy(ptr, 0, size)

            switch result
            case 0 {revert(ptr, size)}
            default {return(ptr, size)}
        }
    }

    function getVersion() external view override returns (uint256) {
        return IVersioned(implementation).getVersion();
    }

    function updateV2() external {
      v2 = new MyContractV2();
      upgradeImplementation(address(v2));
    }


    // Function to upgrade implementation contract
    function upgradeImplementation(address newImplementation) public {
        implementation = newImplementation;
    }
}


contract MyContractV2 is IVersioned {
    uint256 public num;

    function setNum(uint256 _num) public {
        num = _num;
    }

    function getVersion() external pure override returns (uint256) {
        return 2;
    }
}