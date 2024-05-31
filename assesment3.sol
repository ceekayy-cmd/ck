// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CkToken is ERC20, Ownable {

    mapping(address => bool) private allowedAddresses;

    constructor() ERC20("CkToken", "CKR") Ownable(msg.sender) {
        _mint(msg.sender, 1000 * 10 ** decimals()); // Initial mint
        allowedAddresses[msg.sender] = true; // Owner is initially allowed
    }

    modifier onlyAllowed() {
        require(allowedAddresses[msg.sender], "You are not allowed to perform this action");
        _;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyAllowed {
        require(from == msg.sender || allowance(from, msg.sender) >= amount, "Not allowed to burn tokens");
        _burn(from, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        if (sender != msg.sender) {
            _spendAllowance(sender, msg.sender, amount);
        }
        _transfer(sender, recipient, amount);
        return true;
    }

    function addAllowedAddress(address addr) public onlyOwner {
        allowedAddresses[addr] = true;
    }

    function removeAllowedAddress(address addr) public onlyOwner {
        allowedAddresses[addr] = false;
    }

    function isAllowedAddress(address addr) public view returns (bool) {
        return allowedAddresses[addr];
    }
}

