pragma solidity 0.5.0;

contract Product {

    address owner;
    bool online;

    constructor() public{
        owner = msg.sender;
        online = true;
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

    function newItem(string memory name, string memory description, uint price) public returns(uint) {
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
        return items.length;
    }

    function getItem(uint id) public view returns(
        uint, string memory, string memory, uint, bool, bool, bool
    ){
        return( 
            items[id].id,
            items[id].itemName,
            items[id].itemDescription,
            items[id].itemPrice,
            items[id].sold,
            items[id].sent,
            items[id].received
        );
    }

    function buyItem(uint id) public payable returns(bool){
        require(online == true);
        require(items[id].itemPrice == msg.value);
        require(items[id].sold != true);
        items[id].buyer = msg.sender;
        items[id].sold = true;
        return true;
    }

    function receivedItem(uint id) public{
        require(items[id].sold == true);
        require(items[id].sent == true);
        require(items[id].buyer == msg.sender);
        items[id].received = true;
    }

    function sentItem(uint id) public{
        require(items[id].sold == true);
        items[id].sent = true;
    }
    
    function claimFunds(uint id) public{
        require(online == true);
        require(items[id].seller == msg.sender);
        require(items[id].received == true);
        msg.sender.transfer(items[id].itemPrice);
    }

    function kill() public{
        require(msg.sender == owner);
        selfdestruct(msg.sender);
    }

    function switchStatus(bool status) public{
        require(msg.sender == owner);
        online = status;
    }

}