// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PlayerRegistry {
    string[] private players;
    uint256 public totalPlayers;

    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;

    event PlayerAdded(string name);
    event RandomPlayerSelected(string name);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Redeem(address indexed from, uint256 value, string reward);

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
        return uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, players.length))) % _modulus;
    }

    function showplayers() public view returns (string[] memory) {
        return players;
    }

    // Token mint function
    function mint(address to, uint256 amount) public {
        require(to != address(0), "Cannot mint to the zero address");
        balances[to] += amount;
        emit Mint(to, amount);
    }

    // Token burn function
    function burn(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        emit Burn(msg.sender, amount);
    }

    // Token transfer function
    function transfer(address to, uint256 amount) public returns (bool) {
        require(to != address(0), "Cannot transfer to the zero address");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    // Token transferFrom function for allowance
    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        require(to != address(0), "Cannot transfer to the zero address");
        require(balances[from] >= amount, "Insufficient balance");
        require(allowances[from][msg.sender] >= amount, "Allowance exceeded");

        balances[from] -= amount;
        balances[to] += amount;
        allowances[from][msg.sender] -= amount;
        emit Transfer(from, to, amount);
        return true;
    }

    // Approve allowance function
    function approve(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0), "Cannot approve to the zero address");
        allowances[msg.sender][spender] = amount;
        return true;
    }

    // Redeem function to exchange tokens for a reward
    function redeem(uint256 amount, string memory winner) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        emit Redeem(msg.sender, amount, winner);
        // Logic to provide the reward can be added here
    }
}
