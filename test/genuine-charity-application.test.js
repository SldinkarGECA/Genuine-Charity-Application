const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());
const {interface,bytecode} = require("../compile");

let accounts;
let contract;

beforeEach(async() => {
  // get all accounts
  accounts = await web3.eth.getAccounts();

  // deplaoy the contract using one accounts
  contract = await new web3.eth.Contract(JSON.parse(interface))
  .deploy({ data: bytecode })
  .send({ from:accounts[0], gas:5000000 })
})

describe("genuine-charity-application Charity Org",() => {
  it("deploys a contract",() => {
    // assert.ok(genuine-charity-application.options.address);
    assert.ok(contract);
  });

  it("charity org object",async () => {
    // assert.ok(genuine-charity-application.options.address);
    const obj = await contract.methods.c().call();
    console.log(obj);
    assert.ok(obj);
  });

  it("post project",async () => {
    // assert.ok(genuine-charity-application.options.address);
    const hash = await contract.methods.Post_Project('0').send({ from:accounts[0] }); // instead of '0' we pass project id
    assert.ok(hash);

   });

   it("remove project",async () => {
     // assert.ok(genuine-charity-application.options.address);
     const hash = await contract.methods.Remove_Project('0').send({ from:accounts[0] }); // instead of '0' we pass project id
     assert.ok(hash);

    });

    it("send money to beneficiary",async () => {
      // assert.ok(genuine-charity-application.options.address);
      const hash = await contract.methods.Send_Money_Beneficiary('0').send({ from:accounts[0] }); // instead of '0' we pass payment id
      assert.ok(hash);

     });

});
