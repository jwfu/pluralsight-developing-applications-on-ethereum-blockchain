pragma solidity ^0.4.0;
pragma experimental ABIEncoderV2;

contract MultiSigWallet{
    uint minApprovers;

    address beneficiary;
    address owner;

    mapping(address => bool) approvedBy;
    mapping(address => bool) isApprover;
    uint approvalsNum;

    constructor(
        address[] _approvers,
        uint _minApprovers,
        address _beneficiary
    ) public payable {
        require(    _minApprovers <= _approvers.length,
                    "Required number of approvers should be less than number of approvers");

        minApprovers = _minApprovers;

        beneficiary = _beneficiary;
        owner = msg.sender;

        for(uint i = 0; i < _approvers.length; i++){
            address approver = _approvers[i]; //gets an approver from the input list
            isApprover[approver] = true; //sets them as an approver in the array
        }

    }

    function approve()public{
        require(isApprover[msg.sender], "Not an approver");
        if(!approvedBy[msg.sender]){ //check that this person has not approved yet
            approvalsNum++;
            approvedBy[msg.sender] = true;
        }

        if(approvalsNum == minApprovers) {
            beneficiary.send(address(this).balance);  //send shouldnt be used, this does not have a revert, would need to parse the return code
            selfdestruct(owner);
        }
    }

    function reject()public{
        require(isApprover[msg.sender], "Not an approver");
        selfdestruct(owner);
    }
}