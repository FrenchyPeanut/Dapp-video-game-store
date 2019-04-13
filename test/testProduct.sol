pragma solidity 0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Product.sol";

contract TestProduct{


    uint public initialBalance = 2 ether;
    Product product;
    
    // 6 Ethereum should be enough for our testing . . .
    function beforeAll() public{
        product = Product(DeployedAddresses.Product());
    }

    function testAddingItem() public{
        uint numItems = product.newItem("Super Mario","New super mario game on NES.", 1 ether);
        uint expectedResult = 1;
        Assert.equal(numItems, expectedResult, "Must contain only 1 item.");
    }

    function testGetItem() public{
        uint expectedId = 1;
        uint expectedPrice = 1 ether;
        string memory expectedName = "Super Mario";
        string memory expectedDescription = "New super mario game on NES.";

        uint actualId;
        uint actualPrice;
        string memory actualName;
        string memory actualDescription;
        bool actualSold;
        bool actualReceived;
        bool actualSent;

        (actualId, actualName, actualDescription, actualPrice, actualSold, actualSent, actualReceived) = product.getItem(0);

        Assert.equal(actualId, expectedId, "The ID should be 1.");
        Assert.equal(actualPrice, expectedPrice, "The Price should be 1 Ethereum.");
        Assert.equal(actualName, expectedName, "The Name should be Super Mario.");
        Assert.equal(actualDescription, expectedDescription, "The Description should be identical.");

        Assert.isFalse(actualSold,"The Game should not be sold.");
        Assert.isFalse(actualSent,"The Game should not be sent.");
        Assert.isFalse(actualReceived,"The Game should not be received.");
    
    }

    function testBuyItem() public{
        bool tmp = product.buyItem.value(1 ether)(0);
        Assert.isTrue(tmp, "The game should be bought successfully.");
    }

}