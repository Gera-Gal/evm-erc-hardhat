/** @type import('hardhat/config').HardhatUserConfig */
require("@nomicfoundation/hardhat-toolbox");
require('@openzeppelin/hardhat-upgrades');
require('dotenv').config();

module.exports = {
  solidity: "0.8.28",
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545",
    },
    besu: {
      url: "http://192.168.0.8:8545",
      accounts: [process.env.BESU_PRIVATE_KEY]
    },
    amoy: {
      url: "https://rpc-amoy.polygon.technology/", // RPC de Amoy
      accounts: [process.env.AMOY_PRIVATE_KEY], // Usa una variable de entorno para tu clave privada
      chainId: 80002, // Chain ID de Amoy
    }
  }
};
