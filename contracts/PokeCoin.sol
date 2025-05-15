// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PokeCoin is ERC20, Ownable {
    /**
     * @dev Constructor que inicializa el token ERC20
     * @param name Nombre del token (ej. "Mi Token")
     * @param symbol Símbolo del token (ej. "MTK")
     * @param initialSupply Cantidad inicial de tokens a crear
     */
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    ) ERC20(name, symbol) Ownable(msg.sender) {
        _mint(msg.sender, initialSupply);
    }

    /**
     * @dev Función para crear nuevos tokens (solo el owner puede ejecutarla)
     * @param to Dirección que recibirá los tokens creados
     * @param amount Cantidad de tokens a crear
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}