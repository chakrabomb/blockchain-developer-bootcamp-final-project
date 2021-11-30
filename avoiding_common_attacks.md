1. **SWC-103 (Floating Pragma)**

    - `pragma solidity 0.8.0;` specified compiler pragma for stability, prevent errors from using multiple compiler versions

    
2. **Proper use of `assert()`, `require()`, and `revert()`**

    - use `assert()` within `_checkChallengeAndMint()` to prevent minting over max supply of 1 quadrillion tokens

    - use `revert()` within `DailyRoll()` nested if-else blocks to only allow a player to play with a friend once a day...revert multiple specific cases while executing different instructions for various other specific cases


3. **SWC-116 (Block Values as a Proxy for Time)**

    - to prevent miners manipulating block.timestamp (usually within a range of 900s), a long 24h timeout period is used to make time manupilations insignificant; an extra 2000 seconds is added to the 24h timeout to ensure that players wait at least 24h even with manipulated timestamps