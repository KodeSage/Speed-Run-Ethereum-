pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
  event SellTokens(address seller, uint256 amount);

  YourToken public yourToken;

 uint256 public constant tokensPerEth = 100;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }


  // ToDo: create a payable buyTokens() function:

 function buyTokens() public payable {
        uint256 amountOfTokens = msg.value * tokensPerEth;
        yourToken.transfer(msg.sender, amountOfTokens);

        emit BuyTokens(msg.sender, msg.value, amountOfTokens);
    }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
   function withdraw() public payable onlyOwner{
        payable(msg.sender).transfer(address(this).balance);
    }
//   function withdraw() public payable {
//         address owner = msg.sender;
//         require(msg.sender == owner, "Only owner can withdraw");
//         payable(msg.sender).transfer(address(this).balance);
//     }

  // ToDo: create a sellTokens() function:

    function sellTokens(uint256 amount) public payable {
        yourToken.transferFrom(msg.sender, address(this), amount);
        payable(msg.sender).transfer(amount / tokensPerEth);
        emit SellTokens(address(this), amount);
    }

}
