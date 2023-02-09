// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface L1CrossDomainMessengerInterface{
    /**
     * Sends a cross domain message to the target messenger.
     * @param _target Target contract address.
     * @param _message Message to send to the target.
     * @param _gasLimit Gas limit for the provided message.
     */
    function sendMessage(
        address _target,
        bytes calldata _message,
        uint32 _gasLimit
    ) external;
}

contract answer97 {
    L1CrossDomainMessengerInterface internal ovmL1CrossDomainMessenger;

    constructor() {
        ovmL1CrossDomainMessenger = L1CrossDomainMessengerInterface(0x5086d1eEF304eb5284A0f6720f79403b4e9bE294);
    }

    function sendMessageToOptimismContract(address myOptimisticContractAddress, uint256 myFunctionParam) public {
        ovmL1CrossDomainMessenger.sendMessage(
            myOptimisticContractAddress,
            abi.encodeWithSignature(
                "sendCrossLayerMessage(uint256)",
                myFunctionParam
            ),
            1000000 // use whatever gas limit you want
        );
    }
}