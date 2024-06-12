// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title Simple Token with Airdrop Functionality
 * @author Kristoffer Wallqvist
 * @notice Token, ERC20, Fixed Supply, Airdrop Functionality
 * @custom:default-precision 18
 * @custom:simple-description Simple Token with Airdrop Functionality. A fixed supply is minted on deployment, and
 * new tokens can never be created. Can airdrop to specified addresses on deploy.
 * @dev ERC20 token with the following features:
 *
 *  - Premint your total supply.
 *  - No minting function. This allows users to comfortably know the future supply of the token.
 *  - Airdrop on deploy. Choose which addresses to be airdropped and amount.
 *
 */

contract SimpleErc20TokenWithAirdrop is ERC20 {
    /**
     * @param name Token Name
     * @param symbol Token Symbol
     * @param totalSupply Token Supply
     * @param airdropAmountPerRecipient Number of tokens each address will receive
     * @param remainingSupplyHolder Holder of Tokens on Deploy
     * @param airdropRecipients Array of addresses to receive the airdrop
     */

    constructor(
        string memory name,
        string memory symbol,
        uint256 totalSupply,
        uint256 airdropAmountPerRecipient,
        address remainingSupplyHolder,
        address[] memory airdropRecipients
    ) payable ERC20(name, symbol) {

        require(airdropAmountPerRecipient * airdropRecipients.length <= totalSupply, "You can't mint more than total supply.");

        for (uint256 i = 0; i < airdropRecipients.length; i++) {
            _mint(airdropRecipients[i], airdropAmountPerRecipient);
        }

        uint256 remainingSupplyAfterAirdrop = totalSupply - (airdropAmountPerRecipient * airdropRecipients.length);

        _mint(remainingSupplyHolder, remainingSupplyAfterAirdrop);
    }
}

