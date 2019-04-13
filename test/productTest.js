let Product = artifacts.require("./Product.sol");

contract('Product', async(accounts) => {
    let product;
    let seller = accounts[0];
    let buyer = accounts[1];

    before(async() => {
        product = await Product.deployed();
        await product.newItem(
            "MegaMan", 
            "Made by Capcom", 
            web3.utils.toWei('2', 'ether'), 
            {from: seller}
        );
    });


    it("Should have the Game item in the store", async() => {
        let item = await product.getItem(0);
        assert.equal(item[0].toNumber(), 1, "The item should have ID number 1.");
        assert.equal(item[1], "MegaMan", "The item should have the correct name.");
        assert.equal(item[2], "Made by Capcom", "The item should have the correct description.");
        // item[3].toNumber() now throws an error due to precision errors.
        assert.equal(web3.fromWei(item[3].toString(),'ether'), 1, "The item should have the correct price.");
        assert.isFalse(item[4], "The item should not be sold.");
        assert.isFalse(item[5], "The item should not be sent.");
        assert.isFalse(item[6], "The item should not be received.");
    });

    it("Should fail if not bought", async() => {
        try{
            let sentItem = await product.sentItem(0, {
                from: seller
            });
            // If the test actually works, we throw an error . . .
            assert.fail();
        }catch(e){
            assert.match(e.toString(), /revert/, "Transaction should have reverted.");
        }
    });

    it("Should be able to buy a Game item", async() => {
        console.log("Starting test: BUYING GAME");
        // buyerInitialBalance = web3.fromWei(web3.eth.getBalance(buyer).toNumber(),'ether');
        const buyerInitialBalanceInWei = await web3.eth.getBalance(buyer)
        buyerInitialBalance = web3.utils.fromWei(buyerInitialBalanceInWei, 'ether')
        console.log("Buyer funds available:" + buyerInitialBalance);
        let buyItem = await product.buyItem(0,{
            from: buyer,
            value: web3.toWei(1,'ether')
        });
        console.log("item to buy: " + buyItem);

        buyerAfterBalance = web3.fromWei(web3.getBalance(buyer).toNumber(),'ether');
        let itemBought = await product.getItem(0);
        assert.isTrue(itemBought[4],"The Game should be marked as bought.");
        // isAbove due to the txFees . . .
        assert.isAbove(buyerInitialBalance - buyerAfterBalance, 1, "Should have paid 1 ether.");

    });

});



