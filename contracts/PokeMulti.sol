// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PokeMulti is ERC1155, Ownable {
    /**
     * @dev Constructor que inicializa el token ERC20
     * @param uri URI base para los tokens
     */
    constructor(string memory uri) ERC1155(uri) Ownable(msg.sender) {}

    /**
     * @dev Función para crear nuevos tokens (solo el owner puede ejecutarla)
     * @param to Dirección que recibirá los tokens creados
     * @param tokenId Identificador del token
     * @param value Cantidad a crear
     * @param data Algún mensaje que pueda proveer información adicional
     */
    function mint(
        address to,
        uint256 tokenId,
        uint256 value,
        bytes memory data
    ) public onlyOwner {
        _mint(to, tokenId, value, data);
    }

    /**
     * @dev Función para crear nuevos tokens (solo el owner puede ejecutarla)
     * @param to Dirección que recibirá los tokens creados
     * @param ids Identificadores de los tokens
     * @param amounts Cantidades a crear
     * @param data Algún mensaje que pueda proveer información adicional
     */
    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }
}