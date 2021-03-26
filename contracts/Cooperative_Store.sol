pragma solidity ^0.4.17;


struct CoopStore{
  string StoreName;
  address StoreAddress;
  unit account_balance;
  
};

contract cooperative_store{
    CoopStore Cs;
    modifier onlyBeneficiary() {
   require(msg.sender ==  Beneficiary, "Only Beneficiary!");
        _;
}


    function cooperative_store() public { //constructor
      c = CharityOrg("Genuine_Charity_Cooperative_Store",msg.sender);
    }

    function receive_money() onlyBeneficiary public payable {
        require(msg.value >=0.0001 ether, "You must send at least 0.001 ETH");
        account_balance+=msg.value;
        //return products bought by beneficiary.
    }
    function update_account() public {
        return account_balance;
    }
}