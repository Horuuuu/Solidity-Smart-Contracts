// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
//tipo de interfaz
interface MyToken{//metodos de los que vamos a hacer uso ,funciones que necesitamos del contrato del token
    function decimals()external view returns(uint8);//se necesitan porque los tokens no son enteros
    function balanceOf(address _address)external view returns(uint256);//mapping de address a saldo
    function transfer(address _to,uint256 _value)external returns(bool success); // funcion de transferencia  
}
contract TokenSale{
    address owner;//dueño
    uint256 price;//precio del token
    MyToken myTokenContract;//
    uint256 tokenSold;//acumulativo de tokens que esta vendiendo este contrato

event Sold(address buyer,uint256 amount);//evento de compra procesada(direccion del comprador y la cantidad de tokens comprados)
//variables de estado
constructor(uint256 _price,address _addressContract){//_addresscontract direccion de Token
    owner=msg.sender;//dueño quien hace el deploy
    price=_price;
    //se comunican el contrato del token y este a travez de metodo 
    myTokenContract=MyToken(_addressContract);//se le pasa como parametro la direccion donde esta deployado el contrato del dueño
}
//funcion de seguridad,para multiplicar
function mul(uint256 a,uint256 b)internal pure returns(uint256){
    if(a=0){
        return 0;
    }
    uint256 c = a*b;
    require(c/a ==b);
    return c;
}
//funcion de comprar
function buy(uint256 _numTokens)public payable{//numero de tokens que se quiere comprar
    require(msg.value==mul(price,_numTokens));//dinero abonado coincida con el precio multiplicado por el numero de tokens que quiere comprar
    uint256 scaledAmount=mul(_numTokens,uint256(10)**myTokenContract.decimals());//pasar los decimales
    require(myTokenContract.balanceOf(address(this)) >= scaledAmount);//por lo menos tenga los tokens reueridos por el comprador
    tokenSold += _numTokens;//tokensold lleva la cuenta de tokens vendidos y se le suma los recien comprados
    require(myTokenContract.transfer(msg.sender,scaledAmount));//para asegurar que retorna un true
    emit Sold(msg.sender,_numTokens);//comprador llama funcion y envia cantidad de tokens
}
//funcion para dar de baja el contrato
function endSold()public{
    require(msg.sender==owner);
    require(myTokenContract.transfer( owner,myTokenContract.balanceOf(address(this))));//los tokens no vendidos vuelven al dueño
    msg.sender.transfer(address(this).balanceOf);
}
}