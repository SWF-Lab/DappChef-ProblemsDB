// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17;

contract answer41 {

    function getMessageHash(
        address _solver,
        uint256 _problemNumber,
        uint256 _timestamp,
        address _approverKeyAddr,
        uint8 _approverIndex,
        uint256 _nonce
    ) public pure returns (bytes32) {
        return keccak256(
            abi.encodePacked(
                _solver, 
                _problemNumber, 
                _timestamp, 
                _approverKeyAddr,
                _approverIndex,
                _nonce
        ));
    }

    function getEthSignedMessageHash(bytes32 _messageHash)
        public
        pure
        returns (bytes32)
    {
        /*
        Signature is produced by signing a keccak256 hash with the following format:
        "\x19Ethereum Signed Message\n" + len(msg) + msg
        */
        return
            keccak256(
                abi.encodePacked(
                    "\x19Ethereum Signed Message:\n32",
                    _messageHash
                )
            );
    }

    function getHash(uint _input) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_input));
    }

    function VerifySignature(
        address _solver,
        uint256 _problemNumber,
        uint256 _timestamp,
        address _approverKeyAddr,
        uint8 _approverIndex,
        uint256 _nonce,
        bytes memory _signature
    ) public pure returns (bool) {
        bytes32 messageHash = getMessageHash(_solver, _problemNumber, _timestamp, _approverKeyAddr, _approverIndex, _nonce);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return (recoverSigner(ethSignedMessageHash, _signature) == _approverKeyAddr);
    }

    function recoverSigner(
        bytes32 _ethSignedMessageHash,
        bytes memory _signature
    ) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);

        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function splitSignature(bytes memory _sig)
        public
        pure
        returns (
            bytes32 r,
            bytes32 s,
            uint8 v
        )
    {
        require(_sig.length == 65, "invalid signature length");

        assembly {
            /*
            First 32 bytes stores the length of the signature
            add(sig, 32) = pointer of sig + 32
            effectively, skips first 32 bytes of signature
            mload(p) loads next 32 bytes starting at the memory address p into memory
            */

            // first 32 bytes, after the length prefix
            r := mload(add(_sig, 32))
            // second 32 bytes
            s := mload(add(_sig, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(_sig, 96)))
        }

        // implicitly return (r, s, v)
    }
}