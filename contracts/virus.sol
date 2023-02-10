pragma solidity ^0.4.19;

contract Virus {

    struct Virus {
        string name;
        uint level;
    }

    uint rnaDigits = 16;
    uint rnaModulus = 10 ** rnaDigits;


    Virus[] public viruses;

    function _createViruses(string _name, uint _rna) internal {
        uint id = viruses.push(Virus(_name, 10)) - 1;
    }

    function _generateRandomRna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % rnaModulus;
    }

    function createRandomVirus(string _name) public {
        uint randRna = _generateRandomRna(_name);
        randRna = randRna - randRna % 100;
        _createViruses(_name, randRna);
    }

    
}