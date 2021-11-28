// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Dapz is Ownable, ERC20 {

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
        dailyReward = (10-difficulty) **2;
        maxSupply = 1000000000000000;

    }
    function getDifficulty() public view returns (uint){
        return difficulty;
    }

    function getChallenge() public view returns (uint){
        return challenge;
    }

    function _dapRoll(address sender, address friend) private {
        lastDap[sender][friend] = block.timestamp;
        timedOut[sender][friend] = true;
        dailyDaps[sender][friend] = uint(keccak256(abi.encodePacked(sender,friend,block.timestamp))) % (10**10);

    }

    function isTimedOut(address friend) public view returns(bool){
        return timedOut[msg.sender][friend];
    }

    function _checkChallengeAndMint(address sender, address friend) private{
        bool senderCheck = dailyDaps[sender][friend] < challenge;
        bool friendCheck = dailyDaps[friend][sender] < challenge;
        
        if (senderCheck && friendCheck){
            assert((totalSupply() + 2*3*dailyReward) <= maxSupply);
            _mint(sender, 3*dailyReward);
            _mint(friend, 3*dailyReward);
        }
        else if (senderCheck){
            assert((totalSupply() + dailyReward + uint(dailyReward/2)) <= maxSupply);
            _mint(sender, dailyReward);
            _mint(friend, uint(dailyReward/2));
        }
        else if (friendCheck){
            assert((totalSupply() + dailyReward + uint(dailyReward/2)) <= maxSupply);
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

    function setChallenge(uint newChallenge) external onlyOwner {
        challenge = newChallenge;
    }

    function getRoll(address friend) external view onlyOwner returns(uint){
        return dailyDaps[msg.sender][friend];
    }

    

    function DailyRoll(address friend) public {

        
        if(!(timedOut[msg.sender][friend] && timedOut[friend][msg.sender])){
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


        }







    }

    
}
