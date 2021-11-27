const Dapz = artifacts.require("Dapz")

contract("Dapz", (accounts) => {

    before(async () => {
        dapz = await Dapz.deployed()
    })

    it("starts 1M", async () =>{
      //  let balance = await dapz.balanceOf(accounts[0])
      //  console.log(web3.utils.fromWei(balance), 'ether')
    })



})