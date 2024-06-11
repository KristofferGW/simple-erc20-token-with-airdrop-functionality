// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {SimpleErc20TokenWithAirdrop} from "../src/SimpleErc20TokenWithAirdrop.sol";

contract DeploySimpleErc20TokenWithAirdrop is Script {
    function run() external returns (SimpleErc20TokenWithAirdrop) {
        string memory tokenName = "BonesCoin";
        string memory tokenSymbol = "$BONES";
        uint256 totalSupply = 666666666;
        address initialSupplyHolder = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;

        vm.startBroadcast();
        SimpleErc20TokenWithAirdrop simpleErc20TokenWithAirdrop = new SimpleErc20TokenWithAirdrop(tokenName, tokenSymbol, totalSupply, initialSupplyHolder);
        vm.stopBroadcast();
        return simpleErc20TokenWithAirdrop;
    }
}
