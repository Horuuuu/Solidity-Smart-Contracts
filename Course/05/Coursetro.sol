pragma solidity ^0.4.18;

contract Coursetro {
    string fName;
    uint256 age;
    address owner; //direccion de etherum

    function Coursetro() public {
        //envia msg una vez cargado el contrato
        owner = msg.sender; //msj se envia a Owner
    }

    //funcion modifier
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    event Instructor(string name, uint256 age);

    function setInstructor(string _fName, uint256 _age) public onlyOwner {
        fName = _fName;
        age = _age;
        Instructor(_fName, _age);
    }

    function getInstructor() public view returns (string, uint256) {
        return (fName, age);
    }
}
