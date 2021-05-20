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

describe("genuine-charity-application",() => {
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
});
