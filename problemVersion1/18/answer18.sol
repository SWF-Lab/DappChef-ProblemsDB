// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IERC165 {
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

interface IAnother {
  function aFunction() external returns (bool);
  function bFunction() external returns (bool);
}

// IERC165: 0x01ffc9a7
// IAnother: 0x579ace26
contract answer18 is IERC165, IAnother {

    function supportsInterface(bytes4 interfaceId) external pure returns (bool) {
        return
            interfaceId == type(IERC165).interfaceId ||
            interfaceId == this.aFunction.selector ^ this.bFunction.selector;
    }

    function aFunction() external returns (bool) {}
    function bFunction() external returns (bool) {}
}


