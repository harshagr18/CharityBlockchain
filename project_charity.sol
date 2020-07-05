pragma solidity ^0.5.3;


contract charity_contract{


    /*
    bytes32 public hash_byt;
    string public name1;
    string public bankAccount;
    string public bankName;
    */


struct  charity_structure {
   string  name_of_charity;
   string bankAccount;
   string bankName;
   bytes32 addres;

}

charity_structure[10] public cs ;
uint index_charity = 0;

struct personOrOrganisation_structure {
    string name_of_organisation;
    string bankAccount;
    string bankName;
    bytes32 addres;

}

personOrOrganisation_structure[10] public ps;
uint index_organisation = 0;

function generate_address_charity(string memory name, string memory bankacc , string memory bankname) private returns(bytes32) {

    bytes memory _name = bytes(name);
    bytes memory _bankacc = bytes(bankacc);
    bytes memory _bankname = bytes(bankname);
    string memory length_abc = new string(_name.length + _bankacc.length + _bankname.length);
    bytes memory hash_address = bytes(length_abc);
    uint k = 0;
    for(uint i = 0;i < _name.length; i++){
        hash_address[k++] = _name[i];
    }
    for(uint i = 0; i < _bankacc.length; i++){
        hash_address[k++] = _bankacc[i];
    }
    for(uint i = 0; i < _bankname.length; i++){
        hash_address[k++] = _bankname[i];
    }
   bytes32 hash = keccak256(hash_address);
    return hash;


}

function generate_address_organisation(string memory name, string memory bankacc , string memory bankname) private returns(bytes32) {

    bytes memory _name = bytes(name);
    bytes memory _bankacc = bytes(bankacc);
    bytes memory _bankname = bytes(bankname);
    string memory length_abc = new string(_name.length + _bankacc.length + _bankname.length);
    bytes memory hash_address = bytes(length_abc);
    uint k = 0;
    for(uint i = 0;i < _name.length; i++){
        hash_address[k++] = _name[i];
    }
    for(uint i = 0; i < _bankacc.length; i++){
        hash_address[k++] = _bankacc[i];
    }
    for(uint i = 0; i < _bankname.length; i++){
        hash_address[k++] = _bankname[i];
    }
   bytes32 hash = keccak256(hash_address);
    return hash;


}

function add_charity(string memory name, string memory bankacc , string memory bankname) public returns(string memory status){

    bytes32 hash = generate_address_charity(name,bankacc,bankname);
    cs[index_charity].addres = hash;
    cs[index_charity].name_of_charity = name;
    cs[index_charity].bankAccount = bankacc;
    cs[index_charity].bankName = bankname;

    /*
    hash_byt = hash;
    bankName = bankname;
    name1 = name;
    bankAccount = bankacc;
    */

    index_charity++;

    return("succesfully added the charity!!");

}

function add_organisation(string memory name, string memory bankacc , string memory bankname) public returns(string memory status){

    bytes32 hash = generate_address_organisation(name,bankacc,bankname);
    ps[index_organisation].addres = hash;
    ps[index_organisation].name_of_organisation = name;
    ps[index_organisation].bankAccount = bankacc;
    ps[index_organisation].bankName = bankname;

    /*
    hash_byt = hash;
    bankName = bankname;
    name1 = name;
    bankAccount = bankacc;
    */

    index_organisation++;

    return("succesfully added the organisation!!");

}

//function transact_organisation_to_charity()


}
