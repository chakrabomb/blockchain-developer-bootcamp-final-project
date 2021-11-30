# blockchain-developer-bootcamp-final-project

## Dap-upz ($DAPZ)

Dap-upz is a game for anyone who has an Ethereum wallet. Everyday you and a friend can exchange wallet addresses and use the two addresses together (w/ the date and time of the roll) to roll a pseudo-random number. Depending on the outcome of you and your friends rolls you each have the chance to win $DAPZ token rewards. 

### How to play

Each day a new random challenge number can be set by the owner (will be updated to become trustless), and players can call `DailyRoll()` once with each of their friends' wallet addresses to start a game with each friend. Each friend of the original roller then has to call `DailyRoll()` with the first roller's address to finish that days game with them. The goal is for both players to roll below the daily challenge number.

### The Challenge

The game will have a randomly adjusted difficulty of the challenge every day. The challenge varies exponentially with the difficulty, and adjusts each day by powers of 10. The challenge number varies by powers of 10 each day in the range of 10^1 to 10^9, respective to the difficulty which ranges from 1 to 9. 

# The Reward

The reward for beating the challenge varies quadratically with the difficulty so players who win more difficult challenges get much higher rewards without creating any exponential inflation of the token. If two players beat the challenge together they each get rewarded three times the reward on that day. If one player in a pair beats the challenge then he gets rewarded the regular reward amount corresponding to that days difficulty, and the other player gets half the amount. If both players bust, better luck next time!

## Installing Dependancies

1. `npm install @openzepellin/contracts` (used in Dapz.sol smart contract)
2. `npm install truffle-assertions` (used in Dapz.test.js)
3. `npm install --save-dev @openzeppelin/test-helpers` (used in Dapz.test.js)
