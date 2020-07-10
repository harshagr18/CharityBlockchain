App = {


	loading: false,
	contracts: {},


	load: async() => {

		await App.loadWeb3()
		await App.loadAccount()
		await App.loadContract()


		},

	loadWeb3: async () => {

		if (typeof web3 !== 'undefined') {
			App.web3Provider = web3.currentProvider
			web3 = new Web3(web3.currentProvider)
			window.alert("connected to metamask!!!!")
		}

		else {
			window.alert("Please connect to metamask.")
		}


		//Modern DApp browsers

		if (window.ethereum) {

			window.web3 = new Web3(ethereum)
			try {
				//Request account access if needed
				await ethereum.enable()

				web3.eth.sendTransaction({/* ...*/})
			}
			catch(error) {

				//user denied account access...

			}

		}

		else if (window.web3) {

			App.web3Provider = web3.currentProvider
			window.web3 = new Web3.currentProvider

			web3.eth.sendTransaction({/* ... */})
		}

		else {
			console.log('non-ethereum browser detected. you should consider trying metamask!')
		}

	},


	loadAccount: async () => {

		App.account = web3.eth.accounts[0]
	},

	loadContract: async () => {

		const charity = await $.getJSON('charity.json')
		App.contracts.charity = TruffleContract(charity)
		App.contracts.charity.setProvider(App.web3Provider)

		App.charity = await App.contracts.charity.deployed()

	},

	createCharity: async () => {
		//App.setLoading(true)
		var name = $('#charity_name').val()
		var description = $('#charity_desciption').val()
		await App.charity.createCharity(name,description)
		const charity_count = await App.charity.charity_count();
		$('#logId1').innerHTML = "charity_count";
		var displayEl = document.getElementById("name11");
		displayEl.value = name;
		document.write(name + " " + description);
		window.alert(name + " " + description);
		//window.location.reload()
	},

}

$(() => {
	$(window).load(() => {
		App.load()
	})
})
