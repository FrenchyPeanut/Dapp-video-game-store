pragma solidity ^0.4.23;

contract Product {

    address owner;
    bool online;

    constructor() public{
        owner = msg.sender;
    }
    
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

    event doStuff(
        uint price,
        string name,
        address seller
    );

    function newItem(string name, string description, uint price) public returns(uint) {
        require(online == true);
        require(price > 0, "Price must be greater than 0.");
        uint checkingLength = items.length;
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
        emit doStuff(price, name, msg.sender);
        assert(checkingLength + 1 == items.length);
        return items.length + 1;
    }

    function getItem(uint id) public view returns(
        uint, string, string, uint, bool, bool, bool
    ){
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

    function buyItem(uint id) public payable returns(bool){
        require(online == true);
        require(item[id].itemPrice == msg.value)
        item[id].buyer = msg.sender;
        item[id].sold = true;
        return true;
    }

    function receivedItem(uint id) public{
        require(item[id].sold == true);
        require(item[id].sent == true);
        require(item[id].buyer == msg.sender);
        item[id].received = true;
    }

    function sentItem(uint id) public{
        require(item[id].sold == true);
        item[id].sent = true;
    }
    
    function claimFunds(uint id) public{
        require(online == true);
        require(item[id].seller == msg.sender);
        require(item[id].received == true);
        msg.sender.transfer(item[id].itemPrice);
    }

    function kill() public{
        require(msg.sender == owner);
        selfdestruct(owner);
    }

    function switchStatus(bool status) public{
        require(msg.sender == owner);
        online = status;
    }

}