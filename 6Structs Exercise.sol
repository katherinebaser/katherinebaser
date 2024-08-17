// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GarageManager {
		string private salt = "ваша строка тут"; 
    struct Car {
        string make;
        string model;
        string color;
        uint numberOfDoors;
    }

    mapping(address => Car[]) public garage;

    event CarAdded(address indexed owner, string make, string model, string color, uint numberOfDoors);
    event CarUpdated(address indexed owner, uint indexed index, string make, string model, string color, uint numberOfDoors);
    event GarageReset(address indexed owner);

    function addCar(string memory _make, string memory _model, string memory _color, uint _numberOfDoors) public {
        Car memory newCar = Car(_make, _model, _color, _numberOfDoors);
        garage[msg.sender].push(newCar);
        emit CarAdded(msg.sender, _make, _model, _color, _numberOfDoors);
    }

    function getMyCars() public view returns (Car[] memory) {
        return garage[msg.sender];
    }

    function getUserCars(address _user) public view returns (Car[] memory) {
        return garage[_user];
    }

    function updateCar(uint _index, string memory _make, string memory _model, string memory _color, uint _numberOfDoors) public {
        require(_index < garage[msg.sender].length, "BadCarIndex");
        garage[msg.sender][_index] = Car(_make, _model, _color, _numberOfDoors);
        emit CarUpdated(msg.sender, _index, _make, _model, _color, _numberOfDoors);
    }

    function resetMyGarage() public {
        delete garage[msg.sender];
        emit GarageReset(msg.sender);
    }
}