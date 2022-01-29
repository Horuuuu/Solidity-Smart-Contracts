pragma solidity ^0.4.18;

contract Coursetro {
    string fName;
    uint256 age;
    //EVENTO que despues se llama con los valores
    event Instructor(string name, uint256 age);

    function setInstructor(string _fName, uint256 _age) public {
        fName = _fName;
        age = _age;
        Instructor(_fName, _age);//llama evento con propiedades    

    function getInstructor() public view returns (string, uint256) {
        return (fName, age);
    }
}
