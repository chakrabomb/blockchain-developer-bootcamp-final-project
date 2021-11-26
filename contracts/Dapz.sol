// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Dapz is ERC20 {

    event Mint(address minter);

    constructor(uint256 supply) public ERC20("Dapz", "DAPZ") {
        _mint(msg.sender, supply * 10**decimals());
    }
}