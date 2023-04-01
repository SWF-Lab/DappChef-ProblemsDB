// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer35 {
    function stringConcat(string memory a, string memory b, string memory c) public pure returns(string memory) {
        return string.concat(a, " ", b, " ", c, ".");
    }
}