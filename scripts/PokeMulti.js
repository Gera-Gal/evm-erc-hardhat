const { ethers } = require("hardhat");
const prompt = require('prompt-sync')();
require('dotenv').config();

async function main() {
  // Parámetros del constructor
  const baseTokenURI = prompt('URI base de metadatos: ') || "ipfs://default-uri";
  
  console.log(`Desplegando con:\nURI base de tokens: ${baseTokenURI}`);
  
  // Obtenemos el contrato para desplegar
  const PokeMulti = await ethers.getContractFactory("PokeMulti");
  
  console.log("Desplegando contrato ERC1155...");
  const pokeMulti = await PokeMulti.deploy(
    baseTokenURI
  );

  await pokeMulti.waitForDeployment();
  
  console.log("Contrato desplegado en:", await pokeMulti.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });