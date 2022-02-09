pragma solidity 0.5.1;

contract MyContract {//lista enumerada
    enum State { Waiting, Ready, Active }//lista de estados del contrato
    State public state;

    constructor() public {
        state = State.Waiting;//estado predeterminado o inicial
    }

    function activate() public {
        state = State.Active;//actualiza el estado a active
    }
    //funcion para verificar el estado
    function isActive() public view returns(bool) {
        return state == State.Active;
    }
}