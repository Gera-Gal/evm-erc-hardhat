// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./StorageV1.sol";

contract StorageV2 is Initializable, StorageV1 {
    string public message;

    event MessageUpdated(string newMessage);

    function initializeV2() public reinitializer(2) {
        message = "";
    }

    function setMessage(string memory _message) public virtual {
        require(msg.sender == owner, "Solo el owner puede actualizar");
        message = _message;
        emit MessageUpdated(_message);
    }

    function getMessage() public view returns (string memory) {
        return message;
    }
}
