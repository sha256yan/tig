// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


interface IMockERC20 is IERC20 {
    function mint(address account, uint256 amount) external;
}


contract MockUSDC is ERC20 {

    constructor() ERC20("USDC", "USDC") {}

    function decimals() public view override returns (uint8) {
        return 6;
    }

    function mint(address account, uint256 amount) external {
        _mint(account, amount);
    }
}



contract MockDAI is ERC20 {

    constructor() ERC20("DAI", "DAI") {}

    function decimals() public view override returns (uint8) {
        return 18;
    }

    function mint(address account, uint256 amount) external {
        _mint(account, amount);
    }
}