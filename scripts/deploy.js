const hre = require("hardhat");

async function main() {
  // Get the ABI and Bytecode
  const abi = require("../build/Calculator.abi.json");
  const bytecode = require("../build/Calculator.bytecode.json");

  // Deploy the contract
  const Calculator = await hre.ethers.getContractFactory(abi, bytecode);
  const calculator = await Calculator.deploy();

  // Await Deploy
  await calculator.deployed();

  // Output
  console.log("Calculator Contract Deployed to : ", calculator.address);
}
// Run the function
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
