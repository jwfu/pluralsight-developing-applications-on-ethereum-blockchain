pragma solidity ^0.4.0;
pragma experimental ABIEncoderV2;

contract Voter{

    struct OptionPos{
        uint pos; //the position, an int
        bool exists; //required due to limitation with solidity
    }

    uint[] public votes;
    string[] public options;
    mapping(address => bool) hasVoted;
    mapping (string => OptionPos) posOfOption;

    constructor(string[] _options) public{
        options = _options;
        votes.length = options.length;

        for (uint i = 0; i < options.length; i++){ 
            OptionPos memory optionPos = OptionPos(i,true); //creates OptionPos structs, which will be the value in the mapping
            string optionName = options[i]; //creates optionName strings, which will be the key
            posOfOption[optionName] = optionPos; //makes the mapping entry

        }
    }

    function vote(string optionName) public {
        require(!hasVoted[msg.sender], "Account has already voted");

        OptionPos memory optionPos = posOfOption[optionName]; //gets the current value of votes 
        require(optionPos.exists, "Option does not exist");

        votes[optionPos.pos] = votes[optionPos.pos] + 1; //increments it
        hasVoted[msg.sender] = true; //prevents repeated voting
    }

    function getOptions() public view returns (string[]){
        return options;
    }

    function getVotes() public view returns (uint[]){
        return votes;
    }
}