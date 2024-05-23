# Building on Avalanche - ETH + AVAX

## Overview
FlowerToken is a Solidity smart contract that uses the ERC20 token "FLOWER" (FLWR) to construct a basic token. This currency can be used on a gaming platform where users can acquire, transfer, exchange, and burn tokens for different in-game goods and incentives. Functions for verifying token balances and minting fresh tokens are also included in the contract.

## Getting Started

### To interact with the smart contract, you'll need:
An Ethereum smart contract development environment (such as Remix, Truffle, or Hardhat). An Ethereum wallet or client (like MetaMask) for testnet or mainnet deployment and communication with the contract. 

### Executing program
You can use Remix, an online Solidity IDE to run this program. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., FlowerToken.sol). Copy and paste the following code into the file:
 ```
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
```

## Code Explanation
1. **Minting:**
   - The contract owner can call the `mint` function and supply the recipient account along with the quantity of tokens to be minted in order to mint new tokens.
2. **Burning:**
   - Token holders have the ability to burn their own tokens by invoking the `burn` function and providing the desired burn quantity.
3. **Transfers:**
   - Token holders can use the `transfer` function to send tokens to another address by giving it the recipient address and the quantity of tokens to send.
4. **Allowance and TransferFrom:**
- The `approve` function allows token holders to authorize another address to transfer tokens on their behalf.
- Using the `transferFrom` function, the authorized address can then move tokens from the token holder's account to another address.
5. **Redeeming:**
- Players can redeem their tokens for in-game items by calling the `redeem` function with the item ID as a parameter.
6. **Checking Token Balance:**
- Players can check their token balance at any time using the `getBalance` function.
