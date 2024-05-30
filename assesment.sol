
pragma solidity ^0.8.0;

contract DecentralizedLottery {
    address public admin;
    address[] public players;
    uint public ticketPrice;
    bool public lotteryEnded;
    address public winner;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier lotteryActive() {
        require(!lotteryEnded, "Lottery has already ended");
        _;
    }

    constructor(uint _ticketPrice) {
        admin = msg.sender;
        ticketPrice = _ticketPrice;
        lotteryEnded = false;
    }

    function buyTicket() public payable lotteryActive {
        require(msg.value == ticketPrice, "Incorrect ticket price");
        players.push(msg.sender);
    }

    function endLottery() public onlyAdmin lotteryActive {
        require(players.length > 0, "No players in the lottery");
        lotteryEnded = true;
        selectWinner();
    }

    function selectWinner() private {
        uint index = random() % players.length;
        winner = players[index];
        payable(winner).transfer(address(this).balance);
        assert(address(this).balance == 0); // Ensure all funds have been transferred
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }

    function getPlayers() public view returns (address[] memory) {
        return players;
    }
}
