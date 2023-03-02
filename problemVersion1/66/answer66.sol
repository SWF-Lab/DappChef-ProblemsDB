// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer66 {
    function operating(uint256 x, uint256 y, uint256 z, uint256 u) public pure returns(uint256) { 
        uint256 tmp; 
        tmp = SafeMath.safeAdd(x , type(uint256).max - 10);
        tmp = SafeMath.safeSub(y, 18);
        tmp = SafeMath.safeMul(z, type(uint256).max / 10);
        tmp = SafeMath.safeDiv(100, u);
        return tmp;
    }
}

// TODO: implement the SafeMath library, which will be used in `operating` function.
library SafeMath {
    function safeAdd(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            uint256 c = a + b;
            require(c >= a && c >= b, "SafeMath - Add: Overflow!");
            return c;     
        }
    }        

    function safeSub(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            require(a >= b, "SafeMath - Sub: Underflow!");
            return a - b;            
        }
    }

    function safeMul(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            if (a == 0 || b == 0) return 0;
            uint256 c = a * b;
            require(c / a == b, "SafeMath - Mul: Overflow!");
            return c;
        }
    }

    function safeDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            require( b > 0, "SafeMath - Div: divider cannot be 0");
            return a / b;       
        }
    }
}