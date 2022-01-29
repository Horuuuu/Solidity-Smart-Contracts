pragma solidity ^0.4.18;

contract Courses {
    struct Instructor {
        uint256 age; //props
        string fName;
        string lName;
    }
    //mapping dos argumentos 1°tipo lo une al  2° struck
    mapping(address => Instructor) instructors; //instructor el struck declarado arriba
    address[] public instructorAccts;

    function setInstructor(
        address _address,
        uint256 _age,
        string _fName,
        string _lName
    ) public {
        var instructor = instructors[_address];

        instructor.age = _age;
        instructor.fName = _fName;
        instructor.lName = _lName;

        instructorAccts.push(_address) - 1;
    }

    function getInstructors() public view returns (address[]) {
        return instructorAccts;
    }

    function getInstructor(address _address)
        public
        view
        returns (
            uint256,
            string,
            string
        )
    {
        return (
            instructors[_address].age,
            instructors[_address].fName,
            instructors[_address].lName
        );
    }

    function countInstructors() public view returns (uint256) {
        return instructorAccts.length;
    }
}
