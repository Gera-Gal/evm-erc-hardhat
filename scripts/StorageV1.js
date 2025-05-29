const { ethers, upgrades } = require("hardhat");
const prompt = require('prompt-sync')();
require('dotenv').config();

async function main() {
  // Cuenta base que podrá hacer actualizaciones al contrato
  const adminAddress = prompt('Dirección del admin: ') || "0xfe3b557e8fb62b89f4916b721be55ceb828dbd73";
  
  console.log(`Dirección recibida: ${adminAddress}`);
  
  // Obtenemos el contrato para desplegar
  const StorageV1 = await ethers.getContractFactory("StorageV1");
  
  console.log("Desplegando contrato StorageV1...");
  const storageV1 = await StorageV1.deploy();
  await storageV1.waitForDeployment();
  console.log("StorageV1 desplegado en:", await storageV1.getAddress());

  console.log("Desplegando contrato StorageProxy...");
  const storageProxy = await upgrades.deployProxy(StorageV1, [0], { initializer: 'initialize' });
  await storageProxy.waitForDeployment();
  console.log("StorageProxy desplegado en:", await storageProxy.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });