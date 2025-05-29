const { ethers, upgrades } = require("hardhat");
const prompt = require('prompt-sync')();
require('dotenv').config();

async function main() {
  // Obtenemos el contrato para desplegar
  const StorageV2 = await ethers.getContractFactory("StorageV2");
  
  console.log("Desplegando contrato StorageV2...");
  const storageV2 = await StorageV2.deploy();
  await storageV2.waitForDeployment();
  console.log("StorageV2 desplegado en:", await storageV2.getAddress());

  console.log("Actualizando contrato StorageProxy...");
  const storageProxy = await upgrades.upgradeProxy('0x05d91B9031A655d08E654177336d08543ac4B711', StorageV2);
  await storageProxy.wait();
  console.log("StorageProxy actualizado");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });