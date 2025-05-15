const { ethers } = require("hardhat");
const prompt = require('prompt-sync')();

async function main() {
  // Parámetros del constructor
  const name = prompt('Nombre del token: ') || "DefaultName";
  const symbol = prompt('Símbolo: ') || "DFT";
  const initialSupply = prompt('Suministro inicial: ') || ethers.ZeroAddress;
  
  console.log(`Desplegando con:\nNombre: ${name}\nSímbolo: ${symbol}\nSuministro inicial: ${initialSupply}`);
  
  // Obtenemos el contrato para desplegar
  const PokeCoin = await ethers.getContractFactory("PokeCoin");
  
  console.log("Desplegando contrato ERC20...");
  const pokeCoin = await PokeCoin.deploy(
    name,
    symbol,
    initialSupply
  );

  await pokeCoin.waitForDeployment();
  
  console.log("Contrato desplegado en:", await pokeCoin.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });