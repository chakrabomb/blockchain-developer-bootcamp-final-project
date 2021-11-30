# blockchain-developer-bootcamp-final-project

## Dap-upz ($DAPZ)

Dap-upz is a game for anyone who has an Ethereum wallet. Dap-up your friends on-chain and have the chance to get token rewards in $DAPZ for rolling lower against a daily challenge number. Dap-up new people to have more chances to win every day and have the chance to become Bruhs if you both roll below the challenge. Everyday you and a friend can exchange wallet addresses and the smart-contract uses the two addresses together (w/ the date and time of the roll) to roll a pseudo-random number for each of you. Depending on the outcome of you and your friends rolls you each have the chance to win $DAPZ token rewards. 

### How to play

Each day a new random challenge number can be set by the owner (will be updated to become trustless), and players can call `DailyRoll()` once with each of their friends' wallet addresses to start a game with each friend. Each friend of the original roller then has to call `DailyRoll()` with the first roller's address to finish that days game with them. The goal is for both players to roll below the daily challenge number.

### The Challenge

The game will have a randomly adjusted difficulty of the challenge every day. The challenge varies exponentially with the difficulty, and adjusts each day by powers of 10 in the range of 10^1 to 10^9, respective to the difficulty which ranges from 1 to 9. 

# The Reward

The reward for beating the challenge varies quadratically with the difficulty so players who win more difficult challenges get much higher rewards without creating any exponential inflation of the token. Up to 1 Quadrillion tokens can be rewarded `#shibarmy`. If two players beat the challenge together they each get rewarded three times the reward on that day `#(3,3)` and emit a `Bruh()` event on-chain to declare their victory!. If one player in a pair beats the challenge then he gets rewarded the regular reward amount corresponding to that days difficulty, and the other player gets half the amount. If both players bust, better luck next time!

## Installing Dependancies

1. `npm install @openzepellin/contracts` (used in Dapz.sol smart contract)
2. `npm install truffle-assertions` (used in Dapz.test.js)
3. `npm install --save-dev @openzeppelin/test-helpers` (used in Dapz.test.js)
