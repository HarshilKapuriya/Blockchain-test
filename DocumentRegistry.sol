// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DocumentRegistry {
    struct Document {
        address owner;
        uint256 timestamp;
    }

    mapping(bytes32 => Document) public storedHashes;

    // Store document hash
    function storeHash(bytes32 docHash) public {
        require(storedHashes[docHash].owner == address(0), "❌ Document already exists!");
        storedHashes[docHash] = Document(msg.sender, block.timestamp);
    }

    // Verify if hash exists
    function verifyHash(bytes32 docHash) public view returns (bool, address, uint256) {
        Document memory doc = storedHashes[docHash];
        if (doc.owner != address(0)) {
            return (true, doc.owner, doc.timestamp);
        }
        return (false, address(0), 0);
    }
}
