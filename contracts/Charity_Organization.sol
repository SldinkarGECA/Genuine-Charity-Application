pragma solidity ^0.4.17;

string[] public CharityProjects;  //(should be a list of structs) Duplicate, needs to be merged with the Beneficiary Upload info struct
string[] public BeneficiaryInfo;  //(should be a list of structs) Duplicate, needs to be merged with the Beneficiary Upload info struct

struct CharityOrg{
  string OrgName;
  address OrgAddress;
  string Desc;
};

contract Charity_Organzation{

  CharityOrg c;

  function Charity_Organization() public { //constructor
      c = CharityOrg("Genuine_Charity_Team",msg.sender,"Team of Genuine Charity App");
    }

  function Post_Project(uint16 id) public {
    CharityProjects.push(BeneficiaryInfo[id]);
  }

  function Remove_Project(uint16 id) public{
    CharityProjects[id] = CharityProjects[CharityProjects.length - 1];
    delete CharityProjects[CharityProjects.length - 1];
    CharityProjects.length--;
    }
  }


}
