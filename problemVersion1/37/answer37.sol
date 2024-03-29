// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IERC165 {
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

interface IERC721 is IERC165 {
    function balanceOf(address owner) external view returns (uint balance);

    function ownerOf(uint tokenId) external view returns (address owner);

    function safeTransferFrom(address from, address to, uint tokenId) external;

    function safeTransferFrom(
        address from,
        address to,
        uint tokenId,
        bytes calldata data
    ) external;

    function transferFrom(address from, address to, uint tokenId) external;

    function approve(address to, uint tokenId) external;

    function getApproved(uint tokenId) external view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) external;

    function isApprovedForAll(
        address owner,
        address operator
    ) external view returns (bool);
}

interface IERC721Metadata is IERC721 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function tokenURI(uint256 tokenId) external view returns (string memory);
}

contract ERC721 is IERC721Metadata {
    string internal _name;
    string internal _symbol;
    string internal _baseUri;

    constructor(string memory name_, string memory symbol_, string memory baseUri_) {
        _name = name_;
        _symbol = symbol_;
        _baseUri = baseUri_;
    }

    function supportsInterface(bytes4 interfaceID) external view returns (bool) {}
    function balanceOf(address owner) external view returns (uint balance) {}
    function ownerOf(uint tokenId) external view returns (address owner) {}
    function safeTransferFrom(address from, address to, uint tokenId) external view {}
    function safeTransferFrom(address from, address to, uint tokenId, bytes calldata data) external {}
    function transferFrom(address from, address to, uint tokenId) external {}
    function approve(address to, uint tokenId) external {}
    function getApproved(uint tokenId) external view returns (address operator) {}
    function setApprovalForAll(address operator, bool _approved) external {}
    function isApprovedForAll(address owner, address operator) external view returns (bool) {}
    function name() external view returns (string memory) {
        // TODO: complete this function to implement ERC721Metadata
        return _name;
    }

    function symbol() external view returns (string memory) {
        // TODO: complete this function to implement ERC721Metadata
        return _symbol;
    }
    function tokenURI(uint256 tokenId) external view returns (string memory) {
        // TODO: complete this function to implement ERC721Metadata
        return string.concat(_baseUri, String.toString(tokenId) , ".json");
    }
} 

contract answer37 {
    ERC721 public tokenContract;

    constructor(string memory name_, string memory symbol_, string memory baseUri_) {
        tokenContract = new ERC721(name_, symbol_, baseUri_);     
    }

    function getTokenName() public view returns(string memory) {
        return (tokenContract.name());
    }

    function getTokenSymbol() public view returns(string memory) {
        return (tokenContract.symbol());
    }

    function getTokenUri(uint256 tokenId) public view returns(string memory) {
        return (tokenContract.tokenURI(tokenId));
    }
    
}

library String {
    bytes16 private constant _SYMBOLS = "0123456789abcdef";
    function log10(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >= 10 ** 64) {
                value /= 10 ** 64;
                result += 64;
            }
            if (value >= 10 ** 32) {
                value /= 10 ** 32;
                result += 32;
            }
            if (value >= 10 ** 16) {
                value /= 10 ** 16;
                result += 16;
            }
            if (value >= 10 ** 8) {
                value /= 10 ** 8;
                result += 8;
            }
            if (value >= 10 ** 4) {
                value /= 10 ** 4;
                result += 4;
            }
            if (value >= 10 ** 2) {
                value /= 10 ** 2;
                result += 2;
            }
            if (value >= 10 ** 1) {
                result += 1;
            }
        }
        return result;
    }

    function toString(uint256 value) internal pure returns (string memory) {
        unchecked {
            uint256 length = log10(value) + 1;
            string memory buffer = new string(length);
            uint256 ptr;
            /// @solidity memory-safe-assembly
            assembly {
                ptr := add(buffer, add(32, length))
            }
            while (true) {
                ptr--;
                /// @solidity memory-safe-assembly
                assembly {
                    mstore8(ptr, byte(mod(value, 10), _SYMBOLS))
                }
                value /= 10;
                if (value == 0) break;
            }
            return buffer;
        }
    }
}