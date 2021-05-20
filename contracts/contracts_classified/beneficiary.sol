pragma solidity ^0.4.17;



contract Recieve{

    struct Beneficiary{
        string description;
        uint maxContr;
        address store;
        bool complete;
        uint approvalCount;
        mapping(address => bool) approvals;
    }

    Beneficiary[] public beneficiaries;
    address public reciever;
    uint public minContr;
    mapping(address => bool) approvers;
    uint public approversCount;

    modifier restrict({
        require(msg.sender == reciever);
        _;
    })


    function donate() public payable{
        require(msg.value > minContr);

    approvers[msg.sender] = true;
    approversCount++;

    }

    function createRequest(string description, uint maxContr, address recipient ) public restrict{
        Beneficiary newRequest = Beneficiary({
            description: description,
            maxContr: maxContr,
            recipient: recipient,
            complete: false,
            approvalCount: 0
            });

        beneficiaries.push(newRequest);
    }


    function approveRequest(uint index) public{
        Beneficiary request = beneficiaries[index];

        require(approvers[msg.sender]);
        require(!request.approvals[msg.sender]);

        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }

    function transfer(uint index) public restricted{
        Beneficiary request = beneficiaries[index];
        require(request.approvalCount > approversCount/2);

        request.store.transfer(request.value);
        request.complete = true;
    }

    struct product{
        string productId;
        string productName;
        uint price;
        address payable seller;
        bool ongoing;

           }

        mapping (string => product) products;
        product[] public allProducts;

      function addProduct(string memory _productId, string memory _productName, uint _price) public {
         require(!products[_productId].ongoing);


          product memory product = product(_productId, _productName,_price, msg.sender, true);
          products[_productId].productId= _productId;
          products[_productId].productName= _productName;
          products[_productId].price= _price;
          products[_productId].seller= msg.sender;
          products[_productId].ongoing = true;
          allProducts.push(product);



  }
}
