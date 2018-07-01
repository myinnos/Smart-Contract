// MyInnosCoins ICO

// version of compiler
pragma solidity ^0.4.11;

contract myinnoscoin_icon {
    // Introducing the maximum number of MyInnosCoins available for sale
    uint public max_myinnoscoins = 100000;
    
    // Introducing the USD to MyInnosCoins conversion rate 
    uint public usd_to_myinnoscoins = 1000;
    
    // Introducing the total number of MyInnosCoins that have been bought by the investers
    uint public total_myinnoscoins_bought = 0;
        
    // Mapping from the invester address to its equity in MyInnosCoinsand USD
    mapping(address => uint) equity_myinnoscoins;
    mapping(address => uint) equity_usd;
    
    // Checking if an invester can buy MyInnosCoins
    modifier can_buy_myinnoscoins(uint usd_invested) {
        require (usd_invested * usd_to_myinnoscoins + total_myinnoscoins_bought <= max_myinnoscoins);
        _;
    }
    
    // Getting the equity in MyInnosCoins of an invester
    function equity_in_myinnoscoins(address invester) external constant returns (uint) {
        return equity_myinnoscoins[invester];
    }

    // Getting the equity in USD of an invester
    function equity_in_usd(address invester) external constant returns (uint) {
        return equity_usd[invester];
    }
    
    // Buying MyInnosCoins
    function buy_myinnoscoins(address invester, uint usd_invested) external 
    can_buy_myinnoscoins(usd_invested) {
        uint myinnoscoins_bought = usd_invested * usd_to_myinnoscoins;
        equity_myinnoscoins[invester] += myinnoscoins_bought;
        equity_usd[invester] = equity_myinnoscoins[invester] / 1000;
        total_myinnoscoins_bought += myinnoscoins_bought;
    }
    
    // Selling MyInnosCoins
    function sell_myinnoscoins(address invester, uint myinnoscoins_sold) external {
        equity_myinnoscoins[invester] -= myinnoscoins_sold;
        equity_usd[invester] = equity_myinnoscoins[invester] / 1000;
        total_myinnoscoins_bought -= myinnoscoins_sold;
    }

}