// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IERC165 {
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

interface IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    // event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    // event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function balanceOf(address owner) external view returns (uint256 balance);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    // function safeTransferFrom(address from, address to, uint256 tokenId) external;

    // function safeTransferFrom(
    //     address from,
    //     address to,
    //     uint256 tokenId,
    //     bytes calldata data
    // ) external;

    // function transferFrom(address from, address to, uint256 tokenId) external;

    // function approve(address to, uint256 tokenId) external;

    // function getApproved(uint256 tokenId) external view returns (address operator);

    // function setApprovalForAll(address operator, bool _approved) external;

    //function getApproved(uint256 tokenId) external view returns (address operator);

    // function isApprovedForAll(
    //     address owner,
    //     address operator
    // ) external view returns (bool);
}

contract ERC721 is IERC721 {
  mapping(uint256 => address) internal _ownerOf;
  mapping(address => uint256) internal _balanceOf;

  function supportsInterface(bytes4 interfaceId) external pure returns (bool) {
    return
      interfaceId == type(IERC721).interfaceId ||
      interfaceId == type(IERC165).interfaceId;
  }

  function _mint(address to, uint256 id) internal {
        require(to != address(0), "mint to zero address");
        require(_ownerOf[id] == address(0), "already minted");

        _balanceOf[to]++;
        _ownerOf[id] = to;

        emit Transfer(address(0), to, id);
  }

  function ownerOf(uint256 id) external view returns (address owner) {
    owner = _ownerOf[id];
    require(owner != address(0), "token doesn't exist");
  }

  function balanceOf(address owner) external view returns (uint256) {
    require(owner != address(0), "owner = zero address");
    return _balanceOf[owner];
  }

}

contract answer19 is ERC721 {

  function mint(address to, uint256 id) external {
        _mint(to, id);
  }

}

