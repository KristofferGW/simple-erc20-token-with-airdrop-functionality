// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {SimpleErc20TokenWithAirdrop} from "../src/SimpleErc20TokenWithAirdrop.sol";
import {DeploySimpleErc20TokenWithAirdrop} from "../script/DeploySimpleErc20TokenWithAirdrop.s.sol";

contract SimpleErc20TokenWithAirdropTest is Test {
    SimpleErc20TokenWithAirdrop simpleErc20TokenWithAirdrop;

    function setUp() external {
        DeploySimpleErc20TokenWithAirdrop deploySimpleErc20TokenWithAirdrop = new DeploySimpleErc20TokenWithAirdrop();
        simpleErc20TokenWithAirdrop = deploySimpleErc20TokenWithAirdrop.run();
    }

    function testTokenName() public view {
        assertEq(simpleErc20TokenWithAirdrop.name(), "BonesCoin");
    }

    function testTokenSymbol() public view {
        assertEq(simpleErc20TokenWithAirdrop.symbol(), "$BONES");
    }

    function testTotalSupply() public view {
        assertEq(simpleErc20TokenWithAirdrop.totalSupply(), 666666666);
    }

    function testInitialSupplyHolder() public view {
        assertEq(simpleErc20TokenWithAirdrop.balanceOf(0x70997970C51812dc3A010C7d01b50e0d17dc79C8), 666666666);
    }
}
