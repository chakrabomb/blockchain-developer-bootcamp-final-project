const Dapz = artifacts.require("Dapz");

module.exports = function (deployer) {
  deployer.deploy(Dapz, 1000000);
};