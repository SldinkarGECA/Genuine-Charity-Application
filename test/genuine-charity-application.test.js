const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const provider = ganache.provider();
const web3 = new Web3(provider);
const {interface,bytecode} = require("../compile");

let accounts;
let contract;

beforeEach(async() => {
  // this.timeout(3000); // A very long environment setup.
  //  setTimeout(done, 2500);
  // get all accounts
  accounts = await web3.eth.getAccounts();

  // deplaoy the contract using one accounts
  contract = await new web3.eth.Contract(JSON.parse(interface))
  .deploy({ data: bytecode })
  .send({ from:accounts[0], gas:5000000 });

});

describe("genuine-charity-application Charity Org",() => {
  it("deploys a contract",() => {

    assert.ok(contract);
  });

  it("charity org object",async () => {

    const obj = await contract.methods.c().call();
    console.log(obj);
    assert.ok(obj);
  });

  it("coop store object",async () => {

    const obj = await contract.methods.CooperativeStores(0).call();
    console.log(obj);
    assert.ok(obj);
  });

  it("allows manager to make a payment request",async () => {

   await contract.methods
     .createRequest('Laptop', '500', accounts[2])
     .send({
        from:accounts[2],
        gas: '1000000'
       });
   const beneficiary = await contract.methods.beneficiaries(0).call();
   assert.strictEqual('Laptop', beneficiary.description);

  });

  it("post project",async () => {

    const hash = await contract.methods.Post_Project(0)
    .send({
      from:accounts[0],
      gas: '1000000'
    }); // instead of 0 we pass project id
    // assert.ok(hash);

   });


   it("create donators",async () => {
     const hash1 = await contract.methods.create_donator('charity1','xyz').send({ from:accounts[1],gas:'2000000' });
     assert.ok(hash1);

   });
   it("make_donations",async () => {
     const hash2 = await contract.methods.make_donations(0).send({ from:accounts[1],gas:'2000000' }); // instead of 0 we pass project id
     assert.ok(hash2);

    });

    it("selectCharityProject",async () => {

     const hash = await contract.methods.selectCharityProject(0,0,20).send({ from:accounts[0] }); // instead of 0 we pass project id
     assert.ok(hash);

    });
    // it("approve donate request",async () => {
    //
    // await contract.methods.donateVote().send({
    //   value: '200',
    //   from: accounts[0]
    // })
    // const hash = await contract.methods.donateVote().approvers(accounts[0]).call();
    // assert(hash);
    //
    // });

    it("minimum contribution",async () => {

    try {
      await contract.methods.donateVote().send({
        value: '0.1',
        from: accounts[0]
      });
      assert(false);
    } catch (err){
      assert(err);
    }

    });

    it('Processes requests', async () => {
      await contract.methods.donateVote().send({
        from: accounts[0],
        value: 500
      });

      await contract.method.createRequest('Laptop', 500 , accounts[1]).send({ from: accounts[0], gas: '1000000' });

      await contract.methods.approveRequest(0).send({ from: accounts[0], gas: '1000000' });

      await contract.methods.transferToStore(0).send({ from: accounts[0], gas: '1000000' });

      await contract.methods.RequestMoneyAfterCompletion(0).send({ from: accounts[0], gas: '1000000' });

      let balance = await web3.eth.getBalance(accounts[1]);
      balance = web3.utils.fromWei(balance, 'ether');
      balance = parseFloat(balance);

      assert(balance > 100);


    });
    it("send money to beneficiary",async () => {

      const hash = await contract.methods.Send_Money_Beneficiary(0).send({ from:accounts[0] }); // instead of 0 we pass payment id
      assert.ok(hash);

     });

   it("remove project",async () => {

     const hash = await contract.methods.Remove_Project(0).send({ from:accounts[0] }); // instead of 0 we pass project id
     assert.ok(hash);

    });

     it("addProduct",async () => {

      const hash = await contract.methods
        .addProduct('C', 'Laptop', '500')
        .send({
           from:accounts[0],
           gas: '1000000'
          });
      assert(hash);
     });

});
