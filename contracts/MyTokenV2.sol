// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;


import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract MyTokenV2 is Initializable, ERC20Upgradeable, ERC20BurnableUpgradeable, OwnableUpgradeable {

    mapping (address => bool) public blackListed;

    uint256 constant maxSupply = 200000000 * 10 ** 18;

    function initialize() external initializer {
        __ERC20_init("MyToken", "MTK");
        __ERC20Burnable_init();
        __Ownable_init();
    }

      function mint(address to, uint256 amount) public onlyOwner {
        require((totalSupply() + amount) <= maxSupply, "This operation exceeds the maximum cap!");
        _mint(to, amount);
    }



    function blackList(address user) public onlyOwner{
        blackListed[user] = true;
    } 

    function addToBlackList(address[] calldata users) public onlyOwner{
        for(uint256 i; i < users.length; i++){
            blackListed[users[i]] = true;
        }
    }

    function unBlackList(address user) public onlyOwner{
        blackListed[user] = false;
    }

    function removeFromBlackList(address[] calldata users) public onlyOwner {
        for(uint256 i; i < users.length; i++){
            blackListed[users[i]] = false;
        }
    }

    function checkBlackList(address user) public view returns(bool){
        return blackListed[user];
    }

    // overrides

     function transfer(address to, uint256 amount) public override returns (bool){
        require(!blackListed[msg.sender], "Your wallet has been blacklisted!");
        require(!blackListed[to], "The recipient's wallet has been blackListed");
        _transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public  override returns (bool) {
        require(!blackListed[msg.sender], "Your wallet has been blacklisted!");
        require(!blackListed[to], "The recipient's wallet has been blacklisted!");
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public  override returns (bool) {
        require(!blackListed[msg.sender], "Your wallet has been blacklisted!");
        _approve(msg.sender, spender, amount);
        return true;
    }

     function increaseAllowance(address spender, uint256 addedValue) public override returns (bool) {
        require(!blackListed[msg.sender], "Your wallet has been blacklisted");
        _approve(msg.sender, spender, allowance(msg.sender, spender) + addedValue);
        return true;
    }


}