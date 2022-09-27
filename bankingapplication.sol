// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract BankingApplication{
    mapping(address=>uint) public userAccount;
    mapping(address=>bool) public exUser;

    //To create new account
    function newAccount() public payable returns(string memory){
      require(exUser[msg.sender]==false,'Account Already Created');
      if(msg.value==0){
          userAccount[msg.sender]=0;
          exUser[msg.sender]=true;
          return "Account Created Successfully";
      }
      require(exUser[msg.sender]==false,'account already created');
      userAccount[msg.sender] = msg.value;
      exUser[msg.sender] = true;
      return "Account Created Successfully";
  }

    //Deposit the money
    function deposit()public payable returns(string memory){
        require(exUser[msg.sender]==true,"Account is not created");
        require(msg.value>0,"Value for deposit is Zero");
        userAccount[msg.sender]=userAccount[msg.sender]+msg.value;
        return "Deposited Successfully";
    }

    //Transfer
    function transfer(address payable userAddress, uint256 amount)public returns(string memory){
        require(userAccount[msg.sender]>amount,"Your account Don't have enaugh balance");
        require(exUser[msg.sender]==true,"Account is not there");
        require(exUser[userAddress]==true,"Transfer account is not there");
        require(amount>0,"Enter non-zero value for withdrawal");
        userAccount[msg.sender]=userAccount[msg.sender]-amount;
        userAccount[userAddress]=userAccount[userAddress]+amount;
        userAddress.transfer(amount);
        return "Money transferred successfully";
    }

    //Withdraw the money
    function withdraw(uint amount) public payable returns(string memory){
        require(userAccount[msg.sender]>amount,"Your account Don't have enaugh balance");
        require(exUser[msg.sender]==true,"Account has not created");
        require(amount>0,"Enter some amount accept zero");
        userAccount[msg.sender]=userAccount[msg.sender]-amount;
        payable(msg.sender).transfer(amount);

        return "Withdrawal Successfull";
    }

}
