var charity = artifacts.require("./charity.sol");

module.exports = function(deployer) {
  deployer.deploy(charity);
};
