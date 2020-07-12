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

      createTransaction("0x9E4Fe77bbA33b9a8597e65F88AC40D85b45D2D5E","0x0863b46e51b958E9eFf366CcDc1E8f1e50915c85","1");

      blockchain_function();
  }

  mapping(uint => charity_structre) public charitys;


  mapping(uint => personOrOrganisation_structure) public org;

  struct transactions {

    string address_of_charity;
    string address_of_organisation;
    string amount_sent;
    uint id;
    bytes32 transaction_hash;

  }

  uint public transaction_count = 0;

  mapping(uint => transactions) public transaction_dict;


  uint public blockchain_count = 0;

  struct blockchain_structure {

      uint nonce;
      bytes data;
      bytes32 transaction_hash_add;
      uint blockNumber;
      bytes32 hash;
      bytes32 previous_hash;
  }

  mapping(uint => blockchain_structure) public Blockchain;

  bytes32 previousHash;

  function createCharity(string memory _name, string memory _description, string memory _bankacc, string memory _bankname, string memory _address, string memory _ether_coins) public returns(uint){

      charity_count++;
      bytes memory name_byte = bytes(_name);
      bytes memory description_byte = bytes(_description);
      bytes memory bankacc_byte = bytes(_bankacc);
      bytes memory bankname_byte = bytes(_bankname);
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

    org[org_count].name = _name;
    org[org_count].bankAccount = _bankacc;
    org[org_count].bankName = _bankname;
    org[org_count].id = org_count;
    org[org_count].hash = hash_address;
    org[org_count].address_of_organisation = _address;
    org[org_count].ether_coins = _ether_coins;
    return org_count;


  }

function createTransaction(string memory add_of_charity,string memory add_of_org,string memory amount) public {

    transaction_count++;



    bytes memory _address_of_charity = bytes(add_of_charity);
    bytes memory _address_of_organisation = bytes(add_of_org);
    bytes memory _amount = bytes(amount);

    string memory length_abc = new string(_address_of_charity.length + _address_of_organisation.length + _amount.length);
    bytes memory hash = bytes(length_abc);

    uint k = 0;
    for(uint i = 0; i < _address_of_charity.length; i++) {

      hash[k++] = _address_of_charity[i];

    }

    for(uint i = 0; i < _address_of_organisation.length; i++) {

      hash[k++] = _address_of_organisation[i];

    }

    for(uint i = 0; i < _amount.length; i++) {

      hash[k++] = _amount[i];

    }

    bytes32 hash_address = keccak256(hash);
    transaction_dict[transaction_count].address_of_charity = add_of_charity;
    transaction_dict[transaction_count].address_of_organisation = add_of_org;
    transaction_dict[transaction_count].amount_sent = amount;
    transaction_dict[transaction_count].id = transaction_count;
    transaction_dict[transaction_count].transaction_hash = hash_address;



}
/*
function substring(string str, uint startIndex, uint endIndex) public returns (string) {
    bytes memory strBytes = bytes(str);
    bytes memory result = new bytes(endIndex-startIndex);
    for(uint i = startIndex; i < endIndex; i++) {
        result[i-startIndex] = strBytes[i];
    }
    return string(result);
}
*/
function blockchain_function() public {



    blockchain_count++;
    uint len = 0;
    for(uint i = 1;i<=charity_count;i++){
        bytes memory name_charity = bytes(charitys[i].name);
        bytes memory description = bytes(charitys[i].description);
        bytes memory bankacc = bytes(charitys[i].bankAccount);
        bytes memory bankname = bytes(charitys[i].bankName);
        bytes memory add_of_charity_byte = bytes(charitys[i].address_of_charity);
        bytes memory amount_byte = bytes(charitys[i].ether_coins);
        len += name_charity.length + description.length + bankacc.length + bankname.length + add_of_charity_byte.length + amount_byte.length;
    }
    for(uint i =1;i<=org_count;i++){
        bytes memory name_org = bytes(org[i].name);
        bytes memory bankacc_org = bytes(org[i].bankAccount);
        bytes memory bankname_org = bytes(org[i].bankName);
        bytes memory address_of_organisation_byte = bytes(org[i].address_of_organisation);
        bytes memory ether_coins_byte = bytes(org[i].ether_coins);
        len += name_org.length + bankacc_org.length + bankname_org.length + address_of_organisation_byte.length + ether_coins_byte.length;
    }
    string memory lengthabcd = new string(len);

    uint nonceValue = 0;
    bytes memory dataString = bytes(lengthabcd) ;
    bytes32 hash_addressNew;

    uint j = 0;

    for(uint i = 1;i <= charity_count; i++){
      bytes memory name_charity = bytes(charitys[i].name);
      for(uint m=0;m<name_charity.length;m++){
        dataString[j++] = name_charity[m];
      }

      bytes memory description = bytes(charitys[i].description);
      for(uint m=0;m<description.length;m++){
        dataString[j++] = description[m];
      }

      bytes memory bankacc = bytes(charitys[i].bankAccount);
      for(uint m=0;m<bankacc.length;m++){
        dataString[j++] = bankacc[m];
      }

      bytes memory bankname = bytes(charitys[i].bankName);
      for(uint m=0;m<bankname.length;m++){
        dataString[j++] = bankname[m];
      }

      bytes memory add_of_charity_byte = bytes(charitys[i].address_of_charity);
      for(uint m=0;m<add_of_charity_byte.length;m++){
        dataString[j++] = add_of_charity_byte[m];
      }


      bytes memory amount_byte = bytes(charitys[i].ether_coins);
      for(uint m=0;m<amount_byte.length;m++){
        dataString[j++] = amount_byte[m];
      }
      }

    for(uint i = 1;i <= org_count; i++){


      bytes memory name_org = bytes(org[i].name);
      for(uint m=0;m<name_org.length;m++){
        dataString[j++] = name_org[m];
      }

      bytes memory bankacc_org = bytes(org[i].bankAccount);
      for(uint m=0;m<bankacc_org.length;m++){
        dataString[j++] = bankacc_org[m];
      }

      bytes memory bankname_org = bytes(org[i].bankName);
      for(uint m=0;m<bankname_org.length;m++){
        dataString[j++] = bankname_org[m];
      }

      bytes memory address_of_organisation_byte = bytes(org[i].address_of_organisation);
      for(uint m=0;m<address_of_organisation_byte.length;m++){
        dataString[j++] = address_of_organisation_byte[m];
      }

      bytes memory ether_coins_byte = bytes(org[i].ether_coins);
      for(uint m=0;m<ether_coins_byte.length;m++){
        dataString[j++] = ether_coins_byte[m];
      }

    }
uint another_len = 0;
bytes memory temp;
bytes memory temp2;
    for(uint i = 1;i<=transaction_count;i++){
      if(i==transaction_count){
          temp = abi.encode(transaction_dict[i].transaction_hash);
          another_len += temp.length;
      }
      else {
          uint z = i+1;
          temp2 = abi.encode(transaction_dict[i].transaction_hash,transaction_dict[z].transaction_hash);
          another_len += temp2.length;
      }
    }

    string memory something = new string(another_len);

    bytes memory hash_total = bytes(something);
    uint l = 0;
    for(uint i = 1; i<=transaction_count;i++) {

       if(i==transaction_count){
          temp = abi.encode(transaction_dict[i].transaction_hash);
          for(uint m=0;m<temp.length;m++){
            hash_total[l++] = temp[m];
          }
       }
       else {
       uint g = i+1;
        temp2 = abi.encode(transaction_dict[i].transaction_hash,transaction_dict[g].transaction_hash);
        for(uint m=0;m<temp2.length;m++){
          hash_total[l++] = temp2[m];
        }
        i++;
       }

    }


    bytes32 transaction_hash_address = keccak256(hash_total);

//for hash calculation....

  string memory lengthabc = new string(dataString.length);
  bytes memory hashNew = bytes(lengthabc);
  uint k =0;
  for(uint i = 0;i<dataString.length;i++){
    hashNew[k++] = dataString[i];
  }
  hash_addressNew = keccak256(hashNew);


    Blockchain[blockchain_count].blockNumber = blockchain_count;
    Blockchain[blockchain_count].data = dataString;
    Blockchain[blockchain_count].hash = hash_addressNew;
    Blockchain[blockchain_count].previous_hash = previousHash;
    Blockchain[blockchain_count].nonce = nonceValue;
    Blockchain[blockchain_count].transaction_hash_add = transaction_hash_address;
    previousHash = hash_addressNew;
    }

}
