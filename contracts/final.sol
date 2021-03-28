pragma solidity ^0.4.17;

struct CharityOrg{
  string OrgName;
  address OrgAddress;
  string Desc;
};

struct Beneficiary{
    string description;
    uint maxContr;
    address recipient;
    bool complete;
}

struct Payment{
   string description;
   unit amount;
   address receiver;
   bool completed;
   unit votercount;

};

struct Donator {

    string name;
    string message;
    unit16 projectID;
    uint value;
    unit account_balance;

};

struct CoopStore{
  string StoreName;
  address StoreAddress;
  unit account_balance;

};

string[] public CharityProjects;  //(should be a list of structs) Duplicate, needs to be merged with the Beneficiary Upload info struct
Donator[] public donators;  //stores data of all donators
Beneficiary[] public beneficiaries;
address public reciever;
uint public minContr;
CoopStore[] public CooperativeStores;
/* string[] public BeneficiaryInfo;  //(should be a list of structs) Duplicate, needs to be merged with the Beneficiary Upload info struct */


contract Genuine_Charity_DApp{

  //CHARITY ORG METHODS
  CharityOrg c;

  function Genuine_Charity_DApp() public { //constructor
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

    // DONATOR METHODS

    function make_donations(string _name ,string _message, unit16 _projectID, uint _value,uint _account_balance) public {
        //constructor
        Donator d;
        d.name = _name;
        d.message = _message;
        d.projectID = _projectID;
        d.value = _value;
        d.account_balance = _account_balance;
        d.Address = msg.sender;
      }

    function getProjects() public view returns (Beneficiary [])
    {
     return CharityProjects;
    }

    function selectCharityProject (unit16 id) public{
     donators[id].projectID = CharityProjects[id];
    }

    // BENEFICIARY METHODS
    /* modifier restrict({
        require(msg.sender == reciever);
        _;
    }) */


    function donate() public payable{
        require(msg.value > minContr);

    donators.push(msg.sender);

    }

    function createRequest(string description, uint maxContr, address recipient ) public restrict{
        Beneficiary newRequest = Request(description, maxContr, recipient, false);
        requests.push(newRequest);
    }

    function spend() public restrict{
        require(complete == true){
            stores[i].StoreWalletAddress.transfer(this.balance);
        }

    }

    // COOPERATIVE STORE METHODS
    /* CoopStore Cs; */
    /* modifier onlyBeneficiary() {
   require(msg.sender ==  Beneficiary, "Only Beneficiary!");
        _;
      } */

    function cooperative_store() public { //constructor
      CoopStore c;
      c = CoopStore("Genuine_Charity_Cooperative_Store",msg.sender,msg.sender.balance);
      CooperativeStores.push(c);
    }

    function receive_money(uint16 id) onlyBeneficiary public payable {
        require(msg.value >=0.0001 ether, "You must send at least 0.001 ETH");
        CooperativeStores[id].account_balance+=msg.value;
        //return products bought by beneficiary.
    }
    function update_account() public {
        return account_balance;
    }
  }
