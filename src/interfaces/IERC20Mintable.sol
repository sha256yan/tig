//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IERC20Mintable is IERC20 {
    function mintFor(address, uint256) external;
    function burnFrom(address, uint256) external;
    function decimals() external view returns (uint);
}