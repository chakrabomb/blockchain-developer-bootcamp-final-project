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
          await dapz.DailyRoll(accounts[1], {from: accounts[0]})
          let check = await dapz.isTimedOut(accounts[1], {from: accounts[0]})
          assert.equal(check, true)
            
    })



})