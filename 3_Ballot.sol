// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Ballot
 * @dev Implementa el proceso de votación junto con la delegación de votos.
 
 */
contract Ballot {
   
    struct Voter {
        uint weight; // el peso se acumula por delegación
        bool voted;  // si es cierto esa persona ya votó
        address delegate; // persona delegada en
        uint vote;   // índice de la propuesta votada
    }

    struct Proposal {
        //  Si puede limitar la longitud a un cierto número de bytes,
        // siempre use uno de bytes1 a bytes32 porque son mucho más baratos
        bytes32 name;   // nombre corto (hasta 32 bytes)
        uint voteCount; // número de votos acumulados
    }

    address public chairperson;

    mapping(address => Voter) public voters;

    Proposal[] public proposals;

    /** 
     * @dev Cree una nueva boleta para elegir una de 'proposalNames'.
     * @param proposalNames nombres de propuestas
     */
    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for (uint i = 0; i < proposalNames.length; i++) {
            // 'Proposal ({...})' crea una temporal
            // Objeto de propuesta y 'proposals.push(...)'
            // lo añade al final de 'propuestas'.
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }
    
    /** 
     * @dev Otorgue al 'votante' el derecho a votar en esta boleta. Solo puede ser convocado por el 'presidente'.
     * @param voter address of voter
     */
    function giveRightToVote(address voter) public {
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote."
        );
        require(
            !voters[voter].voted,
            "The voter already voted."
        );
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }

    /**
     * @dev Delega tu voto a la votante 'a'.
     * @param a la dirección en la que se delega el voto
     */
    function delegate(address to) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "You already voted.");
        require(to != msg.sender, "Self-delegation is disallowed.");

        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;

            // Encontramos un bucle en la delegación, no permitido.
            require(to != msg.sender, "Found loop in delegation.");
        }
        sender.voted = true;
        sender.delegate = to;
        Voter storage delegate_ = voters[to];
        if (delegate_.voted) {
            // If the delegate already voted,
            // directly add to the number of votes
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            // If the delegate did not vote yet,
            // add to her weight.
            delegate_.weight += sender.weight;
        }
    }

    /**
     * @dev Dé su voto (incluidos los votos que le hayan sido delegados) para proposal 'proposals[proposal].name'.
     * @param índice de propuesta de propuesta en la matriz de propuestas
     */
    function vote(uint proposal) public {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote");
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.vote = proposal;

        // If 'proposal' is out of the range of the array,
        //esto se lanzará automáticamente y revertirá todo
        // cambios.
        proposals[proposal].voteCount += sender.weight;
    }

    /** 
     * @dev Calcula la propuesta ganadora teniendo en cuenta todos los votos anteriores.
     * @return winningProposal_ index of winning proposal in the proposals array
     */
    function winningProposal() public view
            returns (uint winningProposal_)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    /** 
     * @dev Calls winningProposal() function to get the index of the winner contained in the proposals array and then
     * @return winnerName_ the name of the winner
     */
    function winnerName() public view
            returns (bytes32 winnerName_)
    {
        winnerName_ = proposals[winningProposal()].name;
    }
}
