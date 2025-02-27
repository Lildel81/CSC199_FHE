const Election = artifacts.require("Election");

module.exports = function (deployer) {
    deployer.deploy(Election, { gas: 50000000 });
};
