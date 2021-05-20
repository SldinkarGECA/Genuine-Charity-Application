pragma solidity ^0.4.17;

string[] public CharityProjects;  //(should be a list of structs) Duplicate, needs to be merged with the Beneficiary Upload info struct
/* string[] public BeneficiaryInfo;  //(should be a list of structs) Duplicate, needs to be merged with the Beneficiary Upload info struct */

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

  function Send_Money_Beneficiary(Payment p) public payable {
    if (msg.sender == c.OrgAddress)
    {
      // pay money to benficiary
      // Project goal to be implemented
      p.receiver.transfer(p.amount);
      p.completed = true;
    }
  }

  function Remove_Project(uint16 id) public{ //remove project after the required money is collected
    CharityProjects[id] = CharityProjects[CharityProjects.length - 1];
    delete CharityProjects[CharityProjects.length - 1];
    CharityProjects.length--;
    }


  }


}
