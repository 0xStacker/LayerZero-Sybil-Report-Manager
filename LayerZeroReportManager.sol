// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SybilReport{
    address owner;
    constructor(){
        owner = msg.sender;
    }
    uint public idCounter;

    struct Report{
        uint reportId;
        address creator;
        bool status;
    }

    Report[] internal reports;

    mapping(uint => Report) internal reportsMap;


// Allow users to create a report, return report Id.
// Requires that user sends exactly 0.1 ether to the contract as stake

    function createReport() external payable returns(uint){
        require(msg.value == 0.1 ether, "Stake should be exactly 0.1 ETH");
        idCounter++;
        Report storage newReport = reports.push();
        newReport.creator = msg.sender;
        newReport.reportId = idCounter;
        reportsMap[idCounter] = newReport;
        reportsMap[idCounter].reportId = idCounter;
        reportsMap[idCounter].creator = msg.sender;  
        return idCounter;
    }

    modifier onlyOwner(address _caller){
        require(_caller == owner);
        _;
    }


// Once a user report has been cleared and approved, admin can call this function to return their ether.
    function approveReport(uint _reportId) onlyOwner(msg.sender) external{
        reportsMap[_reportId].status = true;
        reports[_reportId - 1].status = true;
        (bool success, ) = reportsMap[_reportId].creator.call{value: 0.1 ether}("");
        success;

    }

    function withdraw() external returns(bool){
        require(msg.sender == owner, "NotOwner");
        (bool success, ) = owner.call{value: address(this).balance}("");
        return success;
    }
    

    receive() external payable { }

}

   
