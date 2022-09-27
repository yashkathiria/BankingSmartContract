// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EventContract{
    struct Event{
        address organizer;
        string name;
        uint date;
        uint price;
        uint ticketCount;
        uint ticketRemain;
    }

mapping(uint=>Event) public events;
mapping(address=>mapping(uint=>uint))public tickets;
uint public nextId;

function creatEvent(string memory name, uint date, uint prise, uint ticketCount) external{
    require(date>block.timestamp,"You can organize event for future date");
    require(ticketCount>0,"You can organize event only if you create more than 0 tickets");
    events[nextId] = Event(msg.sender,name,date,prise,ticketCount,ticketCount);
    nextId++;
}
function buyTicket(uint id,uint quantity) external payable{
    require(events[id].date!=0,"Event does not exist");
    require(events[id].date>block.timestamp,"Event has already occured");
    Event storage _event = events[id];
    require(msg.value==(_event.price*quantity),"Eather is not enough");
    require(_event.ticketRemain>=quantity,"Not enough tickets");
    _event.ticketRemain-=quantity;
    tickets[msg.sender][id]+=quantity;
}
function transferTickets(uint id, uint quantity, address to)external{
    require(events[id].date!=0,"Event does not exist");
    require(events[id].date>block.timestamp,"Event has already occured");
    require(tickets[msg.sender][id]>=quantity,"you do not have enought tickets");
    tickets[msg.sender][id]-=quantity;
    tickets[to][id]+=quantity;
}
}
