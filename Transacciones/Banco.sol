// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Banco{
//funcion inicializadora
constructor ()payable{// payable funcion de salida

}
//funcion para incrementar el monto,puede recibir dinero
function incrementBalance(uint256 amount)payable public{// payable para aceptar dinero
require(msg.value == amount);//para asegurar que el usuario envia la cantidad de $ necesaria
}
//funcion para sacar el dinero del contrato
function getBalance()public{
    //metodo transfer---address.this es la direccion de éste contrato
   payable(msg.sender).transfer (address(this).balance);//this,balance es el saldo del contrato-,-address es la direccion
   //msg.sender es la cuenta a enviar dinero quien invoca la funcion,incluye datos del que quiere hacer la transferencia
}
}