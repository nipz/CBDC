// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "@openzepplin/contracts/token/ERC20/ERC20.sol";

contract CDBC is ERC20 {
    address public controllingParty;
    uint public interestRatesBasisPoints = 500;
    mapping(address => bool) public blacklist;
    mapping(adress => uint) private stakeTreasuryBond;
    mapping(address =>uint) private stakedFromTs;
    event UpdateControllingParty(address oldControllingParty, address newControllingParty);
    event UpdateInterestRate(uint oldInterest, uint newInterestRate);
    event IncreaseMoneySupply(uint oldMoneySupply, uint inflationAmount);
    event UpdateBlacklist(address criminal, bool blocked);
    event StakeTreasuryBond(address user, uint amount);
    event UnstakeTreasuryBonds(address user, uint amount);
    event ClaimTreasuryBonds(address user, uint amount);

    constructor(address _controllingParty, uint initialSupply)
    ERC20("CENTRAL BANK DIGITAL CURRENCY", "CBDC") {
        controllingparty = _controllingParty;
        _mint(controllingParty, initialSupply); 
    }

    function updateControllingParty(address newControllingParty) external {
        require(msg.sender == controllingParty," not controlling party");
        controllingParty = newControllingParty;
        _transfer(controllingParty, newControllingParty, balanceOf(contorllingParty));
    }

    

}