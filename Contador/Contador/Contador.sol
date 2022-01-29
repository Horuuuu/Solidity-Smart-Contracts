// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Contador {
    uint256 count;//uint es un entero sin signo
//funcion inicializadora de estado
 constructor(uint256 _count){//funcion que se llama una vez
count = _count; //se asigna a la variable de estado de arriba las props del constructor
    }
    //funcion que cambia el estado
    function setCount(uint _count)public{
        count = _count;
    }
    //funcion para incrementar el contador
    function IncrementCount()public{
        count ++;
    }
    //funcion para obtener
    function getCount()public view returns(uint256){//returns dice que tipo de dato va a retorna abajo return
        return count;
    }
    
    function getNumber()public pure returns(uint256){//pure no escribe ni lee el contrato
        return 34;
    }
}