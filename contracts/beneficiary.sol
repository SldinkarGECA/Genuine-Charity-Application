pragma solidity ^0.4.17;

    struct Donator {

        string name;
        string message;
        unit16 projectID;
        uint value;
        unit account_balance;

    }

    BeneficiaryInfo[] public beneficiaries;
    Donator[] public donators;  //stores data of all donators

    contract receive_tokens{

         Donator d;
         function getProjects() public view returns (string [])
       {
          return CharityProjects;
       }

       function selectCharityProject (unit16 id) public{
          Donator[projectID]= CharityProjects[id]
       }






    }