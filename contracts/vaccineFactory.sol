pragma solidity ^0.4.19;

import "./ownable.sol";

contract VaccineFactory is Ownable{
    event newVaccine(uint vaccineID, string name, uint rna);
    uint rnaDigits = 16;
    uint rnaModulus = 10 ** rnaDigits;

    address owner;

    function VaccineFactory() {
        owner = msg.sender;
    }

    struct Vaccine {
        string name;
        uint rna;
        uint power;
        uint cures;
    }

    Vaccine[] public vaccines;

    mapping (uint => address) public vaccineToOwner;
    mapping (address => uint) ownerVaccineCount;

    function _createVaccine(string _name, uint _rna) internal {
        uint id = vaccines.push(Vaccine(_name, _rna, 1, 0)) - 1;
        vaccineToOwner[id] = msg.sender;
        ownerVaccineCount[msg.sender]++;
        newVaccine(id, _name, _rna);
    }

    function whoRU() public returns (address) {
        return msg.sender;
    }

    function _generateRandomRna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % rnaModulus;
    }

    function createRandomVaccine(string _name) public {
        //require(ownerVaccineCount[msg.sender] == 0);
        uint randRna = _generateRandomRna(_name);
        randRna = randRna - randRna % 100;
        _createVaccine(_name, randRna);
    }

    function kill() public {
        if (owner == msg.sender) {
            selfdestruct(owner);
        }
    }

}