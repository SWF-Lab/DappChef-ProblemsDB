// SPDX-License-Identifier: Apache License
pragma solidity ^0.8.17;

contract answer64 {
    function areThesePrime(uint256[] memory _nums) public pure returns(bool[] memory) {
        bool[] memory results = new bool[](_nums.length);
        for (uint256 i = 0; i < _nums.length; i++) {
            if (isPrime(_nums[i])) {
                results[i] = true;
            }
            else {
                results[i] = false;
            }
        }
        return results;
    }

    function isPrime(uint256 _num) public pure returns (bool) {
        bool result = true;
        for (uint256 i = 2; i * i <= _num; i++) {
            if (_num % i == 0) {
                result = false;                
                break;
            } 
        }
        return result;
    }
}