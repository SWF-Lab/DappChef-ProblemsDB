// SPDX-License-Identifier: MIT
// ref: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol
pragma solidity ^0.8.17;

interface IERC165 {
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

interface IERC1155 is IERC165 {
    event TransferSingle(address indexed _operator, address indexed _from, address indexed _to, uint256 _id, uint256 _value);
    event TransferBatch(address indexed _operator, address indexed _from, address indexed _to, uint256[] _ids, uint256[] _values);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    event URI(string _value, uint256 indexed _id);

    function safeTransferFrom(address _from, address _to, uint256 _id, uint256 _value, bytes calldata _data) external;
    function safeBatchTransferFrom(address _from, address _to, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) external;
    function balanceOf(address _owner, uint256 _id) external view returns (uint256);
    function balanceOfBatch(address[] calldata _owners, uint256[] calldata _ids) external view returns (uint256[] memory);
    function setApprovalForAll(address _operator, bool _approved) external;
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}

interface IERC1155TokenReceiver {
    function onERC1155Received(address _operator, address _from, uint256 _id, uint256 _value, bytes calldata _data) external returns(bytes4);
    function onERC1155BatchReceived(address _operator, address _from, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) external returns(bytes4);
}

contract ERC1155 is IERC1155 {
    function supportsInterface(bytes4 interfaceID) external view returns (bool) {}
    function safeTransferFrom(address _from, address _to, uint256 _id, uint256 _value, bytes calldata _data) external {
        // TODO: please implement the ERC1155Receiver here to check if to is a contract that implemented onERC1155Received() 
        // hint: you just have to write the require() to complete this problem
        require(
            _to.code.length == 0 || IERC1155TokenReceiver(_to).onERC1155Received(_from, _from, _id, _value, "") == IERC1155TokenReceiver.onERC1155Received.selector
        );
    }

    function safeBatchTransferFrom(address _from, address _to, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) external {
        // TODO: please implement the ERC1155Receiver here to check if to is a contract that implemented onERC1155BatchReceived()
        // hint: you just have to write the require() to complete this problem
        require(
            _to.code.length == 0 || IERC1155TokenReceiver(_to).onERC1155BatchReceived(_from, _from, _ids, _values, "") == IERC1155TokenReceiver.onERC1155BatchReceived.selector
        );
    }
    function balanceOf(address _owner, uint256 _id) external view returns (uint256) {}
    function balanceOfBatch(address[] calldata _owners, uint256[] calldata _ids) external view returns (uint256[] memory) {}
    function setApprovalForAll(address _operator, bool _approved) external {}
    function isApprovedForAll(address _owner, address _operator) external view returns (bool) {}
}

contract answer39 is IERC1155TokenReceiver {
    ERC1155 tokenContract = new ERC1155();

    function checkSafeTransferFrom () public {
        tokenContract.safeTransferFrom(
            address(tokenContract), 
            address(this),
            0,
            1,
            "" 
        );
    }

    function checkSafeBatchTransferFrom (uint256[] calldata _ids, uint256[] calldata _values) public {
        tokenContract.safeBatchTransferFrom(
            address(tokenContract), 
            address(this),
            _ids,
            _values,
            "" 
        );
    }

    function onERC1155Received(
        address _operator, 
        address _from, 
        uint256 _id, 
        uint256 _value, 
        bytes calldata _data
    ) external returns(bytes4) {
        // TODO: please implement the ERC1155Receiver here to check if to is a contract that implemented onERC1155Received()
        return (this.onERC1155Received.selector);
    }

    function onERC1155BatchReceived(
        address _operator, 
        address _from, 
        uint256[] calldata _ids, 
        uint256[] calldata _values, 
        bytes calldata _data
    ) external returns(bytes4) {
        // TODO: please implement the ERC1155BatchReceiver here to check if to is a contract that implemented onERC1155BatchReceived()
        return (this.onERC1155BatchReceived.selector);
    }
}
