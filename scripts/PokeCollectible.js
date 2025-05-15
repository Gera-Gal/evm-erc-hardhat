const { ethers } = require("hardhat");
const prompt = require('prompt-sync')();
require('dotenv').config();

async function main() {
  // Parámetros del constructor
  const name = prompt('Nombre del NFT: ') || "DefaultName";
  const symbol = prompt('Símbolo: ') || "DFT";
  
  console.log(`Desplegando con:\nNombre: ${name}\nSímbolo: ${symbol}`);
  
  // Obtenemos el contrato para desplegar
  const PokeCollectible = await ethers.getContractFactory("PokeCollectible");
  
  console.log("Desplegando contrato ERC721...");
  const pokeCollectible = await PokeCollectible.deploy(
    name,
    symbol
  );

  await pokeCollectible.waitForDeployment();
  
  console.log("Contrato desplegado en:", await pokeCollectible.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });