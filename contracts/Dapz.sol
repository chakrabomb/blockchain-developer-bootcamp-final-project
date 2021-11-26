// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Dapz is ERC20 {

    event Mint(address minter);

    constructor() public ERC20("Dapz", "DAPZ") {}

}