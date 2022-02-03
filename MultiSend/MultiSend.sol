// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MultipleWithdraw{
    address private owner;//dueño del contrato

    modifier isOwner(){//filtra si es el dueño del contrato
    require(msg.sender == owner,"NO ESTAS AUTORIZADO");
    _;//cede la ejecucion al cuerpo de la funcion
    }
    constructor(){
        owner=msg.sender;//dueño es igual al que deploya el contrato
    }
    //funcion para hacer multiples transacciones------los arrays se llaman adresses y amounts--------isOwner es el modifier
    function multipleWithdraw(address payable[]memory addresses,uint256[]memory amounts)public payable isOwner{//array de direcciones de destino
    require(addresses.length==amounts.length,"LA LONGITUD DE LOS DOS ARRAY DEBE SER IGUAL");
    uint256 totalAmounts=0;
    for ( uint256 i = 0; i < amounts.length; i++){
        totalAmounts += amounts[i] * 1 wei;//se le agrega al array las diferentes cantidades
    }//al final del bucle tenes todo el saldo
    require(totalAmounts == msg.value,"EL VALOR NO COINCIDE");

    for( uint256 i = 0; i < addresses.length; i++){
        uint256 receiverAmount = amounts[i] * 1 wei;
        //adresses [n° de cuenta].metodo de solidity(monto que le coresponde a cada cliente)
        addresses[i].transfer(receiverAmount);//envia al objeto de la direccion a enviar 1,2,3,etc |||| prop de solidity transfer
    }
    }
}