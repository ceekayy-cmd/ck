// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PlayerRegistry {
    string[] players;
    uint256 public totalPlayers;

    event PlayerAdded(string name);
    event RandomPlayerSelected(string name);

    function addPlayer(string memory _name) public {
        require(bytes(_name).length > 0, "Player name cannot be empty"); // Added require statement
        players.push(_name);
        totalPlayers++;
        emit PlayerAdded(_name);
    }

    function Winner() public view returns (string memory) {
        require(totalPlayers > 0, "No players registered yet");
        uint256 randIndex = _randomModulus(totalPlayers);
        return players[randIndex];
    }

    function _randomModulus(uint256 _modulus) private view returns (uint256) {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, players.length)));
        assert(randomNumber < _modulus); // Added assert statement
        return randomNumber % _modulus;
    }

    function showplayers() public view returns (string[] memory Players) {
        return players;
    }
}
