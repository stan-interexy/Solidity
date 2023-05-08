// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    mapping(address => bool) public voters;
    mapping(bytes32 => uint256) public votes;

    event NewVote(address indexed voter, bytes32 indexed candidate, uint256 votesCount);

    constructor() {
        // Initialize voters
        voters[msg.sender] = true;
    }

    modifier onlyVoter() {
        require(voters[msg.sender], "Sender is not a registered voter.");
        _;
    }

    function addVoter(address _voter) external onlyVoter {
        voters[_voter] = true;
    }

    function removeVoter(address _voter) external onlyVoter {
        voters[_voter] = false;
    }

    function vote(bytes32 _candidate) external onlyVoter {
        votes[_candidate] += 1;
        emit NewVote(msg.sender, _candidate, votes[_candidate]);
    }
}