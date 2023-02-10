pragma solidity ^0.4.19;

import "./vaccineTest.sol";
import "./safemath.sol";
import "./erc721.sol";
import "./virus.sol";

contract VaccineOwnership is Virus, VaccineTest, ERC721 {
    using SafeMath for uint256;

    mapping (uint => address) vaccineApprovals;

    function balanceOf(address _owner) public view returns (uint256 _balance) {
        return ownerVaccineCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address _owner) {
        return vaccineToOwner[_tokenId];
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        ownerVaccineCount[_to] = ownerVaccineCount[_to].add(1);
        ownerVaccineCount[msg.sender] = ownerVaccineCount[msg.sender].sub(1);
        vaccineToOwner[_tokenId] = _to;
        Transfer(_from, _to, _tokenId);
    }

    function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        _transfer(msg.sender, _to, _tokenId);
    }

    function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        vaccineApprovals[_tokenId] = _to;
        Approval(msg.sender, _to, _tokenId);
    }

    function takeOwnership(uint256 _tokenId) public {
        require(vaccineApprovals[_tokenId] == msg.sender);
        address owner = ownerOf(_tokenId);
        _transfer(owner, msg.sender, _tokenId);
    }
}