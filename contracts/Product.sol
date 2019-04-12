pragma solidity ^0.4.23;

contract Product {
    
    struct Item  {
        address buyer;
        address seller;
        uint id;
        string name;
        string description;
        uint price;
        bool sold;
        bool sent;
        bool received;
    }

    Item[] public items;

    function doStuff(string name, string description, uint price) public returns(uint) {
        
    }

 

}