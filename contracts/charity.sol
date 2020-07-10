pragma solidity ^ 0.5.0;
contract charity {

  uint public charity_count = 0;


  uint public org_count = 0;

  struct charity_structre {
    string name;
    string description;
    string bankAccount;
    string bankName;
    uint id;
    bytes32 hash;
    string address_of_charity;
    string  ether_coins;


  }

  struct personOrOrganisation_structure {

    string name;
    string bankAccount;
    string bankName;
    uint id;
    bytes32 hash;
    string address_of_organisation;
    string ether_coins;



  }

  constructor() public {

      createCharity("anand_charity", "welcome to anand's charity, this is a default charity as I created this web page","bankacc","bankname","0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c","0000");

      createOrganisation("anand_organisation","bank account","bank name","0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c","0000");
  }

  mapping(uint => charity_structre) public charitys;


  mapping(uint => personOrOrganisation_structure) public org;

  struct transactions {

    string address_of_charity;
    string address_of_organisation;
    string amount_sent;
    uint id;

  }

  uint public transaction_count = 0;

  mapping(uint => transactions) public transaction_dict;




  function createCharity(string memory _name, string memory _description, string memory _bankacc, string memory _bankname, string memory _address, string memory _ether_coins) public returns(uint){

      charity_count++;
      //uint newEther_coins  =  uint(_ether_coins);
      bytes memory name_byte = bytes(_name);
      bytes memory description_byte = bytes(_description);
      bytes memory bankacc_byte = bytes(_bankacc);
      bytes memory bankname_byte = bytes(_bankname);
      //string memory newStr = string(_address);
      bytes memory address_byte = bytes(_address);
      string memory lengthabc = new string(name_byte.length + description_byte.length + bankacc_byte.length + bankname_byte.length + address_byte.length);
      bytes memory hash = bytes(lengthabc);
      uint k = 0;
      for(uint i =0;i < name_byte.length; i++){
          hash[k] = name_byte[i];
          k++;
      }
      for(uint i = 0;i < description_byte.length;i++){
          hash[k] = description_byte[i];
          k++;
      }
      for(uint i = 0;i < bankacc_byte.length;i++){
          hash[k] = bankacc_byte[i];
          k++;
      }
      for(uint i = 0;i < bankname_byte.length;i++){
          hash[k] = bankname_byte[i];
          k++;
      }

      for(uint i = 0;i < address_byte.length; i++ ){

          hash[k] = address_byte[i];
          k++;
      }


      bytes32 hash_address = keccak256(hash);
      //charitys[charity_count] = charity_structre(_name,_description,_bankacc,_bankname,charity_count,hash_address,_address);

      charitys[charity_count].name = _name;
      charitys[charity_count].description = _description;
      charitys[charity_count].bankAccount = _bankacc;
      charitys[charity_count].bankName = _bankname;
      charitys[charity_count].id = charity_count;
      charitys[charity_count].hash = hash_address;
      charitys[charity_count].address_of_charity = _address;
      charitys[charity_count].ether_coins = _ether_coins;
      //emit charityCreated(_name,_description,_bankacc,_bankname,charity_count,hash_address,_address);

      return(charity_count);


  }


  function createOrganisation(string memory _name, string memory _bankacc, string memory _bankname, string memory _address, string memory _ether_coins) public returns(uint){

    org_count ++;

    bytes memory name_byte = bytes(_name);
    bytes memory acc_byte = bytes(_bankacc);
    bytes memory bankname_byte = bytes(_bankname);
    bytes memory address_byte = bytes(_address);
    string memory lengthabc = new string(name_byte.length + acc_byte.length + bankname_byte.length + address_byte.length );
    bytes memory hash = bytes(lengthabc);

    uint k = 0;

    for(uint i = 0; i < name_byte.length;i++) {

      hash[k] = name_byte[i];
      k++;
    }

    for(uint i = 0; i < acc_byte.length; i++){

      hash[k] = acc_byte[i];
      k++;

    }


    for(uint i = 0; i < bankname_byte.length; i++) {

      hash[k] = bankname_byte[i];
      k++;
    }


    for(uint i = 0;i < address_byte.length; i++) {

      hash[k] = address_byte[i];
      k++;

    }



    bytes32 hash_address = keccak256(hash);

    //org[org_count] = personOrOrganisation_structure(_name,_bankacc,_bankname,org_count,hash_address,_address);


    org[org_count].name = _name;
    org[org_count].bankAccount = _bankacc;
    org[org_count].bankName = _bankname;
    org[org_count].id = org_count;
    org[org_count].hash = hash_address;
    org[org_count].address_of_organisation = _address;
    org[org_count].ether_coins = _ether_coins;

    //emit organisationCreated(_name,_bankacc,_bankname,org_count,hash_address,_address);

    return org_count;


  }


/*
  function parseAddr(string memory _a) public returns (address _parsedAddress) {
    bytes memory tmp = bytes(_a);
    uint160 iaddr = 0;
    uint160 b1;
    uint160 b2;
    for (uint i = 2; i < 2 + 2 * 20; i += 2) {
        iaddr *= 256;
        b1 = uint160(uint8(tmp[i]));
        b2 = uint160(uint8(tmp[i + 1]));
        if ((b1 >= 97) && (b1 <= 102)) {
            b1 -= 87;
        } else if ((b1 >= 65) && (b1 <= 70)) {
            b1 -= 55;
        } else if ((b1 >= 48) && (b1 <= 57)) {
            b1 -= 48;
        }
        if ((b2 >= 97) && (b2 <= 102)) {
            b2 -= 87;
        } else if ((b2 >= 65) && (b2 <= 70)) {
            b2 -= 55;
        } else if ((b2 >= 48) && (b2 <= 57)) {
            b2 -= 48;
        }
        iaddr += (b1 * 16 + b2);
    }
    return address(iaddr);
}
*/




function createTransaction(string memory add_of_charity,string memory add_of_org,string memory amount) public {

    transaction_count++;
    transaction_dict[transaction_count].address_of_charity = add_of_charity;
    transaction_dict[transaction_count].address_of_organisation = add_of_org;
    transaction_dict[transaction_count].amount_sent = amount;
    transaction_dict[transaction_count].id = transaction_count;

}


}

/*
event charityCreated(

  string name,
  string description,
  string bankacc,
  string bankname,
  uint id,
  bytes32 hash,
  address address_of_charity

);


event organisationCreated(


  string name,
  string bankacc,
  string bankname,
  uint id,
  bytes32 hash,
  string address_of_organisation
);
*/
