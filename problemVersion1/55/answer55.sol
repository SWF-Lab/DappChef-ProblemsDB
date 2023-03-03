// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract answer55 {
    bytes32 answer;

    //given data: 123, "0xf8601B6E1f265De57a691Ff64Ddc5e5f2cad17Ac"
    //should respond: 0x48b897a64460fecb557a65e107ebb920b3d98d944acac78e36d9582f1d1ea60b
    function getHash(uint256 value, address sender) public returns (bytes32) {
        bytes32 domainHash = keccak256(abi.encode(
            keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"),
            keccak256(bytes("answer55")),
            keccak256(bytes("1.0.0")),
            block.chainid,
            0xd9145CCE52D386f254917e481eB44e9943F39138 //this should be address(this)
        ));

        // leave the first keccak `problem55` as the solver see this contract ass `problem55`
        bytes32 structHash = keccak256(abi.encode(
            keccak256("problem55(uint256 value,address sender)"),
            value,
            sender
        ));

        answer = keccak256(abi.encodePacked(
          "\x19\x01",domainHash,structHash
        ));
        return answer;
    }

    function getAns() external view returns(bytes32) {
      return answer;
    }

}

