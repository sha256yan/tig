// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "test/TestHelper.sol";

contract TigUSDTest is TestHelper {

    uint256 amountUSDCAliceDeposits = 1e6; //$1
    uint256 amountDAIBobDeposits = 1e18; //$1000

    function setUp() public {
        _deployStables();

        mockUSDC.mint(alice, amountUSDCAliceDeposits);
        mockDAI.mint(bob, amountDAIBobDeposits);

        //bob makes a deposit to stableVault
        _userDepositsToStableVault(bob, address(mockDAI), amountDAIBobDeposits);

        //alice makes a deposit to stableVault
        _userDepositsToStableVault(alice, address(mockUSDC), amountUSDCAliceDeposits);
    }

    function testAliceWithdrawsDAI() public {
        assertEq(stableToken.balanceOf(alice), stableToken.balanceOf(bob));
    }
    
}
