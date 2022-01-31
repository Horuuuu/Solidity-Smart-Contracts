// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MyToken {
    string public name; //nombre del token
    string public symbol; //simbolo del token
    uint8 public decimals; //decimales que tiene el criptotoken
    uint256 public totalSupply; //cantidad de tokens totales generados
    //mapping lleva relaciones de diferentes direcciones con saldos
    mapping(address => uint256) public balanceOf; //para conoce la cantidad de tokens disponibles
    //el segundo address es la cuenta de quien autorizo y uint es la cantidad de tokens que puede gestionar
    mapping(address => mapping(address => uint256)) public allowance; //autorizacion

    constructor() {
        name = "MyCoin";
        symbol = "MY";
        decimals = 18;
        totalSupply = 10000000 * (uint256(10)**decimals); //10000000 * 18
        balanceOf[msg.sender] = totalSupply; //quien hace el deploy es el dueño de la totalidad de los tokens
    }

    //declaracion del evento
    event Transfer(address indexed _from, address indexed _to, uint256 _value); //parametros del evento
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    //funcion para transferir tokens de una address a otra
    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(balanceOf[msg.sender] >= _value); //la address tiene que tener como minimo el valor o monto a transferir
        balanceOf[msg.sender] -= _value; //le quita el valor de la transaccion,que arriba se comprobó que posee
        balanceOf[_to] += _value; //se le suma al destinatario el monto trasferido
        //llamada del evento
        emit Transfer(msg.sender, _to, _value); //envia del mensajero(owner) al to y el valor como props
        return true;
    }

    //funcion para que otra persona pueda gestionar mis tokens,solo se autoriza
    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        //spender es la persona a la que autorizo que maneje mis
        //tokens y value es la cantidad que puede manejar
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value); //emite evento de aprobacion
        return true;
    }

    //funcion de transferencia de mis tokens a otro para que los gestione
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(balanceOf[_from] >= _value); //para comprobar que el dueño tiene los fondos
        require(allowance[_from][msg.sender] >= _value); //para comprobar que el que ejecuta ésta funcion está autorizado a manejar los tokens
        balanceOf[_from] -= _value; //se le resta al dueño
        balanceOf[_to] += _value; //se le suma al destinaario el valor
        allowance[_from][msg.sender] -= _value; //para quitarle autorizacion luego de la unica vez
        emit Transfer(_from, _to, _value);
        return true;
    }
}
