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
    address REMAINING_SUPPLY_HOLDER = makeAddr("user1");
    address AIRDROP_RECIPIENT_1 = makeAddr("user2");
    address AIRDROP_RECIPIENT_2 = makeAddr("user3");

    address[] airdropRecipients = [AIRDROP_RECIPIENT_1, AIRDROP_RECIPIENT_2];

    uint256 remainingSupply = TOTAL_SUPPLY - (AIRDROP_AMOUNT_PER_RECIPIENT * airdropRecipients.length);

    function setUp() external {
        simpleErc20TokenWithAirdrop = new SimpleErc20TokenWithAirdrop(
            TOKEN_NAME, TOKEN_SYMBOL, TOTAL_SUPPLY, AIRDROP_AMOUNT_PER_RECIPIENT, REMAINING_SUPPLY_HOLDER, airdropRecipients
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
        assertEq(simpleErc20TokenWithAirdrop.balanceOf(AIRDROP_RECIPIENT_1), AIRDROP_AMOUNT_PER_RECIPIENT);
        assertEq(simpleErc20TokenWithAirdrop.balanceOf(AIRDROP_RECIPIENT_2), AIRDROP_AMOUNT_PER_RECIPIENT);
    }

    function testBalanceOfRemainingSupplyHolder() public view {
        assertEq(simpleErc20TokenWithAirdrop.balanceOf(REMAINING_SUPPLY_HOLDER), remainingSupply);
    }

    function testOverMinting() public {
        address[] memory newAirdropRecipients = new address[](4);

        vm.expectRevert("You can't mint more than total supply.");
        simpleErc20TokenWithAirdrop = new SimpleErc20TokenWithAirdrop(
            TOKEN_NAME, TOKEN_SYMBOL, TOTAL_SUPPLY, AIRDROP_AMOUNT_PER_RECIPIENT, REMAINING_SUPPLY_HOLDER, newAirdropRecipients
        );
    }
}
