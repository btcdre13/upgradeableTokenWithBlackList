const { ethers, upgrades } = require("hardhat");

const proxyAddress = "0xfF6b1B87Fa904B66c15b401224C993D44c4E6cE6";

async function main() {
    const MyTokenV2 = await ethers.getContractFactory("MyTokenV2");
    const upgraded = await upgrades.upgradeProxy(proxyAddress, MyTokenV2);

    const implementationAddress = await upgrades.erc1967.getImplementationAddress(proxyAddress);

    console.log("The current contract owner is: " + await upgraded.owner());
    console.log("Implementation contract address: " + implementationAddress);

}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
})