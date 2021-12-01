# blockchain-developer-bootcamp-final-project

### link: https://krish-13.github.io/blockchain-developer-bootcamp-final-project
### By: `0xdec386dec394Ca54CCb5d036de158265180b87ec`

### Prerequisites & Dependancies

    $ npm -v
    8.1.3

    $ node -v
    v16.13.0

    npm install @openzepellin/contracts 
    npm install truffle-assertions 
    npm install --save-dev @openzeppelin/test-helpers
    npm install @truffle/hdwallet-provider
    npm install dotenv
    npm install web3

### Running the Unit Tests

Uncomment the "developer" network in `truffle-config.js`, use port 8545

Run:

    $ truffle develop

    truffle(develop)> truffle test

### .env file
    SEED = "YOUR_MNEMONIC_SEED_PHRASE"
    INFURA = 'https://ropsten.infura.io/v3/YOUR_INFURA_API_KEY'


### Directory Structure

The structure is a basic truffle suite project with npm installed. No frameworks are used. 

There are 2 smart contracts in ./contracts - Migrations.sol, and Dapz.sol which is the main contract. The contract itself only uses two interfaces from the ./node_modules/@openzeppelin/contracts/ namely Ownable.sol and ERC20.sol (as well as all of its inheritences e.g. IERC20.sol etc.), and the rest of the modules are either used in the test file, or in the frontend files which are index.html and dapp.js. There are also the .json artifacts from deploying the two contracts to Ropsten Testnet located in ./build/contracts/
## Dap-upz ($DAPZ)

Dap-upz is a game for anyone who has an Ethereum wallet. Dap-up your friends on-chain and have the chance to get token rewards in $DAPZ for rolling lower against a daily challenge number. Dap-up new people to have more chances to win every day and have the chance to become Bruhs if you both roll below the challenge. Everyday you and a friend can exchange wallet addresses and the smart-contract uses the two addresses together (w/ the date and time of the roll) to roll a pseudo-random number for each of you. Depending on the outcome of you and your friends rolls you each have the chance to win $DAPZ token rewards. 

## How to play

Each day a new random challenge number can be set by the owner (will be updated to become trustless), and players can call `DailyRoll()` once with each of their friends' wallet addresses to start a game with each friend. Each friend of the original roller then has to call `DailyRoll()` with the first roller's address to finish that days game with them. The goal is for both players to roll below the daily challenge number.

## The Challenge

The game will have a randomly adjusted difficulty of the challenge every day. The challenge varies exponentially with the difficulty, and adjusts each day by powers of 10 in the range of 10^1 to 10^9, respective to the difficulty which ranges from 1 to 9. 

## The Reward

The reward for beating the challenge varies quadratically with the difficulty so players who win more difficult challenges get much higher rewards without creating any exponential inflation of the token. Up to 1 Quadrillion tokens can be rewarded `#shibarmy`. If two players beat the challenge together they each get rewarded three times the reward on that day `#(3,3)` and emit a `Bruh()` event on-chain to declare their victory! If one player in a pair beats the challenge then he gets rewarded the regular reward amount corresponding to that days difficulty, and the other player gets half the amount. If both players bust, better luck next time!

![kaiji san!](https://cdn1.mangasail.net/sites/default/files/manga/2/186431//20160630051740672.jpg)
