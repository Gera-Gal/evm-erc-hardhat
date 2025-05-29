const { ethers } = require("hardhat");
const prompt = require('prompt-sync')();
require('dotenv').config();

async function main() {
  // Parámetros del constructor
  const baseTokenURI = prompt('URI base de metadatos: ') || "https://cdn.jsdelivr.net/gh/Gera-Gal/nft-cdn@main/metadata/token_{id}.json";
  const certifyingAuth = prompt('Dirección de autoridad certificadora: ') || "0xfe3b557e8fb62b89f4916b721be55ceb828dbd73";
  const producingCo = prompt('Dirección de compañía productora: ') || "0x627306090abaB3A6e1400e9345bC60c78a8BEf57";
  
  console.log(`Desplegando con:\nURI base de tokens: ${baseTokenURI}\nCertificadora: ${certifyingAuth}\nProductora: ${producingCo}`);
  
  // Obtenemos el contrato para desplegar
  const GreenMulti = await ethers.getContractFactory("GreenMulti");
  
  console.log("Desplegando contrato ERC1155...");
  const greenMulti = await GreenMulti.deploy(
    baseTokenURI,
    certifyingAuth,
    producingCo
  );

  await greenMulti.waitForDeployment();
  
  console.log("Contrato desplegado en:", await greenMulti.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });