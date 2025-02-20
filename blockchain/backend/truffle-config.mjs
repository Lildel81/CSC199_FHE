export default {
  networks: {
    development: {
      host: "127.0.0.1", // Localhost
      port: 8545,        // Standard Ethereum port
      network_id: "*",   // Any network
      gas: 50000000, //increase gas limit
      gasPrice: 0 //reduced gas prices.
    },
     fhevm: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*",
      gas: 50000000 //larger gass rate for FHE operations
    },

  },
     compilers: {
    solc: {
      version: "0.8.24", // Use locally installed version
      parser: "solcjs",  // Use the solc-js parser
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};
