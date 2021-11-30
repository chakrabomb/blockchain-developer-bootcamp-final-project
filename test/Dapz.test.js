const Dapz = artifacts.require("Dapz")
const truffleAssert = require('truffle-assertions')

contract("Dapz", (accounts) => {

    before(async () => {
        dapz = await Dapz.deployed()
    })

    it("Time-out rolls w/ a friend for 24h after rolling w/ that friend", async () =>{
      //this test sends a daily roll from the deployer address
      //with accounts[1] as a friend, after the roll it 
      //checks timedOut mapping to make sure they can't roll again if calling the function
      //at least until 24h passes

      //await dapz.DailyRoll(accounts[1], {from: accounts[0]})
      //let isTimedOut = await dapz.isTimedOut(accounts[1], {from: accounts[0]})
      //assert.equal(isTimedOut, true)
            
    })

    it("Lets the owner set a new challenge number", async () =>{
      //the owner sends a txn to set the challenge number to 13
      //assert that the challenge was set to 13 correctly
      await dapz.setChallenge(13, {from: accounts[0]})
      let newChallenge = await dapz.getChallenge({from: accounts[0]})
      assert.equal(newChallenge, 13)        
    })
  
    it("Reward two friends who both roll under the challenge w/ each other", async () =>{

      //set the difficulty such that corresponding reward is 100
      //set the challenge to a high enough number that any roll is below it
      //therefore every roll should win with this challenge number
//      await dapz.setDifficulty(1, {from: accounts[0]})
//      await dapz.setChallenge(1000000000000, {from: accounts[0]})

      //a pair of friends each roll with each other
//      await dapz.DailyRoll(accounts[1], {from: accounts[0]})      
//      await dapz.DailyRoll(accounts[0], {from: accounts[1]})

      //each friend should have a balance of 300 for both winning the challenge
//      let friend1Balance = await dapz.balanceOf(accounts[0])
//      let friend2Balance = await dapz.balanceOf(accounts[1])      
//      assert.equal(friend1Balance, 300)
//      assert.equal(friend2Balance, 300)
        
    })

    it("Reverts when someone tries to roll twice w/o 24h delay", async () =>{
      //call DailyRoll() twice with the same ms.sender and same friend
      //second roll should revert because timeOut period is active
      await dapz.DailyRoll(accounts[1], {from: accounts[0]})      
      await truffleAssert.reverts(dapz.DailyRoll(accounts[1], {from: accounts[0]}))
           
    })



})