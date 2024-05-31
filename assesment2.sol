// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract PlayerRegistry {
    string[] players;
    uint256 public totalPlayers;

    event PlayerAdded(string name);
    event RandomPlayerSelected(string name);

    function addPlayer(string memory _name) public {
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
        return uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players.length))) % _modulus;
    }

    function showplayers() public view returns (string[] memory Players) {
        return players;
    }
}
