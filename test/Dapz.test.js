const Dapz = artifacts.require("Dapz")

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

      await dapz.setChallenge(13, {from: accounts[0]})
      let newChallenge = await dapz.getChallenge({from: accounts[0]})
      assert.equal(newChallenge, 13)

      //optionally check onlyOwner
      //await dapz.setChallenge(420, {from: accounts[1]})
      //let unsuccesfulChallenge = await dapz.getChallenge({from: accounts[0]})
      //assert.equal(unsuccesfulChallenge, 13)
        
    })
  
    it("Reward two friends who both roll under the challenge w/ each other", async () =>{

//      await dapz.setDifficulty(1, {from: accounts[0]})
//      await dapz.setChallenge(1000000000000, {from: accounts[0]})

//      await dapz.DailyRoll(accounts[1], {from: accounts[0]})      
//      await dapz.DailyRoll(accounts[0], {from: accounts[1]})
      
//      let roll1 = await dapz.getRoll(accounts[0], {from: accounts[1]})
//      let roll2 = await dapz.getRoll(accounts[1], {from: accounts[0]})

//      let friend1Balance = await dapz.balanceOf(accounts[0])
//      let friend2Balance = await dapz.balanceOf(accounts[1])
      
//      assert.equal(friend1Balance, 300)
//      assert.equal(friend2Balance, 300)
        
    })

    it("", async () =>{


              
    })



})