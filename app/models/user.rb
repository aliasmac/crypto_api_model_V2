require 'rest-client'
require 'json'
require 'pry'

require_relative 'currency.rb'

class User < ActiveRecord::Base
  has_many :transactions
  has_many :currencies, through: :transactions

  attr_reader :user_balance

  def format_number(amount)
    amount.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

  def activate_account
    @user_balance = {
      USD: 0,
      BTC: 0,
      ETH: 0,
      XRP: 0,
      BCH: 0,
      EOS: 0,
      XLM: 0,
      LTC: 0,
      USDT: 0,
      ADA: 0,
      XMR: 0
    }
  end

  def add_usd_to_balance(amount)
    @user_balance[:USD] += amount
  end


  def find_currency_id(sym)
    #method needs to return an id of a symbol passed in as an argument
    currency = Currency.find_by(symbol: sym)
    currency.id
  end


  def buy_crypto_currency(symbol, amount)
    coin = symbol.downcase.upcase
    coins = ["BTC", "ETH", "XRP", "BCH", "EOS", "XLM", "LTC", "USDT", "ADA", "XMR"]
    latest_price = Currency.get_market_quote(coin)
    cost = amount * latest_price
      if !coins.include?(coin)
        puts "You have entered an incorrect symbol"
      elsif coins.include?(coin) && @user_balance[:USD] > cost
        puts "#{amount} #{coin} will cost you $#{cost} and your current balance is $#{format_number(@user_balance[:USD])}."
        p "Would you like to continue, 'y' or 'n'?"
        user_input = gets.chomp
        if user_input.downcase == 'y'
          Transaction.create(currency_id: find_currency_id(coin), user_id: self.id, amount: amount)
          @user_balance[:USD] -= cost
          @user_balance[:"#{coin}"] += amount
          puts "Transaction completed. Purchased #{amount} #{coin}. Your current balance is $#{format_number(@user_balance[:USD])}."
        else
          p "Transaction aborted!!!"
        end
      elsif coins.include?(coin) && @user_balance[:USD] < cost
        puts "I'm sorry, you don't have enough USD to make this purchase. Your current balance is $#{format_number(@user_balance[:USD])} and the cost is #{cost}#{coin}."
      end
  end

  def sell_crypto_currency(symbol, amount)
    coin = symbol.downcase.upcase
    coins = ["BTC", "ETH", "XRP", "BCH", "EOS", "XLM", "LTC", "USDT", "ADA", "XMR"]
    latest_price = Currency.get_market_quote(coin)
    cost = amount * latest_price
    if !coins.include?(coin)
      puts "You have entered an incorrect symbol"
    elsif coins.include?(coin) && @user_balance[:"#{coin}"] >= amount
      Transaction.create(currency_id: find_currency_id(coin), user_id: self.id, amount: amount)
      @user_balance[:"#{coin}"] -= amount
      @user_balance[:USD] += cost
      puts "Selling #{amount} #{coin} for #{cost}. Your new balance is $#{format_number(@user_balance[:USD])}."
    elsif coins.include?(coin) && @user_balance[:"#{coin}"] < amount
      puts "I'm sorry, you don't have enough #{coin} to make this sale."
    end
  end

  ####Insert user transaction methdods here#######


  def user_current_crypto_balance
    p "Your current USD balance is: $#{format_number(@user_balance[:USD])}"
    p "##########################"
    p "Your current crypto balance is:"
    p "BTC: #{user_balance[:BTC]}"
    p "ETH: #{user_balance[:ETH]}"
    p "XRP: #{user_balance[:XRP]}"
    p "BCH: #{user_balance[:BCH]}"
    p "EOS: #{user_balance[:EOS]}"
    p "XLM: #{user_balance[:XLM]}"
    p "LTC: #{user_balance[:LTC]}"
    p "USDT: #{user_balance[:USDT]}"
    p "ADA: #{user_balance[:ADA]}"
    p "XMR: #{user_balance[:XMR]}"
  end

  def get_transaction_history
    holder_array = Transaction.all.select {|item| item.user_id == self.id}
  end

  #def to see how much of a particular currency a user has bought

  #def see profit/loss


end
