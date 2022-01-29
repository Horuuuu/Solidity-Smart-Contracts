//version
pragma solidity ^0.4.18;

contract Coursetro {
    string fName;
    uint256 age;

    //variable que cambia el estado del nombre y edad
    //name y age son parametros del estado inicial
    function setInstructor(string _fName, uint256 _age) public {
        fName = _fName; //guarda los parametros en variables
        age = _age;
    }

    //variable que retorna u string y numeros positivos con returns
    function getInstructor() public view returns (string, uint256) {
        return (fName, age); //para luego retornar las variables de arriba
    }
}
