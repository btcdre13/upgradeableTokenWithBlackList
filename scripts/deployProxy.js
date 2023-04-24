const { ethers, upgrades } = require("hardhat");

async function main() {
    const TokenV1 = await ethers.getContractFactory("MyTokenV1");
    const proxy = await upgrades.deployProxy(TokenV1);
    await proxy.deployed();

    const implementationAddress = await upgrades.erc1967.getImplementationAddress(proxy.address);

    console.log(`Proxy contract deployed at address: ${proxy.address}`);

    console.log(`Implementation contract deployed at address: ${implementationAddress}`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
})