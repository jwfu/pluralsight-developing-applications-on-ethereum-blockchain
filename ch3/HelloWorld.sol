pragma solidity ^0.4.0;

contract HelloWorld {
    string public message;

    function setMessage(string newMessage) public {
        message = newMessage;
    }

    function remove() public {
        selfdestruct(0x0);
    }
}