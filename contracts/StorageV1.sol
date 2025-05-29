// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract StorageV1 is Initializable {
    uint256 public storedNumber;
    address public owner;

    event NumberUpdated(uint256 newNumber);

    function initialize(uint256 _number) public initializer {
        owner = msg.sender;
        setNumber(_number);
    }

    function setNumber(uint256 _number) public virtual {
        require(msg.sender == owner, "Solo el owner puede actualizar");
        storedNumber = _number;
        emit NumberUpdated(_number);
    }

    function getNumber() public view returns (uint256) {
        return storedNumber;
    }
}
