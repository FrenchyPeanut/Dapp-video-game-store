pragma solidity ^0.4.23;

contract Product {
    
    struct Item  {
        address buyer;
        address seller;
        uint id;
        string itemName;
        string itemDescription;
        uint itemPrice;
        bool sold;
        bool sent;
        bool received;
    }

    Item[] public items;

    function newItem(string name, string description, uint price) public returns(uint) {
        items.push(
            Item({
                buyer: address(0),
                seller: msg.sender,
                id: items.length + 1,
                itemName: name,
                itemDescription: description,
                itemPrice: price,
                sold: false,
                sent: false,
                received: false           
            })
        );
        return items.length + 1;
    }

    function getItem(uint id) public view returns(){
        return( 
            item[id].id,
            item[id].itemName,
            item[id].itemDescription,
            item[id].itemPrice,
            item[id].sold,
            item[id].sent,
            item[id].received
            );
    }

 

}