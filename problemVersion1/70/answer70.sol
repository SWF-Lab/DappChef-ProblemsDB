// SPDX-License-Identifier: MIT
// ref: https://docs.soliditylang.org/en/v0.8.17/solidity-by-example.html
pragma solidity ^0.8.17;

// TODO: design a voting contract to record how many votes did candidates get and computing the winner.
// hint: make sure the variable type is correct in the structs
contract answer70 {
    event NewVote(string);

    struct Voter {
        /*
           the structure of a Voter is as below:
            Voter 
                |
                |_ (uint) weight (can be modified in the constructor) 
                |
                |_ (bool) voted (if the person is voted or not)
        */
        uint256 weight; 
        bool voted;
    }

    struct Proposal {
        /*
           the structure of a Proposal is as below:
           Proposal Name 
                |
                |_ choices
                    |
                    |_ (string) choice_1 -- (uint) (0) (get 0 vote)
                    |
                    |_ (string) choice_2 -- (uint) (0) (get 0 vote)
                    |
                    |_ (string) choice_3 -- (uint) (0) (get 0 vote)
        */
        // name of the proposal
        string name;
        // proposal name => vote
        mapping (string => uint256) choices; 
    }
    
    mapping(address => Voter) private voters;
    mapping(uint256 => Account) public Operators; // for judge system

    address chairPerson;
    Proposal proposal;
    uint256 startTime;
    

    constructor (uint256 _weight, string memory _name, string[] memory _choices) { 
        chairPerson = tx.origin;
        startTime = block.timestamp;

        // update choices and proposal
        proposal.name = _name;
        for (uint256 i = 0; i < _choices.length; i++) {
            proposal.choices[ _choices[i] ] = 0;
        }

        // for judging system
        for (uint256 i = 0; i < 7 ; i++) {
            Operators[i] = new Account(tx.origin);
            voters[address(Operators[i])] = Voter(_weight, false);
        }
    }

    modifier onlyChairPerson {
        require (msg.sender == chairPerson, "not chairPerson");
        _;
    }

    modifier onlyVoter {
        // TODO: you should prevent anyone who is not from the voters to vote. 
        require(voters[msg.sender].weight > 0, "not a voter");
        _;
    }
    
    function vote(string memory choiceName) public onlyVoter {
        // TODO: you should complete this function to vote to a choice in a proposal
        // TODO1: restrict those who have voted
        require(!voters[msg.sender].voted, "have voted");
        
        // TODO2: record the vote to proposal.choices (remember the weight)
        proposal.choices[choiceName] += voters[msg.sender].weight;

        // TODO3: record the voting status of the voter
        voters[msg.sender].voted = true;

        emit NewVote(choiceName);
    }



    function tally (string [] memory _choices) public view onlyChairPerson returns(string memory) {
        //TODO: this function calculate the result (with the highest votes) and return the winning choice
        uint256 max = 0;
        string memory winner;
        for (uint256 i = 0; i < _choices.length; i++) {
            uint256 currentGetVote = proposal.choices[_choices[i]];
            if (currentGetVote > max) {
                max = currentGetVote;
                winner = _choices[i];
            }
        }
        return winner;
    }

    function getVoterStatus(uint256 i) public view returns(Voter memory) {
        return(voters[address(Operators[i])]);
    }


    function voteFromOperators(uint256 i, string memory _choiceName) public {
        bytes memory voteCallData = abi.encodeWithSelector(this.vote.selector, _choiceName);
        Operators[i].execute(address(this), voteCallData);
    }
}

// for judge system
contract Account { 

    address payable public owner;

    constructor(address _owner) {
        owner = payable(_owner);
    }

    function transfer(address _target, uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable(_target).transfer(_amount);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
    
    function execute(address _target, bytes memory _data) external payable {
        (bool success, ) = _target.call{value: msg.value}(_data);
        require(success, "failed");
    }

    receive() external payable {}

}


