pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Product.sol";

contract TestProduct{

    uint public initialBalance = 5 ether;
    Product product;

    function beforeAll() public{
        product = Product(DeployedAddresses().Product);
    }

    function beforeEach() public{
        
    }
}