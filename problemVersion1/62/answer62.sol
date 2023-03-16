// SPDX-License-Identifier: MIT
// ref: https://solidity-by-example.org/app/erc721/, 
pragma solidity ^0.8.17;

/*
In this problem, you have to convert a static NFT (with a solid tokenUri) into a dynamic NFT with 3 stages.
After each transfer (including transferFrom, saferTransferFrom) the stage changes to the next level.
the flow is like:

A -> mint a token (metadata: id = 0, stage = 0)
                        |
                        V
A -- transfer the token to B --> token (metadata: id = 0, stage = 1)
                        |
                        V
B -- transfer the token to A --> token (metadata: id = 0, stage = 2)
                        |
                        V
A -- transfer the token to B --> token (metadata: id = 0, stage = 2) (after 2nd transfer, the stage won't evolve)
*/

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

interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

contract ERC721 is IERC721Metadata {
    string internal _name;
    string internal _symbol;
    // TODO: should maintain an `_baseUri` ARRAY with length 3 
    string[3] internal _baseUri;


    constructor(string memory name_, string memory symbol_, string[3] memory baseUri_) {
        _name = name_;
        _symbol = symbol_;
        // TODO: update the input baseUri_ here (remember it's an array)
        for (uint8 i = 0; i < 3; i++) 
            _baseUri[i] = baseUri_[i];
    }

    event Transfer(address indexed from, address indexed to, uint indexed id);
    event Approval(address indexed owner, address indexed spender, uint indexed id);
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );

    // Mapping from token ID to owner address
    mapping(uint => address) internal _ownerOf;

    // Mapping owner address to token count
    mapping(address => uint) internal _balanceOf;

    // Mapping from token ID to approved address
    mapping(uint => address) internal _approvals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) public isApprovedForAll;

    // Mapping from tokenId to its stage (default will be 0)
    // stage 1: 0 => _baseUri[0]
    // stage 2: 1 => _baseUri[1]
    // stage 3: 2 => _baseUri[2]
    mapping(uint256 => uint8) public tokenStage;

    
    function transfer(address from, address to, uint256 id) private {
        require(from == _ownerOf[id], "from != owner");
        require(to != address(0), "transfer to zero address");
        require(_isApprovedOrOwner(from, msg.sender, id), "not authorized");

        _balanceOf[from]--;
        _balanceOf[to]++;
        _ownerOf[id] = to;
        
        // TODO: should maintain the stage when you transfer a token
        if (tokenStage[id] < 2) tokenStage[id] ++; 
    } 

    function supportsInterface(bytes4 interfaceId) external pure returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC165).interfaceId;
    }

    function ownerOf(uint id) public view returns (address owner) {
        owner = _ownerOf[id];
        require(owner != address(0), "token doesn't exist");
    }

    function balanceOf(address owner) external view returns (uint) {
        require(owner != address(0), "owner = zero address");
        return _balanceOf[owner];
    }

    function setApprovalForAll(address operator, bool approved) external {
        isApprovedForAll[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function approve(address spender, uint id) external {
        address owner = _ownerOf[id];
        require(
            msg.sender == owner || isApprovedForAll[owner][msg.sender],
            "not authorized"
        );

        _approvals[id] = spender;

        emit Approval(owner, spender, id);
    }

    function getApproved(uint id) external view returns (address) {
        require(_ownerOf[id] != address(0), "token doesn't exist");
        return _approvals[id];
    }

    function _isApprovedOrOwner(
        address owner,
        address spender,
        uint id
    ) internal view returns (bool) {
        return (spender == owner ||
            isApprovedForAll[owner][spender] ||
            spender == _approvals[id]);
    }

    function transferFrom(address from, address to, uint id) public {
        transfer(from, to, id);

        delete _approvals[id];

        emit Transfer(from, to, id);
    }

    function safeTransferFrom(address from, address to, uint id) external {
        transferFrom(from, to, id);

        require(
            to.code.length == 0 ||
                IERC721Receiver(to).onERC721Received(msg.sender, from, id, "") ==
                IERC721Receiver.onERC721Received.selector,
            "unsafe recipient"
        );
    }

    function safeTransferFrom(
        address from,
        address to,
        uint id,
        bytes calldata data
    ) external {
        transferFrom(from, to, id);

        require(
            to.code.length == 0 ||
                IERC721Receiver(to).onERC721Received(msg.sender, from, id, data) ==
                IERC721Receiver.onERC721Received.selector,
            "unsafe recipient"
        );
    }

    function _mint(address to, uint id) external {
        require(to != address(0), "mint to zero address");
        require(_ownerOf[id] == address(0), "already minted");

        _balanceOf[to]++;
        _ownerOf[id] = to;

        emit Transfer(address(0), to, id);
    }

    function _burn(uint id) internal {
        address owner = _ownerOf[id];
        require(owner != address(0), "not minted");

        _balanceOf[owner] -= 1;

        delete _ownerOf[id];
        delete _approvals[id];

        emit Transfer(owner, address(0), id);
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function tokenURI(uint256 id) external view returns (string memory) {
        // TODO: should check which stage the token is at and return the correct tokenUri!
        string memory uri;
        uri = _baseUri[ tokenStage[id] ];
        return string.concat(uri, String.toString(id) , ".json");
    }
}

contract answer62 {
    ERC721 public tokenContract;
    mapping(uint256 => Account) public Operators;

    constructor(string[3] memory baseUri) {
        tokenContract = new ERC721(
            "Dynamic NFT",
            "DNFT",
            baseUri
        );

        // for judging system
        for (uint256 i = 0; i < 2 ; i++) {
            Operators[i] = new Account(msg.sender);
        }

        tokenContract._mint(address(Operators[0]), 0);
    } 

    function getTransferFromCallData(address _from, address _to, uint256 _id) public view returns(bytes memory) {
        return abi.encodeWithSelector(tokenContract.transferFrom.selector, _from, _to, _id);
    } 

    function getSafeTransferFromCallData(address _from, address _to, uint256 _id) public pure returns(bytes memory) {
        bytes4 selector = bytes4(keccak256("safeTransferFrom(address,address,uint256)"));
        return abi.encodeWithSelector(selector, _from, _to, _id);
    }

    function checkOwner(uint256 ownerId, uint256 id) public view returns (bool) {
        return tokenContract.ownerOf(id) == address(Operators[ownerId]);
    }

    function transferToken(uint256 fromId, uint256 toId, uint256 id) public {
        address from = address(Operators[fromId]);
        address to = address(Operators[toId]);
        Operators[fromId].execute(address(tokenContract), getTransferFromCallData(from, to, id));        
    }

    function safeTransferToken(uint256 fromId, uint256 toId, uint256 id) public {
        address from = address(Operators[fromId]);
        address to = address(Operators[toId]);
        Operators[fromId].execute(address(tokenContract), getSafeTransferFromCallData(from, to, id));
    }

    function getTokenUri(uint256 _id) public view returns(string memory) {
        return tokenContract.tokenURI(_id);
    }
}

// for judge system
contract Account is IERC721Receiver { 

    address payable public owner;

    constructor(address _owner) {
        owner = payable(_owner);
    }

    function transfer(address _target, uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable(_target).transfer(_amount);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
    
    function execute(address _target, bytes memory _data) external payable {
        (bool success, ) = _target.call{value: msg.value}(_data);
        require(success, "failed");
    }

    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external returns (bytes4) {
        return this.onERC721Received.selector;
    }

    receive() external payable {}

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