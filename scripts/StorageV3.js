const { ethers, upgrades } = require("hardhat");
const prompt = require('prompt-sync')();
require('dotenv').config();

async function main() {
  // Obtenemos el contrato para desplegar
  const StorageV3 = await ethers.getContractFactory("StorageV3");
  
  console.log("Desplegando contrato StorageV3...");
  const storageV3 = await StorageV3.deploy();
  await storageV3.waitForDeployment();
  console.log("StorageV3 desplegado en:", await storageV3.getAddress());

  console.log("Actualizando contrato StorageProxy...");
  const storageProxy = await upgrades.upgradeProxy('0x05d91B9031A655d08E654177336d08543ac4B711', StorageV3);
  await storageProxy.waitForDeployment();
  console.log("StorageProxy actualizado");

  // Inicializamos la lógica nueva
  const tx = await storageProxy.initializeV3('0xfe3b557e8fb62b89f4916b721be55ceb828dbd73');
  await tx.wait();
  console.log("Y configurado con initializeV3");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });