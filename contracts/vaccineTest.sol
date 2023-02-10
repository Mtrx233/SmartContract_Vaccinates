pragma solidity ^0.4.19;

import "./vaccineHelper.sol";
import "./virus.sol";

contract VaccineTest is VaccineHelper, Virus {
    uint randNonce = 0;
    uint successProbability = 70;

    function randMod(uint _modulus) internal returns(uint) {
        randNonce++;
        return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
    }

    function test(uint _vaccineID, uint _virusID) external onlyOwnerOf(_vaccineID) {
        Vaccine storage vaccine = vaccines[_vaccineID];
        Virus storage virus = viruses[_virusID];
        uint rand = randMod(100);
        if (rand <= successProbability) {
            vaccine.cures++;
        }
    }

}