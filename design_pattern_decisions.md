1. *Inheritance and Interfaces:* 
        Inherits 'ERC20' interface from openzeppelin's 'ERC20.sol'
        Inherits 'Ownable' interface from openzeppelin's 'Ownable.sol'



2. *Access Control Design Patterns:* 
        Uses 'onlyOwner()' modifier from 'Ownable' to restrict access to some functions e.g. 'setChallenge()' which makes the probability of winning tokens 100% and shouldn't be accessible other than to the owner for testing