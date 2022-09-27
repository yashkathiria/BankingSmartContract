// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MarketPlace{

    struct Product{
        string name;
        uint price;
        address seller;
    }

    uint public productId = 0;

    mapping(uint => Product) public products;
    mapping(uint=>bool)public sold;

    function registerproduct(string memory _name, uint _price)external payable returns(bool){
        require(_price == msg.value,"The user must send the ethers written in the price");
        Product memory product;
        product.name = _name;
        product.price = _price;
        product.seller = msg.sender;
        products[productId] = product;
        productId++;
        return true;
    }
    function buyproduct(uint _productId) external payable returns(bool){
        require(msg.value==products[_productId].price,"The buy price must be same as the selling");
        payable(products[_productId].seller).transfer(products[_productId].price*2);
        return true;
    }

}
