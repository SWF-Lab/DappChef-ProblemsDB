// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer42 {

    mapping(bytes4 => bool) internal supportedInterfaces;
    bytes4 private constant _INTERFACE_ID_ERC2981 = 0x2a55205a;
    uint256 royaltyFraction = 10;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    function royaltyInfo(uint256 salePrice)
        public
        view
    returns (address receiver, uint256 royaltyAmount)
    {
        require(supportsInterface(_INTERFACE_ID_ERC2981));
        receiver = owner;
        royaltyAmount = (salePrice * royaltyFraction) / 100;
        return (receiver, royaltyAmount);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        returns (bool)
    {
        return supportedInterfaces[interfaceId];
    }

    function _registerInterface(bytes4 interfaceId) public{
        supportedInterfaces[interfaceId] = true;
    }

}