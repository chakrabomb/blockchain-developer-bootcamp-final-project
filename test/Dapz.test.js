const Dapz = artifacts.require("Dapz")

contract("Dapz", (accounts) => {

    before(async () => {
        dapz = await Dapz.deployed()
    })

    it("starts 1M", async () =>{
          let diff = await dapz.getDifficulty()
          console.log(diff, 'bruh')
    })



})