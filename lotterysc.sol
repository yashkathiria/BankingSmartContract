// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract lottery{
    address public manager;
    address payable[] public players;

    constructor(){
        manager = msg.sender;
    }

    function alreadyEntered()view private returns(bool){
        for(uint i; i < players.length; i++){
            if(players[i]==msg.sender)
                return true;
        }
        return false;
    }

    function enter() public payable {
        require(msg.sender != manager,"Manager can not participate in the Lottery");
        require(alreadyEntered() == false, "The player has already entered");
        require(msg.value >= 2 ether, "Minimum amount for entering lottery is 2 ether");
        players.push(payable(msg.sender));
    }

    function random()view private returns(uint){
        return uint(sha256(abi.encodePacked(block.difficulty,block.number,players)));
    }
    function pickwinner()public{
        require(msg.sender == manager,"Only manager can pick the winner");
        uint index = random()%players.length; //Winner's Index
        address contractAddress = address(this);
        players[index].transfer(contractAddress.balance);
        players = new address payable[](0);
    }

    function getplayers()view public returns(address payable[] memory){
        return players;
    }

    
}
