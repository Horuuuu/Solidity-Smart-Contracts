// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Coches{
    address owner;
    uint256 precio;
    uint256[]identificadores;//array
    mapping(address => Coche)coches;//clave:address , valor :Coche struck(---)nombre del mapeo
    struct Coche{//objeto con props
    uint256 identificador;
    string marca;
    uint32 caballos;
    uint32 kilometros;

    }
    modifier precioFiltro(uint256 _precio){
        require(_precio == precio);//condicion del modifier
        _;//ejecucucion sí cumple la condicion
    }
    constructor(uint256 _precio){
        owner= msg.sender;//señaliza al dueño en nuestra direccion
        precio=_precio;
    }
    //(se le pasa los parametros del objeto coche) y tambien el modifier con el valor del coche como prop y payable para la transaccion
    function addCoche(uint256 _id,string memory _marca , uint32 _caballos , uint32 _kilometros)public precioFiltro(msg.value)payable{
        identificadores.push(_id);//se le agrega al array el id
        coches[msg.sender].identificador= _id;//la clave es el valor del ususario que invoca la funcion
        coches[msg.sender].marca= _marca;
        coches[msg.sender].caballos= _caballos;
        coches[msg.sender].kilometros= _kilometros;
    }
    //funcion para saber cuantos coches se registraron(largo del array)
    function getIdentificadores()external view returns(uint256){
        return identificadores.length;//cuantos coches estan registrados
    }
    //para saber la informacion de un coche
    function getCoche()external view returns(string memory marca ,uint32 caballos ,uint32 kilometros){//props a retornar
    marca = coches[msg.sender].marca;
    caballos = coches[msg.sender].caballos;
    kilometros = coches[msg.sender].kilometros;
    

    }
}