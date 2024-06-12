// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {SimpleErc20TokenWithAirdrop} from "../src/SimpleErc20TokenWithAirdrop.sol";

contract SimpleErc20TokenWithAirdropTest is Test {
    SimpleErc20TokenWithAirdrop simpleErc20TokenWithAirdrop;

    string constant TOKEN_NAME = "BonesCoin";
    string constant TOKEN_SYMBOL = "$BONES";
    uint256 constant TOTAL_SUPPLY = 666666666;
    uint256 constant AIRDROP_AMOUNT_PER_RECIPIENT = 222222222;
    address remainingSupplyHolder = makeAddr("user1");
    address airdropRecipientOne = makeAddr("user2");
    address airdropRecipientTwo = makeAddr("user3");

    address[] airdropRecipients = [airdropRecipientOne, airdropRecipientTwo];

    uint256 remainingSupply = TOTAL_SUPPLY - (AIRDROP_AMOUNT_PER_RECIPIENT * airdropRecipients.length);

    function setUp() external {
        simpleErc20TokenWithAirdrop = new SimpleErc20TokenWithAirdrop(
            TOKEN_NAME, TOKEN_SYMBOL, TOTAL_SUPPLY, AIRDROP_AMOUNT_PER_RECIPIENT, remainingSupplyHolder, airdropRecipients
        );
    }

    function testTokenName() public view {
        string memory tokenName = simpleErc20TokenWithAirdrop.name();
        assertEq(tokenName, TOKEN_NAME);
    }

    function testTokenSymbol() public view {
        string memory tokenSymbol = simpleErc20TokenWithAirdrop.symbol();
        assertEq(tokenSymbol, TOKEN_SYMBOL);
    }

    function testTotalSupply() public view {
        assertEq(simpleErc20TokenWithAirdrop.totalSupply(), TOTAL_SUPPLY);
    }

    function testAirdroppedSupply() public view {
        assertEq(simpleErc20TokenWithAirdrop.balanceOf(airdropRecipientOne), AIRDROP_AMOUNT_PER_RECIPIENT);
        assertEq(simpleErc20TokenWithAirdrop.balanceOf(airdropRecipientTwo), AIRDROP_AMOUNT_PER_RECIPIENT);
    }

    function testBalanceOfRemainingSupplyHolder() public view {
        assertEq(simpleErc20TokenWithAirdrop.balanceOf(remainingSupplyHolder), remainingSupply);
    }

    function testOverMinting() public {
        address[] memory newAirdropRecipients = new address[](4);

        vm.expectRevert("You can't mint more than total supply.");
        simpleErc20TokenWithAirdrop = new SimpleErc20TokenWithAirdrop(
            TOKEN_NAME, TOKEN_SYMBOL, TOTAL_SUPPLY, AIRDROP_AMOUNT_PER_RECIPIENT, remainingSupplyHolder, newAirdropRecipients
        );
    }
}
