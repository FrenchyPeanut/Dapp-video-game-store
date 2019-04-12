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
            web3.toWei(2, 'ether'), 
            {from: seller}
        );
    });
});

it("Should have the Game item in the store", async() => {
    let item = await product.getItem(0);
    assert.equal(item[0].toNumber(), 1, "The item should have ID number 1.");
    assert.equal(item[1], "MegaMan", "The item should have the correct name.");
    assert.equal(item[2], "Made by Capcom", "The item should have the correct description.");
    // item[3].toNumber() now throws an error due to precision errors.
    assert.equal(web3.fromWei(item[3].toString(),'ether'), 1, "The item should have ID number 1.");
    assert.equal(item[4].toNumber(), 1, "The item should have ID number 1.");
    assert.equal(item[5].toNumber(), 1, "The item should have ID number 1.");
    assert.equal(item[6].toNumber(), 1, "The item should have ID number 1.");
});

item[id].id,
item[id].itemName,
item[id].itemDescription,
item[id].itemPrice,
item[id].sold,
item[id].sent,
item[id].received