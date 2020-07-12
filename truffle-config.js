module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: process.env.PORT || 7545,
      network_id: "*" // Match any network id
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
}
