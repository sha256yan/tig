// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Lock.sol";
import "src/BondNFT.sol";
import "src/GovNFT.sol";
import "src/PairsContract.sol";
import "src/Position.sol";
import "src/Referrals.sol";
import "src/StableToken.sol";
import "src/StableVault.sol";
import "src/Trading.sol";

import "test/mocks/ERC20.sol";

contract TestHelper is Test {

    BondNFT internal bondNFT;
    GovNFT internal govNFT;
    Lock internal lock;

    StableToken internal stableToken;
    StableVault internal stableVault;

    MockUSDC internal mockUSDC;
    MockDAI internal mockDAI;

    address internal alice = 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063;
    address internal bob = 0xC8bdDa4d0d43088A15E028DFd1EcE655c308fd13;




    function _deployStables() internal {
        //standard erc20 mocks
        mockDAI = new MockDAI();
        mockUSDC = new MockUSDC();


        stableToken = new StableToken("Tigris USD", "tigUSD");
        stableVault = new StableVault(address(stableToken));

        stableVault.listToken(address(mockDAI));
        stableVault.listToken(address(mockUSDC));

        stableToken.setMinter(address(stableVault), true);
    }




    function _deployLock() internal {

        bondNFT = new BondNFT("","","");

        address endpoint;
        govNFT = new GovNFT(endpoint, "","","");

        lock = new Lock(address(bondNFT), address(govNFT));

        lock.editAsset(address(stableToken), true);

        bondNFT.setManager(address(lock));
        bondNFT.addAsset(address(stableToken));
        //deploy lock
        //deploy bond nft
        //deploy stabletoken
        //deploy gov nft
        
    }
    

    function _userDepositsToStableVault(address _user, address _token, uint256 _amount) internal {
        IMockERC20(_token).mint(_user, _amount);
        //user makes a deposit to stableVault
        vm.startPrank(_user);
        IMockERC20(_token).approve(address(stableVault), _amount);
        stableVault.deposit(_token, _amount);
        vm.stopPrank();
    }

    function _userDepositsToLock(address _user, uint256 _amount, uint256 _period) internal {
        vm.startPrank(_user);

        stableToken.approve(address(lock), _amount);
        lock.lock(address(stableToken), _amount, _period);

        vm.stopPrank();
    }
}
