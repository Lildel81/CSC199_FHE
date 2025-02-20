require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config(); // If using environment variables for security

module.exports = {
  solidity: "0.8.28",
  networks: {
    zama_local: {
      url: "http://localhost:8545",
      chainId: 31337,
      accounts: [process.env.PRIVATE_KEY], // Load private key securely
    },
  },
};

