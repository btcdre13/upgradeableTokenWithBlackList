// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract MyTokenV1 is Initializable, ERC20Upgradeable, ERC20BurnableUpgradeable, OwnableUpgradeable {

    mapping (address => bool) public blackListed;

    uint256 constant maxSupply = 200000000 * 10 ** 18;
    
    function initialize() external initializer {
        __ERC20_init("MyToken", "MTK");
        __Ownable_init();
        _mint(msg.sender, 200000000 * 10 ** decimals());
    }


}     