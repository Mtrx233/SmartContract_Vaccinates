pragma solidity ^0.4.19;

import "./vaccineFactory.sol";

contract VaccineHelper is VaccineFactory {

    modifier onlyOwnerOf(uint _vaccineID) {
        require(msg.sender == vaccineToOwner[_vaccineID]);
        _;
    }

    modifier aboveCures(uint _cures, uint _vaccineID) {
        require(vaccines[_vaccineID].cures >= _cures);
        _;
    }

    uint powerUpFee = 0.0001 ether;

    function withdraw() external onlyOwner {
        owner.transfer(this.balance);
    }

    function setPowerUpFee(uint _fee) external onlyOwner {
        powerUpFee = _fee;
    }

    function powerUp(uint _vaccineID) external payable {
        require(msg.value == powerUpFee);
        vaccines[_vaccineID].power++;
    }

    function check() public returns (uint) {
        return owner.balance;

    }

    function changeName(uint _vaccineID, string _newName) external aboveCures(2, _vaccineID) onlyOwnerOf(_vaccineID) {
        vaccines[_vaccineID].name = _newName;
    }

    function changeRna(uint _vaccineID, uint _newRna) external aboveCures(20, _vaccineID) onlyOwnerOf(_vaccineID) {
        vaccines[_vaccineID].rna = _newRna;
    }

    function getVaccinesByOwner(address _owner) external view returns(uint[]) {
        uint[] memory result = new uint[](ownerVaccineCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < vaccines.length; i++) {
            if (vaccineToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}