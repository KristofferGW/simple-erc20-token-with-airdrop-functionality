// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {FixedTokenWithAirdropFunctionality} from "../src/SimpleErc20TokenWithAirdrop.sol";

contract FixedTokenWithAirdropFunctionalityScript is Script {
    function run() external returns (FixedTokenWithAirdropFunctionality) {
        string memory tokenName = "BonesCoin";
        string memory tokenSymbol = "$BONES";
        uint256 totalSupply = 666666666;
        address initialSupplyHolder = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;

        vm.startBroadcast();
        FixedTokenWithAirdropFunctionality fixedTokenWithAirdropFunctionality = new FixedTokenWithAirdropFunctionality(tokenName, tokenSymbol, totalSupply, initialSupplyHolder);
        vm.stopBroadcast();
        return fixedTokenWithAirdropFunctionality;
    }
}
