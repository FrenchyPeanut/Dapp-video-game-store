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