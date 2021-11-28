// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title a game that lets friends try to roll a number below a challenge to earn tokens
/// @author Krishna Sivapalan
contract Dapz is Ownable, ERC20 {

    /// @notice event for when two friends both roll under the challenge
    /// @param bruh1 is the first out of two friends
    /// @param bruh2 is the second out of two friends
    event Bruh(address bruh1, address bruh2);

    uint difficulty;
    uint challenge;
    uint dailyReward;
    uint maxSupply;

    mapping(address => mapping(address=>uint)) private dailyDaps;
    mapping(address => mapping(address=>uint)) private lastDap; 
    mapping(address => mapping(address=>bool)) private timedOut;
    constructor() public ERC20("Dapz", "DAPZ") {
        difficulty = uint(keccak256(abi.encodePacked(block.difficulty % block.timestamp)))%10;
        
        if(difficulty > 0){
            difficulty = 1;
        }
        
        challenge = 10 ** difficulty;
        dailyReward = (11-difficulty) **2;
        maxSupply = 1000000000000000;

    }

    /// @notice gets the current difficulty level
    /// @return the current difficulty level
    function getDifficulty() public view returns (uint){
        return difficulty;
    }
    
    /// @notice allows the owner to set a new difficulty level and corresponding challenge
    /// @dev use this for testing without having to rely on random difficulty value
    /// @param newDifficulty the new difficulty level to set
    function setDifficulty(uint newDifficulty) external onlyOwner {
        require(difficulty>=1 && difficulty<=9);
        difficulty = newDifficulty;
        dailyReward = (11-difficulty) **2;
        challenge = 10**difficulty;
    }

    /// @notice gets the current challenge number
    /// @return returns the current challenge number
    function getChallenge() public view returns (uint){
        return challenge;
    }

    /// @notice allows the owner to set a new challenge number
    /// @dev use this for testing without having to rely on random number challenges
    /// @param newChallenge the new challenge number to set
    function setChallenge(uint newChallenge) external onlyOwner {
        challenge = newChallenge;
    }

    /// @notice allows a player to check their roll with a specific friend
    /// @param friend the friend that the player rolled with
    /// @return the value of their previous roll with that friend
    function getRoll(address friend) public view returns(uint){
        return dailyDaps[msg.sender][friend];
    }

    /// @dev an internal function to roll a new number for a player with a friend and store relevant values
    /// @param sender the person who sent the transaction to execute a new roll
    /// @param friend the friend who the roller is playing with
    function _dapRoll(address sender, address friend) internal {
        lastDap[sender][friend] = block.timestamp;
        timedOut[sender][friend] = true;
        dailyDaps[sender][friend] = uint(keccak256(abi.encodePacked(sender,friend,block.timestamp))) % (10**10);

    }

    /// @notice check if a person is timed out from rolling with a friend
    /// @param friend the friend who the transaction sender is checking if they're timed out with
    /// @return a bool of whether or not the sender is timed out w/ their friend
    function isTimedOut(address friend) public view returns(bool){
        return timedOut[msg.sender][friend];
    }

    /// @notice when two players have both rolled with each other, this function checks their rolls and mints reward tokens accordingly
    /// @param sender the second friend in a pair to roll with each other
    /// @param friend the first person to have rolled with a friend
    function _checkChallengeAndMint(address sender, address friend) internal{
        difficulty = 777;
        bool senderCheck = false;
        bool friendCheck = false;
        uint currentSupply = totalSupply();

        uint roll_1 = dailyDaps[sender][friend];
        uint roll_2 = dailyDaps[friend][sender];

        if(roll_1 < challenge){
            senderCheck = true;
        }
        if(roll_2 < challenge){
            friendCheck = true;
        }

        if (senderCheck && friendCheck){
            assert((currentSupply + 2*3*dailyReward) <= maxSupply);
            _mint(sender, 3*dailyReward);
            _mint(friend, 3*dailyReward);
        }
        else if (senderCheck){
            assert((currentSupply + dailyReward + uint(dailyReward/2)) <= maxSupply);
            _mint(sender, dailyReward);
            _mint(friend, uint(dailyReward/2));
        }
        else if (friendCheck){
            assert((currentSupply + dailyReward + uint(dailyReward/2)) <= maxSupply);
            _mint(sender, uint(dailyReward/2));
            _mint(friend, dailyReward);
        }

    }

    function _dayPassed(address first, address second) private view returns(bool){
        return (lastDap[first][second]-block.timestamp) > (1 days + 2000);

    }

    function _resetTimer(address sender, address friend) private {
        timedOut[sender][friend] = false;
        timedOut[friend][sender] = false;
    }  

    /// @notice lets a player roll a pseudo-random number with a friend if they are not timed out
    /// @param friend the second person who the person who sends the txn wants to play with
    /// @dev after the second person rolls this function auto calls another internal function to check and mint rewards
    function DailyRoll(address friend) public {

        
        if(!timedOut[msg.sender][friend] && !timedOut[friend][msg.sender]){
            _dapRoll(msg.sender, friend);
        }

        else if (timedOut[msg.sender][friend] && timedOut[friend][msg.sender]){

            bool nextDay = _dayPassed(msg.sender, friend);
            bool nextDay_friend = _dayPassed(friend, msg.sender);
            
            if (nextDay && nextDay_friend){  
                _resetTimer(msg.sender, friend);
                _dapRoll(msg.sender, friend);                
            }
            else {
                revert();
            }
        }

        else if(timedOut[msg.sender][friend]){

            bool nextDay = _dayPassed(msg.sender, friend);
            if(nextDay){  
                _dapRoll(msg.sender, friend);               
            }
            else {
                revert();
            }
        }
        else if((timedOut[friend][msg.sender])){
            // 1st partner has already rolled, call a function that lets 2nd
            // partner roll and double down with respect to 1st roll
    
            _dapRoll(msg.sender, friend);
            _checkChallengeAndMint(msg.sender, friend);
            emit Bruh(friend, msg.sender);

        }







    }

    
}
