// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract NeatReceiver {
    address public minter;
    address public contract_owner;
    uint neatBalance;
    event ReceivedNeat(address sender, uint amount);
    event NewMinterAddress(address _minter_address);
    event sentNeat(address _receiver,uint _amount);

    constructor(address authorized_minter ){
        minter = authorized_minter;
        contract_owner = msg.sender;
    }

    receive() external payable {
            // Handle received Ether
            neatBalance = neatBalance + msg.value;
            emit ReceivedNeat(msg.sender, msg.value);
        }
    modifier isMinter{
        require(minter == msg.sender,"You are not an authorized minter");
        _;
    }
    modifier isContractOwner{
        require(contract_owner == msg.sender,"You are the contract owner");
        _;
    }

    function sendNeat(address _receiver,uint _amount) payable public isMinter{
        payable(_receiver).transfer(_amount);
        neatBalance = neatBalance - _amount;
        emit sentNeat(_receiver, _amount);
    }

    function setMinter(address _minter) public isContractOwner{
        minter = _minter;
        emit NewMinterAddress(_minter);
    }
}