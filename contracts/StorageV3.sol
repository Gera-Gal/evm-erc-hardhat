// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "./StorageV2.sol";

contract StorageV3 is Initializable, StorageV2, AccessControlUpgradeable {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN");
    bytes32 public constant PARTNER_ROLE = keccak256("PARTNER");

    function initializeV3(address admin) public reinitializer(3) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(ADMIN_ROLE, admin);
    }

    function setNumber(uint256 _number) public override onlyRole(ADMIN_ROLE) {
        storedNumber = _number;
        emit NumberUpdated(_number);
    }

    function setMessage(string memory _message) public override onlyRole(PARTNER_ROLE) {
        message = _message;
        emit MessageUpdated(_message);
    }
}
