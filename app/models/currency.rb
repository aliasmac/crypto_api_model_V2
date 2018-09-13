require 'rest-client'
require 'json'
require 'pry'

# require_relative 'example_hash.json'

class Currency < ActiveRecord::Base
  has_many :transactions
  has_many :users, through: :transactions

  def coins_you_can_buy
    p "Thank you for choosing Crypto Billionaire'/s, we're here to make your dreams come true"
    p "We sell the following cryptocurrencies:"
    p "- Bitcoin"
    p "- Ethereum"
    p "- XRP (Ripple)"
    p "- Bitcoin Cash"
    p "- EOS"
    p "- Stellar"
    p "- Litecoin"
    p "- Tether"
    p "- Cardano"
    p "- Monero"
    p "Make you choice!"
  end

  def self.get_api_data
    response = RestClient.get("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?&CMC_PRO_API_KEY=ec5d4736-f3ee-4f03-b8b8-1e1c82acba47&limit=10")
    # file2 = File.read('app/models/example_hash.json')
    data_hash = JSON.parse(response)
  end

  def self.get_latest_prices
    # Lists USD price for each individual token for all currencies and displays alphabetically.
    get_api_data["data"].each do |coin_hash|
      p "#{coin_hash["name"]}: $#{coin_hash["quote"]["USD"]["price"].round(2)}"
    end
  end

  #Please enter the name of the cruptocurrency you would like to buy"

  def self.get_market_quote(currency)
    # Takes in an argument of one of 10 currencies and returns the price for named currency.
    latest_price = 0
    get_api_data["data"].each do |coin_hash|
      if coin_hash["symbol"] == currency.upcase
        p "#{currency.downcase.upcase} is currently priced at: $#{coin_hash["quote"]["USD"]["price"].round(2)}"
        latest_price = coin_hash["quote"]["USD"]["price"].round(2)
      end
    end
    latest_price
  end

  def self.get_top_ten
    # Lists prices for all currencies by market cap.
    i = 1
    get_api_data["data"].each do |coin_hash|
      puts "#{i}. #{coin_hash["name"]}'s market cap is $#{coin_hash["quote"]["USD"]["market_cap"].round(2)}".to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
      i += 1
    end
    puts "Prices fetched"
  end

  #Class method to see which user has bought the most of x currency

  #Class method to see which user has bought the most of x currency



end
