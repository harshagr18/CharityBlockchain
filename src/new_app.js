App = {

  loading: false,
  contracts: {},
  value: "",

  load: async() => {

		await App.loadWeb3()
		await App.loadAccount()
		await App.loadContract()
    await App.renderTasks()


		},

    loadWeb3: async () => {
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider
      web3 = new Web3(web3.currentProvider)
      window.alert("connected to Metamask!!!")
    } else {
      window.alert("Please connect to Metamask.")
    }
    // Modern dapp browsers...
    if (window.ethereum) {
      window.web3 = new Web3(ethereum)
      try {
        // Request account access if needed
        await ethereum.enable()




        // Acccounts now exposed
        web3.eth.sendTransaction({/* ... */})
      } catch (error) {
        // User denied account access...
      }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
      App.web3Provider = web3.currentProvider
      window.web3 = new Web3(web3.currentProvider)
      //amount_balance = web3.currentProvider.value;
      // Acccounts always exposed
      web3.eth.sendTransaction({/* ... */})
    }
    // Non-dapp browsers...
    else {
      console.log('Non-Ethereum browser detected. You should consider trying MetaMask!')
    }
  },

  loadAccount: async () => {
    // Set the current blockchain account
    App.account = web3.eth.accounts[0]
  web3.eth.getCoinbase(function(err, org_address) {
  if (err === null) {
  web3.eth.getBalance(App.account, function(err, balance) {
    if (err === null) {
        App.balance = web3.fromWei(balance, "ether")
    }
  });
  }
  });




  },


  loadContract: async () => {
    // Create a JavaScript version of the smart contract
    const charity = await $.getJSON('charity.json')
    App.contracts.charity = TruffleContract(charity)
    App.contracts.charity.setProvider(App.web3Provider)

    // Hydrate the smart contract with values from the blockchain
    App.charity = await App.contracts.charity.deployed()
  },

  renderTasks: async () => {
    // Load the total task count from the blockchain

    const taskCount = await App.charity.charity_count();
    const $taskTemplate = $('.taskTemplate')
    const $charity_str = $('.charity_str')


    const transaction_count = await App.charity.transaction_count();




    const org_count = await App.charity.org_count();
    const $organisation_for_html = $('.organisation_for_html')
    // Render out each task with a new task template




    for (var i = 1 ; i <= org_count ; i++) {
      const orgs = await App.charity.org(i)
      const org_name = orgs[0]
      const org_bankAcc = orgs[1]
      const org_bankName = orgs[2]
      const org_id = orgs[3]
      const org_hash = orgs[4]
      const org_address = orgs[5]
      var j = i-1
      const orgsanother = await App.charity.org(j)
      const org_prev_hash = orgsanother[4]
      const org_balance = orgs[6]
      const $neworganisation_for_html = $organisation_for_html.clone()
      $neworganisation_for_html.find('.content9').html("organisation name : "+org_name)
      $neworganisation_for_html.find('.content10').html("organisation bank account : "+org_bankAcc)
      $neworganisation_for_html.find('.content11').html("organisation bank name : "+org_bankName)
      $neworganisation_for_html.find('.content12').html("organisation id : "+org_id)
      $neworganisation_for_html.find('.content13').html("organisation hash : "+org_hash)
      $neworganisation_for_html.find('.content14').html("organisation previous hash : "+org_prev_hash)
      $neworganisation_for_html.find('.content16').html("organisation address : "+org_address)
      $neworganisation_for_html.show()

      $organisation_for_html.find('.content9').html("organisation name : "+org_name)
      $organisation_for_html.find('.content10').html("organisation bank account : "+org_bankAcc)
      $organisation_for_html.find('.content11').html("organisation bank name : "+org_bankName)
      $organisation_for_html.find('.content12').html("organisation id : "+org_id)
      $organisation_for_html.find('.content13').html("organisation hash : "+org_hash)
      $organisation_for_html.find('.content14').html("organisation previous hash : "+org_prev_hash)
      $organisation_for_html.find('.content16').html("organisation address : "+org_address)
      $organisation_for_html.find('.content19').html("organisation balance : "+org_balance)

    }

    for (var i = 1; i <= taskCount; i++) {
      // Fetch the task data from the blockchain
      const task = await App.charity.charitys(i)
      const charity_name = task[0]
      const charity_desciption = task[1]
      const charity_Account = task[2]
      const charity_bankName = task[3]
      const charity_id = task[4].toNumber()
      const charity_hash = task[5]
      const charity_address = task[6]
      const charity_balance = task[7]
      var j = i-1
      const taskanother = await App.charity.charitys(j)
      const charity_prev_hash = taskanother[5]

      // Create the html for the task
      const $newTaskTemplate = $taskTemplate.clone()
      $newTaskTemplate.find('.content1').html(charity_name)
      $newTaskTemplate.find('.content2').html(charity_desciption)
      $newTaskTemplate.find('.content3').html(charity_Account)
      $newTaskTemplate.find('.content4').html(charity_bankName)
      $newTaskTemplate.find('.content5').html(charity_id)
      $newTaskTemplate.find('.content6').html(charity_hash)
      $newTaskTemplate.find('.content15').html(charity_prev_hash)
                      // .on('click', App.toggleCompleted)
      // Show the task
      $newTaskTemplate.show()

      //$taskTemplate.find('.content1').innerHTML(charity_name)
      $taskTemplate.find('.content1').html("charity name: "+charity_name)
      $taskTemplate.find('.content2').html("charity description: "+charity_desciption)
      $taskTemplate.find('.content3').html("charity bank account: "+charity_Account)
      $taskTemplate.find('.content4').html("charity bank name: "+charity_bankName)
      $taskTemplate.find('.content5').html("charity id: "+charity_id)
      $taskTemplate.find('.content6').html("charity hash: "+charity_hash)
      $taskTemplate.find('.content15').html("charity previous hash: "+charity_prev_hash)
      $taskTemplate.find('.content17').html("charity address: "+charity_address)
      $taskTemplate.find('.content18').html("charity balance: "+charity_balance)


    }



        const transactions = await App.charity.transaction_dict(transaction_count)
        const charity_address_transaction = transactions[0]
        const organisation_address_transaction = transactions[1]
        const amount_123 = transactions[2]
        const id_transaction = transactions[3]
        const transaction_hash1 = transactions[4]
        const $transaction = $('.transaction')
        var hash ;
        window.alert("transaction hash : "+$transaction.find('.content20').val());
        $transaction.find('.content20').html("transaction hash : "+transaction_hash1)
        $transaction.find('.content21').html("charity address : "+charity_address_transaction)
        $transaction.find('.content22').html("organisation address : "+organisation_address_transaction)
        $transaction.find('.content23').html("amount im transaction : "+amount_123)
        $transaction.find('.content24').html("the id : "+id_transaction)

        const $blockchain = $('.blockchain');
        //var bk = $('#mine').val()
        const blockchain_count = await App.charity.blockchain_count();
        const blockchain_structure = await App.charity.Blockchain(blockchain_count);

        const transaction_merkle_root = blockchain_structure[2];
        const blknum = blockchain_structure[3];
        const theHash = blockchain_structure[4];
        const theprevHash = blockchain_structure[5];
        var bk = $('#mine').val()
        $blockchain.find('.content25').html("the transaction merkle root : "+transaction_merkle_root)
        $blockchain.find('.content26').html("the block number : "+blknum)
        $blockchain.find('.content27').html("the hash : "+theHash)
        $blockchain.find('.content28').html("the previous hash : "+theprevHash)


  },

  createCharity: async () => {
		var charity_name = $('#charity_name').val()
		var description = $('#charity_desciption').val()
    var bankAccount = $('#charity_Account').val()
    var bankName = $('#charity_bankName').val()
    var address = App.account
    var balance = App.balance
    var _str = balance + " ETH"
		await App.charity.createCharity(charity_name,description,bankAccount,bankName,address,_str)
		window.location.reload()
	},


  createTransaction: async () => {

    var address_of_charity = $('#add_of_charity').val()
    var address_of_organisation = $('#add_of_org').val()
    var amountToSend = $('#amount').val()
    const $transaction = $('.transaction')

    web3.eth.sendTransaction({
      "from":address_of_organisation,
      "to": address_of_charity,
      "value": amountToSend
    },function find_hash(error, result){
       if(error){
         console.log( "Transaction error" ,error);
       }
       else{
         console.log(result)
         window.alert("transaction hash : "+result);
         }
         return result;
    });


    await App.charity.createTransaction(address_of_charity,address_of_organisation,amountToSend)
    window.location.reload()

  },

  createOrganisation: async () => {

    var name = $('#organisation_name').val()
    var bankAccount = $('#organisation_account').val()
    var bankName = $('#organisation_bankname').val()
    var newAddress = App.account
    var balance = App.balance
    var _strNew = balance + " ETH"
    //window.alert("before the create organisation function")
    await App.charity.createOrganisation(name,bankAccount,bankName,newAddress,_strNew)
    window.location.reload()
  },

  blockchain_function: async () => {

    await App.charity.blockchain_function()
    window.location.reload()
  }

}

$(() => {
  $(window).load(() => {
    App.load()
  })
})
