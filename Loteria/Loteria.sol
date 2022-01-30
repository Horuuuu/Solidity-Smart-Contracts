// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Loteria{//variables de estado
    address internal owner;
    uint256 internal num;
    uint256 public numGanador;
    uint256 public precio;
    bool public juego;
    address public ganador;

    constructor(uint256 _numeroGanador,uint256 _precio) payable{//numero ganador y precio  para participar del juego
        owner=msg.sender;//nos
        num=0;//numero inicial 
        numGanador=_numeroGanador;
        precio=_precio;//precio por jugar
        juego=true;//juego activo
    }
    function comprobarAcierto(uint256 _num)private view returns(bool){
        if(_num==numGanador){//si el numero aleatorio es igual al de la variable de estado
            return true;
        }else{
            return false;
        }
    }
    //numero pseudoaleatorio
    function numeroRandom()private view returns(uint256){
        //retorna a travez de Keccak256 (con los parametros )
        return uint256(keccak256(abi.encode(block.timestamp,msg.sender,num)))%10;//al hash lo convierte en numero entero y toma el ultimo digito
    }
    //funcio externa que  llaman  los participantes
    function participar()external payable returns(bool resultado ,uint256 numero){//retorna sí gano o no y el numero aleateorio
        require(juego==true);//condicion que el juego esté activo
        require(msg.value==precio);//que el participante esté pagando el precio por participar
        uint256 numUsuario=numeroRandom();
        bool acierto=comprobarAcierto(numUsuario);
        if(acierto=true){
            juego=false;//juego terminado
            payable(msg.sender).transfer(address(this).balance - (num * (precio/2)));//se transfiere la mitad al dueño del contrato y la otra al participante ganador
            ganador=msg.sender;
            resultado=true;//true porque ganó
            numero=numUsuario;
        }else{//sino hay ganador
            num ++;//se suma uno a num y cambia en la funcion numeroRandom el hash
            resultado=false;//el juego continua
            numero=numUsuario;
        }
    }
    //funcion que va actualizando el balance y lo muestra
    function verPremio()public view returns(uint256){
        return address(this).balance -(num*(precio/2));
    }
    function retirarFondosContrato()external returns(uint256){
        require(msg.sender==owner);//requqerir ser los dueños del contrato
        require(juego==false);//tambien que el juego este terminado
        payable (msg.sender).transfer(address(this).balance);//se nos envia la  mitad del premio
        return address(this).balance;//retorna la cantidad menos la mitad

    }
}