pragma solidity ^0.4.17;


contract Genuine_Charity_DApp{
  struct CharityOrg{
  string OrgName;
  address OrgAddress;
  string Desc;
}

struct Payment{
   string description;
   uint amount;
   address receiver;
   bool completed;
   uint votercount;

}

struct product{
    string productId;
    string productName;
    uint price;
    address seller;
    bool ongoing;

       }

struct Beneficiary{
    string description;
    uint maxContr;
    address store;
    bool complete;
    uint approvalCount;
    mapping(address => bool) approvals;

}

struct Donator {

    string name;
    string message;
    uint16 projectID;
    uint value;
    uint account_balance;
    address Address;

}

struct CoopStore{
  string StoreName;
  address StoreAddress;
  uint account_balance;

}

Beneficiary[] public CharityProjects;  //(should be a list of structs) Duplicate, needs to be merged with the Beneficiary Upload info struct
Donator[] public donators;  //stores data of all donators
Beneficiary[] public beneficiaries;
address public reciever;
uint public minContr;
CoopStore[] public CooperativeStores;
/* string[] public BeneficiaryInfo;  //(should be a list of structs) Duplicate, needs to be merged with the Beneficiary Upload info struct */

mapping(address => bool) approvers;
uint public approversCount;
mapping (string => product) products;
product[] public allProducts;
Payment[] public payments;

  //CHARITY ORG METHODS
  CharityOrg public c;

  function Genuine_Charity_DApp() public { //constructor
      c = CharityOrg("Genuine_Charity_Team",msg.sender,"Team of Genuine Charity App");
    }

  function Post_Project(uint16 id) public {
    CharityProjects.push(beneficiaries[id]);
  }

  function Send_Money_Beneficiary(uint id) public payable {
    if (msg.sender == c.OrgAddress)
    {
      // pay money to benficiary
      // Project goal to be implemented
      payments[id].receiver.transfer(payments[id].amount);
      payments[id].completed = true;
    }
  }

  function Remove_Project(uint16 id) public{ //remove project after the required money is collected
    CharityProjects[id] = CharityProjects[CharityProjects.length - 1];
    delete CharityProjects[CharityProjects.length - 1];
    CharityProjects.length--;
    }

    // DONATOR METHODS

    function make_donations(string _name ,string _message, uint16 _projectID, uint _value,uint _account_balance,address Address) public {
        //constructor
        Donator memory d = Donator({ name:_name, message:_message, projectID:_projectID, value:_value, account_balance:_account_balance, Address:Address });
        donators.push(d);
    }



    function selectCharityProject (uint16 id) public{
     donators[id].projectID = id;
    }

    // BENEFICIARY METHODS
    /* modifier restrict({
        require(msg.sender == reciever);
        _;
    }) */
    function donate() public payable{
        require(msg.value > minContr);

    approvers[msg.sender] = true;
    approversCount++;

    }

    function createRequest(string description, uint maxContr, address store) public {
        Beneficiary memory newRequest = Beneficiary({
            description: description,
            maxContr: maxContr,
            store: store,
            complete: false,
            approvalCount: 0
            });

        beneficiaries.push(newRequest);
    }


    function approveRequest(uint index) public{
        Beneficiary storage request = beneficiaries[index];

        require(approvers[msg.sender]);
        require(!request.approvals[msg.sender]);

        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }

    function transfer(uint index) public  {
        Beneficiary storage request = beneficiaries[index];
        require(request.approvalCount > approversCount/2);

        request.store.transfer(request.maxContr);
        request.complete = true;
    }

    function addProduct(string memory _productId, string memory _productName, uint _price) public {
       require(!products[_productId].ongoing);


        product memory product1 = product(_productId, _productName,_price, msg.sender, true);
        products[_productId].productId= _productId;
        products[_productId].productName= _productName;
        products[_productId].price= _price;
        products[_productId].seller= msg.sender;
        products[_productId].ongoing = true;
        allProducts.push(product1);
      }






    // COOPERATIVE STORE METHODS
    /* CoopStore Cs; */
    /* modifier onlyBeneficiary() {
   require(msg.sender ==  Beneficiary, "Only Beneficiary!");
        _;
      } */

    function cooperative_store(address Address) public { //constructor
      CoopStore memory co = CoopStore("Genuine_Charity_Cooperative_Store",Address,Address.balance);
      CooperativeStores.push(co);
    }

    function receive_money(uint16 id) public payable {
        require(msg.value >=0.0001 ether);
        CooperativeStores[id].account_balance+=msg.value;
        //return products bought by beneficiary.
    }
    // function update_account() public {
    //     return account_balance;
    // }
  }
