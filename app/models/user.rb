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
        puts Paint["#{format_number(amount)} #{coin} will cost you $#{format_number(cost)} and your current balance is $#{format_number(@user_balance[:USD])}.","#1e1e1e", "#93ff69", :bright,]
        puts Paint["Would you like to continue, 'y' or 'n'?", "#1e1e1e", "#80fd4f", :bright]
        puts Paint["...", "#1e1e1e", "#47ff00", :blink]
        puts " "
        user_input = gets.chomp
        if user_input.downcase == 'y'
          Transaction.create(currency_id: find_currency_id(coin), user_id: self.id, amount: amount)
          @user_balance[:USD] -= cost
          @user_balance[:"#{coin}"] += amount
          puts Paint["Transaction completed. Purchased #{amount} #{coin}. Your current balance is $#{format_number(@user_balance[:USD])}.","#1e1e1e", "#93ff69", :bright,]
        else
          puts Paint["Transaction aborted!!!", "#fff", :red, :blink]
        end
      elsif coins.include?(coin) && @user_balance[:USD] < cost
        puts Paint["I'm sorry, you don't have enough USD to make this purchase. Your current balance is $#{format_number(@user_balance[:USD])} and the cost is #{cost}#{coin}.", "#1e1e1e", "#80fd4f", :bright]
      end
  end

  def sell_crypto_currency(symbol, amount)
    coin = symbol.downcase.upcase
    coins = ["BTC", "ETH", "XRP", "BCH", "EOS", "XLM", "LTC", "USDT", "ADA", "XMR"]
    latest_price = Currency.get_market_quote(coin)
    cost = amount * latest_price
    if !coins.include?(coin)
      puts Paint["You have entered an incorrect symbol", "#fff", :red, :blink]
    elsif coins.include?(coin) && @user_balance[:"#{coin}"] >= amount
      puts Paint["Would you like to continue, 'y' or 'n'?", "#1e1e1e", "#80fd4f", :bright]
      puts Paint["...", "#1e1e1e", "#47ff00", :blink]
      puts " "
      user_input = gets.chomp
        if user_input.downcase == 'y'
        Transaction.create(currency_id: find_currency_id(coin), user_id: self.id, amount: amount)
        @user_balance[:"#{coin}"] -= amount
        @user_balance[:USD] += cost
        puts Paint["Selling #{amount} #{coin} for #{cost}. Your new balance is $#{format_number(@user_balance[:USD])}.", "#1e1e1e", "#4ffd0c", :bright]
        else
        puts Paint["Transaction aborted!!!", "#fff", :red, :blink]
        end
    elsif coins.include?(coin) && @user_balance[:"#{coin}"] < amount
      puts Paint["I'm sorry, you don't have enough #{coin} to make this sale.", "#1e1e1e", "#80fd4f", :bright]
    end
  end

  ####Insert user transaction methdods here#######


  def user_current_crypto_balance
    puts Paint["Your current USD balance is: $#{format_number(@user_balance[:USD])}", "#1e1e1e", "#63fe27", :bright]
    puts Paint["##########################", "#1e1e1e", "#63fe27", :bright]
    puts Paint["Your current crypto balance is:", "#1e1e1e", "#63fe27", :bright]
    puts Paint["  BTC: #{user_balance[:BTC]} ", "#fff", "#f7941d", :bright]
    puts Paint["  ETH: #{user_balance[:ETH]} ", "#fff", "#2f3030", :bright]
    puts Paint["  XRP: #{user_balance[:XRP]} ", "#fff", "#3674ad", :bright]
    puts Paint["  BCH: #{user_balance[:BCH]} ", "#fff", "#4cc947", :bright]
    puts Paint["  EOS: #{user_balance[:EOS]} ", "#fff", "#000", :bright]
    puts Paint["  XLM: #{user_balance[:XLM]} ", "#fff", "#0eb8e8", :bright]
    puts Paint["  LTC: #{user_balance[:LTC]} ", "#fff", "#6e6e6e", :bright]
    puts Paint["  USDT: #{user_balance[:USDT]}", "#fff", "#26a17b", :bright]
    puts Paint["  ADA: #{user_balance[:ADA]} ", "#fff", "#0b2029", :bright]
    puts Paint["  XMR: #{user_balance[:XMR]} ", "#fff", "#ff6600", :bright]
  end

  def get_transaction_history
    holder_array = Transaction.all.select {|item| item.user_id == self.id}
  end

  #def to see how much of a particular currency a user has bought

  #def see profit/loss


end
