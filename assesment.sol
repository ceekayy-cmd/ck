pragma solidity ^0.8.13;

contract LocalStore {
    struct Product {
        uint id;
        string name;
        uint price;
        uint stock;
    }

    mapping(uint => Product) public products;
    uint public productCount;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    event ProductAdded(uint id, string name, uint price, uint stock);
    event ProductPurchased(uint id, uint quantity, address buyer);

    constructor() {
        owner = msg.sender;
    }

    function addProduct(string memory _name, uint _price, uint _stock) public onlyOwner {
        require(bytes(_name).length > 0, "Product name required");
        require(_price > 0, "Product price must be greater than 0");
        require(_stock > 0, "Product stock must be greater than 0");

        productCount++;
        products[productCount] = Product(productCount, _name, _price, _stock);

        emit ProductAdded(productCount, _name, _price, _stock);
    }

    function purchaseProduct(uint _id, uint _quantity) public payable {
        Product storage product = products[_id];
        require(product.id != 0, "Product does not exist");
        require(product.stock >= _quantity, "Not enough stock available");
        require(msg.value >= product.price * _quantity, "Not enough ether sent");

        if (product.stock < _quantity) {
            revert("Not enough stock available");
        }
        if (msg.value < product.price * _quantity) {
            revert("Not enough ether sent");
        }

        product.stock -= _quantity;
        payable(owner).transfer(msg.value);
        emit ProductPurchased(_id, _quantity, msg.sender);
    }

    function getProduct(uint _id) public view returns (string memory, uint, uint) {
        Product memory product = products[_id];
        require(product.id != 0, "Product does not exist");
        return (product.name, product.price, product.stock);
    }

    function withdrawFunds(uint _amount) public onlyOwner {
        uint balance = address(this).balance;
        assert(balance >= _amount);
        require(_amount <= balance, "Insufficient balance");
        payable(owner).transfer(_amount);
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}
