const Migrations = artifacts.require("Migrations");
const EtherYou = artifacts.require("EtherYou");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(EtherYou);
};
