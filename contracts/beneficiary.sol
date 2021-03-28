pragma solidity ^0.4.17;



contract Recieve{

    struct Beneficiary{
        string description;
        uint maxContr;
        address recipient;
        bool complete;
    }

    Beneficiary[] public beneficiaries;
    address public reciever;
    uint public minContr;
    address[] public donators;

    modifier restrict({
        require(msg.sender == reciever);
        _;
    })


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

}
