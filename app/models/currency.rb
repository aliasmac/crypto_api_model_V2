require 'rest-client'
require 'json'
require 'pry'

# require_relative 'example_hash.json'

class Currency < ActiveRecord::Base
  has_many :transactions
  has_many :users, through: :transactions

  def coins_you_can_buy
    system("clear")
    puts Paint["Thank you for choosing Crypto Billionaire'/s, we're here to make your dreams come true", "#1e1e1e", "#63fe27", :bright]
    puts " "
    puts Paint["We sell the following cryptocurrencies:", "#1e1e1e", "#63fe27", :bright]
    puts Paint["- Bitcoin", "#fff", "#f7941d", :bright]
    puts Paint["- Ethereum", "#fff", "#f7941d", :bright]
    puts Paint["- XRP (Ripple)", "#fff", "#3674ad", :bright]
    puts Paint["- Bitcoin Cash", "#fff", "#4cc947", :bright]
    puts Paint["- EOS", "#fff", "#000", :bright]
    puts Paint["- Stellar", "#fff", "#0eb8e8", :bright]
    puts Paint["- Litecoin", "#fff", "#6e6e6e", :bright]
    puts Paint["- Tether", "#fff", "#26a17b", :bright]
    puts Paint["- Cardano", "#fff", "#0b2029", :bright]
    puts Paint["- Monero", "#fff", "#ff6600", :bright]
    puts Paint["Make you choice!", "#1e1e1e", "#63fe27", :bright]
    puts Paint["...", "#1e1e1e", "#47ff00", :blink]
    puts " "
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
