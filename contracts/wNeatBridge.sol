// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract wNeatBSCReceiverANdSender{
    address public wNeatMinter;
    address public contract_owner;
    address public wNeatAddress;
    uint public wNeatBalance;
    event wNeatReceived(address sender, uint amount_received);
    event wNeatSent(address _receiver, uint amount_sent);
    constructor(address _wNeatMinter, address _wNeatAddress){
        wNeatMinter = _wNeatMinter;
        contract_owner = msg.sender;
        wNeatAddress = _wNeatAddress;
    }

    modifier iswNeatMinter{
        require(msg.sender == wNeatMinter,"You are not the authorized minter");
        _;
    }

    function receiveWrapNeat(uint _amount) public {
        IERC20(wNeatAddress).transferFrom(msg.sender, address(this), _amount);
        emit wNeatReceived(msg.sender, _amount);
    }

    function sendWrapNeat(uint _amount,address _receiver)public iswNeatMinter{
        IERC20(wNeatAddress).transfer(_receiver,_amount);
        emit wNeatSent(_receiver, _amount);
    }
}