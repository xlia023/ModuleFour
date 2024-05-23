// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FlowerToken is ERC20, Ownable {
  event TokensMinted(address indexed receiver, uint256 amount);

  // Define item IDs and their corresponding prices to get the items
  enum items {
    Tulip_Bouquet,
    Rose_Bouquet,
    Mix_Bouquet,
    Special_Bouquet
  }
  mapping(items => uint256) public itemPrices;

  constructor() ERC20("Flower", "FLWR") Ownable(msg.sender) {
    _mint(msg.sender, 10000 * 0**decimals());

    // Set item prices that exist
    itemPrices[items.Tulip_Bouquet] = 699.00;
    itemPrices[items.Rose_Bouquet] = 599.00;
    itemPrices[items.Mix_Bouquet] = 999.00;
    itemPrices[items.Special_Bouquet] = 1299.00;
  }

  // Function to mint new tokens, only callable by the owner
  function mint(address _to, uint256 _amount) public onlyOwner {
    _mint(_to, _amount);
    emit TokensMinted(_to, _amount);
  }

  // Function to transfer tokens
  function transferTokens(address _to, uint256 _amount) public {
    _transfer(msg.sender, _to, _amount);
  }

  // Function to redeem tokens for in-game items
  function redeemTokens(items _item) public {
    uint256 itemPrice = itemPrices[_item];
    require(balanceOf(msg.sender) >= itemPrice, "You have insufficient balance. Please try again");
    _burn(msg.sender, itemPrice);
  }

  // Function to check token balance
  function checkTokenBalance(address _player) public view returns (uint256) {
    return balanceOf(_player);
  }

  // Function to burn tokens
  function burnTokens(uint256 _amount) public {
    require(balanceOf(msg.sender) >= _amount, "You have insufficient balance. Please try again");
    _burn(msg.sender, _amount);
  }
}