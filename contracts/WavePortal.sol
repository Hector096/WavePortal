// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {

    uint256 totalWaves;
    uint256 private seed;



       event NewWave(address indexed from, uint256 timestamp, string message);

        struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    Wave[] waves;
    constructor() payable {
  console.log("We have been constructed!");
  seed = (block.timestamp + block.difficulty) % 100;
}


    function wave (string memory _message) public {
totalWaves += 1;
 console.log("%s waved w/ message %s", msg.sender, _message);
waves.push(Wave(msg.sender, _message, block.timestamp));
seed = (block.difficulty + block.timestamp + seed) % 100;

 if (seed < 50) {
uint256 prizeAmount = 0.0001 ether;
require(
        prizeAmount <= address(this).balance,
        "Trying to withdraw more money than the contract has."
    );
console.log("%s has waved!",msg.sender);
(bool success, ) = (msg.sender).call{value: prizeAmount}("");
    require(success, "Failed to withdraw money from contract.");
 }
emit NewWave(msg.sender, block.timestamp, _message);

    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

function getTotalWaves () public view returns (uint256) {
console.log("we have %d total waves!",totalWaves);
return totalWaves;
}
}