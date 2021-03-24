pragma solidity ^0.4.17;

    struct Donator {

        string name;
        string message;
        unit16 projectID;
        uint value;
        unit account_balance;

    }

    Donator[] public donators;  //stores data of all donators

    contract make_donations{

         Donator d;
         function getProjects() public view returns (Beneficiary [])
       {
          return CharityProjects;
       }

       function selectCharityProject (unit16 id) public{
          donators[id].projectID = CharityProjects[id];
       }






    }
