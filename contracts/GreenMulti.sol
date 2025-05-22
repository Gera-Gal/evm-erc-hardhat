// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract GreenMulti is ERC1155, AccessControl {
    bytes32 public constant CERTIFYING_AUTH_ROLE = keccak256("CERTIFYING_AUTH_ROLE");
    bytes32 public constant PRODUCING_CO_ROLE = keccak256("PRODUCING_CO_ROLE");

    uint256 public constant GREEN_TOKEN = 0;
    uint256 public constant GREEN_LAND = 1;
    uint256 public totalPropertyTitlesMinted = 0;
    uint256 public constant MAX_TITLES = 3;

    /**
     * @dev Constructor que inicializa el token ERC20
     * @param uri URI base para los tokens
     */
    constructor(string memory uri, address certifying_auth, address producing_co) ERC1155(uri) {
        _grantRole(CERTIFYING_AUTH_ROLE, certifying_auth);
        _grantRole(PRODUCING_CO_ROLE, producing_co);
    }

    /**
     * @dev Función para crear títulos de propiedad
     * @param to Dirección que recibirá un título de propiedad
     * @param data Metadata de título de propiedad
     */
    function mintTitle(address to, bytes memory data) public onlyRole(CERTIFYING_AUTH_ROLE) {
        require(totalPropertyTitlesMinted <= MAX_TITLES, "Ya se han asignado asignado todos los titulos");
        _mint(to, GREEN_LAND, 1, data); // 1 unidad por dirección = tipo NFT
        totalPropertyTitlesMinted += 1;
    }

    /**
     * @dev Función para crear retornos a pagar
     * @param to Dirección que recibirá un título de propiedad
     * @param data Mensaje referente al pago de retornos
     */
    function mintUserReturns(address to, uint256 amount, bytes memory data) public onlyRole(PRODUCING_CO_ROLE) {
        _mint(to, GREEN_TOKEN, amount, data); // se pueden transferir cuantos hagan falta
    }

    /**
     * @dev Función para crear nuevos tokens como beneficios extra
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
    ) public onlyRole(PRODUCING_CO_ROLE) {
        _mintBatch(to, ids, amounts, data);
    }

    // Sobrescribir supportsInterface para manejar ambas interfaces
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155, AccessControl) returns (bool) {
        return ERC1155.supportsInterface(interfaceId) || AccessControl.supportsInterface(interfaceId);
    }
}