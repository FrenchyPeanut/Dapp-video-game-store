pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Product.sol";

contract TestProduct{

    uint public initialBalance = 6 ether;
    Product product;

    function beforeAll() public{
        product = Product(DeployedAddresses.Product());
    }

    function beforeEach() public{

    }

    function testAddingItem() public{
        uint numItems = product.newItem("Super Mario","New super mario game on NES", 1 ether);
        uint expectedResult = 1;
        Assert.equals(numItems == expectedResult, "Must contain only 1 item.");
    }

    function testGetItem() public{
        
    }

}