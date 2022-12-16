// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "test/TestHelper.sol";

contract LockTest is TestHelper {
    uint256 amountUSDCAliceDeposits = 1e9; //$1000

    function setUp() public {
        _deployStables();
        _deployLock();

        //alice makes a deposit to stableVault
        _userDepositsToStableVault(alice, address(mockUSDC), amountUSDCAliceDeposits);

    }

    function testWithdrawExtendedLock() public {
        // make deposit with small amount and large period
        uint initAmountToLock = 1;
        uint depositDuration = 10; //10 days
        uint durationExtension = 2; //2 days

        _userDepositsToLock(alice, initAmountToLock, depositDuration);

        uint aliceDepositId = 1;

        _aliceExtendsLock(aliceDepositId, amountUSDCAliceDeposits - initAmountToLock, durationExtension);

        vm.warp(13 days); //pass the total lock time so alice can release funds

        emit log_uint(lock.totalLocked(address(stableToken)));

        vm.prank(alice);
        lock.release(aliceDepositId);
    }

    function _aliceExtendsLock(uint256 _id, uint256 _amount, uint256 _period) internal {
        vm.startPrank(alice);

        stableToken.approve(address(lock), _amount);
        lock.extendLock(_id, _amount, _period);
        vm.stopPrank();
    }
    
}
