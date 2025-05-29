const { ethers, upgrades } = require("hardhat");
const prompt = require('prompt-sync')();
require('dotenv').config();

async function main() {
  const proxyAddress = prompt('Dirección del proxy: ') || "0x9a3DBCa554e9f6b9257aAa24010DA8377C57c17e";
  
  console.log(`Dirección recibida: ${proxyAddress}`);
  // Obtenemos el contrato para desplegar
  const StorageV2 = await ethers.getContractFactory("StorageV2");
  
  console.log("Desplegando contrato StorageV2...");
  const storageV2 = await StorageV2.deploy();
  await storageV2.waitForDeployment();
  console.log("StorageV2 desplegado en:", await storageV2.getAddress());

  console.log("Actualizando contrato StorageProxy...");
  const storageProxy = await upgrades.upgradeProxy(proxyAddress, StorageV2);
  await storageProxy.waitForDeployment();
  console.log("StorageProxy actualizado");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });