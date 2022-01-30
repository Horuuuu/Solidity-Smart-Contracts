// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Banco{
    //variable de estado Global
address owner;//dueño del contrato

//requerimentos a travez de modificadores
modifier onlyOwner{
require(msg.sender==owner);//sí el sender es igual al dueño del contrato 
_;//si es true se ejecuta las instrucciones de la funcion linea 34
}
//funcion para cambiar al dueño del contrato
function newOwner(address _newOwner)public onlyOwner{
owner=_newOwner;
}
//para saber quien es el dueño del contrato
function getOwner()view public returns(address){
return owner;
}
//obtener el saldo del contrato
function getBalance()view public returns(uint256){
    return address(this).balance;
}
//funcion inicializadora
constructor ()payable{
    owner=msg.sender;//quien hace el deploy del contrato se guarda en owner
}//msg incluye props de transaccion

function incrementBalance(uint256 amount)payable public{
require(msg.value == amount);
}
function withdrawBalance()public onlyOwner{     
   payable(msg.sender).transfer (address(this).balance);//hace liquidacion del contrato
}


}