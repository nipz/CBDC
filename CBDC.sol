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
        require(msg.sender == controllingParty, "Not Nontrolling Party");
        controllingParty = newControllingParty;
        _transfer(controllingParty, newControllingParty, balanceOf(contorllingParty));
        emit UpdateControllingParty(msg.sender, newControllingParty);
    }


    function updateInterestRate(uint newInterestRateBasisPoints) external {
        require(msg.sender == controllingParty, "Not Conrolling Party");
        uint oldInterestRatesBasisPoint = interestRateBasisPoints;
        interestRateBasisPoints = newInteresetBasisPoints;
        emit UpdateInterestRate(oldInterestRateBasisPoint, newInterestRateBasisPoints);
    }

    function increaseMoneySupply(uint, inflationAmount) external {
        require(msg.sender == controllingParty, "Not Controlling Party");
        uint oldMoneySupply = totalSupply();
        _mint(msg.sender, inflationAmount);
        emit increaseMoneySupply(oldMoneySupply, inflationAmount);

    }

    function updateBlacklist(address Criminal, bool blacklisted) external {
        require(msg.sender == controllingParty, "Not Conrolling Party");
        blacklist[criminal = blacklisted];
        emit UpdateBlacklist(criminal, blacklisted);
    }

    function stakeTreasuryBonds(uint amount) external {
        require( amount > 0, "amount is <=0");
        require(balanceOf(msg.sender)>= amount, "balance is amount");
        _transfer(msg.sender,address(this), amount);
        if(stakeTreasuryBond[msg.sender]>0) ClaimTreasuryBonds();
        stakedFromTS[msg.sender] = blcok.timestamp;
        stakedTreasuryBond[msg.sender] += amount;
        emit StakeTreasuryBonds(msg.sender, amount);
    }

    function UnstakeTreasuryBonds(uint amount) external {
        require(amount > 0, "amount is = 0")
        require(stakedTreasuryBond[msg.sender] >= amount , "amount is > staked");
        claimTreasuryBonds();
        stakeTreasuryBond[msg.sender] -= amount;
        _transfer(address(this), msg.sender, amount);
        emit UnstakeTreasuryBonds(msg.sender, amount);
    }

    function ClaimTreasuryBonds() public {
        require(stakedTreasuryBond[msg.sender] >= amount, "staked is <= 0");
        uint secondsStaked = block.timestamp - stakedFromTS[msg.sender];
        uint rewards = stakedTreasuryBond[msg.sender] * secondedStaked * interestRateBasisPoints / (10000 * 3.154e7);
        stakedFromTS[msg.sender] = block.timestamp;
        _mint(msg.sender, rewards);
        emit ClaimTreasuryBonds(msg.sender, rewards);

    }

    function _transfer(address from, address to, uint amount) internal virtual override {
        require(blacklist[from] == false, "sender address is blacklisted");
        require(blacklist[to] == false, "sender address is blacklisted");
        super._transfer(from, to , amount); 
    }

}