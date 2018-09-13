require 'pry'

require_relative '../app/models/currency.rb'
# require_relative '../../app/models/transactions.rb'
# require_relative '../../app/models/user.rb'


bitcoin = Currency.create(name: "Bitcoin", symbol: "BTC")
ethereum = Currency.create(name: "Ethereum", symbol: "ETH")
ripple = Currency.create(name: "XRP", symbol: "XRP")
bitcoin_cash = Currency.create(name: "Bitcoin Cash", symbol: "BCH")
eos = Currency.create(name: "EOS", symbol: "EOS")
stellar = Currency.create(name: "Stellar", symbol: "XLM")
litecoin = Currency.create(name: "Litecoin", symbol: "LTC")
tether = Currency.create(name: "Tether", symbol: "USDT")
cardano = Currency.create(name: "Cardano", symbol: "ADA")
monero = Currency.create(name: "Monero", symbol: "XMR")
