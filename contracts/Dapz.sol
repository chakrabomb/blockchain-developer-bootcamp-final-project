// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Dapz is ERC20 {

    event Mint(address to);

    uint difficulty;
    uint challenge;
    uint dailyReward;

    mapping(address => mapping(address=>uint)) public dailyDaps;
    mapping(address => mapping(address=>uint)) public lastDap; 
    mapping(address => mapping(address=>bool)) public timedOut;
    mapping(address => mapping(address=>bool)) public doubleDown;
    mapping(address => mapping(address=>bool)) public claimable;


    constructor() public ERC20("Dapz", "DAPZ") {
        difficulty = uint(keccak256(abi.encodePacked(block.difficulty % now)))%10;
        
        if(difficulty == 0){
            difficulty = 1;
        }
        
        challenge = 10 ** difficulty
        dailyReward = (10-difficulty) **2;

    }

    function _dapRoll(address sender, address friend) internal returns() {
        lastDap[sender][friend] = now;
        timedOut[sender][friend] = true;
        dailyDaps[sender][friend] = uint(keccak256(abi.encodePacked(sender,friend,now))) % (10**10);

    }

    function _checkChallengeAndMint(address sender, address friend) internal returns(){
        bool senderCheck = dailyDaps[sender][friend] < challenge;
        bool friendCheck = dailDaps[friend][sender] < challenge;

        if (senderCheck && friendCheck){
            _mint(sender, 3*dailyReward);
            _mint(friend, 3*dailyReward);
        }
        else if (senderCheck){
            _mint(sender, dailyReward);
            _mint(friend, uint(dailyReward/2));
        }
        else if (friendCheck){
            _mint(sender, uint(dailyReward/2));
            _mint(friend, dailyReward);
        }

    }

    function _dayPassed(address first, address second) internal returns(bool){
        return (lastDap[first][second]-now) > (1 days + 2000);

    }

    function _resetTimer(address sender, address friend) internal returns(){
        timedOut[sender][friend] = false;
        timedOut[friend][sender] = false;
    }

    

    function firstDailyRoll(address friend) public returns(){

        
        if(!(timedOut[msg.sender][friend] && timedOut[friend][msg.sender])){
            _dapRoll(msg.sender, friend);
        }

        else if (timedOut[msg.sender][friend] && timedOut[friend][msg.sender]){
            if (_dayPassed(msg.sender, friend) && _dayPassed(friend, msg.sender)){  
                _resetTimer(msg.sender, friend);
                _dapRoll(msg.sender, friend);

                
            }
            else {
                revert();
            }
        }

        else if(timedOut[msg.sender][friend]){

            if( (_dayPassed(msg.sender, friend)){
                    
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