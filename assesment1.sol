// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract PlayerRegistry {
    string[] players;
    uint256 public totalPlayers;

    event PlayerAdded(string name);
    event RandomPlayerSelected(string name);

    function addPlayer(string memory _name) public {
        require(bytes(_name).length > 0, "Name must not be empty");
        players.push(_name);
        totalPlayers++;
        assert(totalPlayers == players.length); // Ensure consistency
        emit PlayerAdded(_name);
    }

    function Winner() public view returns (string memory) {
        if (totalPlayers == 0) {
            revert("No players registered yet");
        }
        uint256 randIndex = _randomModulus(totalPlayers);
        return players[randIndex];
    }

    function _randomModulus(uint256 _modulus) private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, blockhash(block.number - 1), players.length))) % _modulus;
    }

    function showplayers() public view returns (string[] memory Players) {
        return players;
    }
    
    function deletePlayer(uint256 index) public {
        require(index < players.length, "Index out of bounds");
        assert(players.length > 0); // Ensuring there's at least one player
        players[index] = players[players.length - 1];
        players.pop();
        totalPlayers--;
    }
}
