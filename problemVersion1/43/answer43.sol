// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer43 {
    mapping(uint256 => State) internal states;
    uint256 fee = 1200000000000000 wei;
    address operator = 0xdCca4cE55773359E191110Eeb21E0413f770032B;
    uint256 expiration = 16786754960000000000;
    event getNowFingerprint(address indexed tokenID, bytes32 indexed fingerprint);

    struct State {
        address asset1;
        address asset2;
        uint256 amount1;
        uint256 amount2;
        uint256 fee; // Immutable
        address operator; // Immutable
        uint256 expiration; // Parameter dependent on a block.timestamp
    }

    function setState(
        uint256 tokenId,
        address asset1,
        address asset2,
        uint256 amount1,
        uint256 amount2
    ) public {
        states[tokenId] = State(
            asset1,
            asset2,
            amount1,
            amount2,
            fee,
            operator,
            expiration
        );
    }

    /// @dev State fingerprint getter.
    /// @param tokenId Id of a token state in question.
    /// @return Current token state fingerprint.
    function getStateFingerprint(
        uint256 tokenId
    ) public payable returns (bytes32) {
        State storage state = states[tokenId];

        (bool sent, ) = operator.call{value: fee}("");
        require(sent, "Failed to send Ether");

        // TODO: Please keccak the encoded state:
        // You should encode four elements of state: (asset1, asset2, amount1, amount2, expired or not)
        bytes32 fingerprint = keccak256(
            abi.encode(
                state.asset1,
                state.asset2,
                state.amount1,
                state.amount2,
                // state.fee don't need to be part of the fingerprint computation as it is immutable
                // state.operator don't need to be part of the fingerprint computation as it is immutable
                block.timestamp >= state.expiration
            )
        );
        emit getNowFingerprint(msg.sender, fingerprint);

        return fingerprint;
    }
}
