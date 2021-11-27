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
    mapping(address => mapping(address=>bool)) public doubleDown


    constructor() public ERC20("Dapz", "DAPZ") {
        difficulty = uint(keccak256(abi.encodePacked(block.difficulty % now)))%10;
        
        if(difficulty == 0){
            difficulty = 1;
        }
        
        challenge = 10 ** difficulty
        dailyReward = (10-difficulty) **2;

    }

    function _dapRoll(address friend) internal returns(uint) {
        return uint(keccak256(abi.encodePacked(msg.sender,friend,now))) % (10**10);
    }

    function firstDailyRoll(address friend) public returns(){
        
        if( (timedOut[msg.sender][friend] == false) || (timedOut[friend][msg.sender] == false)){
            dailyDaps[msg.sender][friend] = _dapRoll(friend);
            lastDap[msg.sender][friend] = now;
            timedOut[msg.sender][friend] = true;

        }
        else if(timedOut[msg.sender][friend] == true){

            if( ((lastDap[msg.sender][friend]-now) > (1 days + 2000)) ){

                if( (((lastDap[friend][msg.sender]-now) > (1 days + 2000)) && timedOut[friend][msg.sender]==true) || (timedOut[friend][msg.sender] == false)){
                    
                    lastDap[msg.sender][friend] = now;
                    timedOut[msg.sender][friend] = true;
                    timedOut[friend][msg.sender] = false;
                    
                    
                }
                else {
                    revert();
                }
            }
            else {
                revert();
            }
        }
        else if((timedOut[friend][msg.sender]==true) && timedOut[msg.sender][friend]==false){
            // 1st partner has already rolled, call a function that lets 2nd
            // partner roll and double down with respect to 1st roll
        }





    }

    
}