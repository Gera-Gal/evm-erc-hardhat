// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract StorageProxy is TransparentUpgradeableProxy {
    constructor(address _logic, address admin, bytes memory _data)
        TransparentUpgradeableProxy(_logic, admin, _data) {}
}
