pragma solidity ^0.8.13;

contract ErrorManagement {

    function validateInput(uint value) public pure {
        require(value > 10, "Value must be greater than 10");
    }

    function verifyCondition(uint value) public pure {
        if (value <= 10) {
            revert("Value must be greater than 10");
        }
    }

    uint public count;

    function checkInvariant() public view {
        assert(count == 0);
    }

    error LowBalance(uint availableBalance, uint requestedAmount);

    function checkBalance(uint withdrawAmount) public view {
        uint balance = address(this).balance;
        if (balance < withdrawAmount) {
            revert LowBalance({availableBalance: balance, requestedAmount: withdrawAmount});
        }
    }
}
