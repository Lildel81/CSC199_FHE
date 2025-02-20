// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "fhevm/lib/TFHE.sol";
import "fhevm/config/ZamaFHEVMConfig.sol";

contract Election {
    struct Counts {
        euint256 red_total; // Total votes for red candidate set as encrypted Euint Value
        euint256 blue_total; // Total votes for blue candidate set as encrypted Euint Value
    }

    Counts public count;

    // initializing the totals as encrypted values
    

    mapping(address => bool) private hasVoted;

    address public owner;
    bool public started;
    bool public ended;

    constructor()
    {
        owner = msg.sender;
        started = false;
        ended = false;
	//setting totals as encrypted values
       /* count = Counts({
	
	red_total: TFHE.asEuint256(0),
        blue_total: TFHE.asEuint256(0)
	});*/
    }

    function initializeCounts() public 
    {
	    require(msg.sender == owner, "Only owner can initialize counts");
	    count.red_total = TFHE.asEuint256(0);
	    count.blue_total = TFHE.asEuint256(0);
    }

    modifier onlyOwner()
    {
        require(msg.sender == owner, "This action is only applicable to the electoral college");
        _;
    }

    function startElection() public onlyOwner
    {
        require(!started, "Election has started");
        started = true;
        ended = false;
    }

    function endElection() public onlyOwner
    {
        require(started, "Election has not started yet");
        require (!ended, "Election has already ended");
        ended = true;
    }



    // Vote function: Cast a vote for "Red" or "Blue"
    function Vote(string memory _candidate) public {
        // Ensure the voter hasn't already voted
        require(started, "Election has not started yet");
        require (!ended, "Election has already ended");
        require(!hasVoted[msg.sender], " This address has already voted");

	

        // Check the candidate and increment the respective count
        if (keccak256(abi.encodePacked(_candidate)) == keccak256(abi.encodePacked("Red"))) {
            count.red_total = TFHE.add(count.red_total, TFHE.asEuint256(1));
        } else if (keccak256(abi.encodePacked(_candidate)) == keccak256(abi.encodePacked("Blue"))) {
            count.blue_total = TFHE.add(count.blue_total, TFHE.asEuint256(1));
        } else {
            revert("Invalid candidate"); // Reject invalid candidates
        }

        // Mark the sender as having voted
        hasVoted[msg.sender] = true;
    }

    // GetCount function: Return the current vote totals
    function GetCount() public view returns (euint256 redVotes, euint256 blueVotes) {
        return (count.red_total, count.blue_total);
    }

    function GetResults() public view returns (euint256 redVotes, euint256 blueVotes)
    {
        require(ended, "Election is still in progress.");
        return (count.red_total, count.blue_total);
    }

}
