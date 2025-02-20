sudo docker run -i -p 8545:8545 -p 8546:8546 --rm --name fhevm ghcr.io/zama-ai/ethermint-dev-node:v0.2.4 --rpc.gas-cap 50000000 --rpc.tx-fee-cap 0
