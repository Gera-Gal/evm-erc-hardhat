// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PokeCollectible is ERC721URIStorage, Ownable {

    /**
     * @dev Constructor que inicializa el token ERC721
     * @param name Nombre del token (ej. "Mi Token")
     * @param symbol Símbolo del token (ej. "MTK")
     */
    constructor(string memory name, string memory symbol) ERC721(name, symbol) Ownable(msg.sender) {}

    /**
     * @dev Función para crear nuevos tokens (solo el owner puede ejecutarla)
     * @param to Dirección que recibirá los tokens creados
     * @param tokenId Identificador del token
     * @param uri Metadatos, en los que se suelen incluir imágenes
     */
    function safeMint(address to, uint256 tokenId, string memory uri) public onlyOwner {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }
}
