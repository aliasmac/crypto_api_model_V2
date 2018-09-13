require 'pry'

require_relative '../app/models/currency.rb'
require_relative '../app/models/transactions.rb'
require_relative '../app/models/user.rb'


class CommandLine

  attr_accessor :user_name

  def self.welcome
    puts Paint%[" %{dollar_blink} Thank you for choosing %{crypto}, we're here to make your dreams come true %{dollar_blink} ", "#1e1e1e", "#93ff69", :bright,
           dollar_blink: ["$$$", "#8c4dff"],
           crypto: ["CRYPT-O-ZONE\u2122", "#8c4dff"]
         ]
    puts " "
    `say welcome`
    sleep(0.3)
    `say to the crypt o zone`
  end

  def self.instructions
    puts Paint["Step 1: Open an account.", "#1e1e1e", "#80fd4f", :bright]
    puts Paint["Step 2: Use our research centre to unleash synergistic functionalities\u2122.", "#1e1e1e", "#63fe27", :bright]
    puts Paint["Step 3: buy and sell crypto assets", "#1e1e1e", "#4ffd0c", :bright]
    puts " "
  end

  def self.prompt_user_name
    puts Paint["To continue, please choose a user name to open you account", "#1e1e1e", "#47ff00", :bright]
    puts Paint["...", "#1e1e1e", "#47ff00", :blink]
    user_input = gets.chomp
    @user_name = User.create(name: user_input) #Change to find_by_or_create method
    @user_name.activate_account
    puts " "
    puts Paint%["Congratulations, you have successfully opened your crypto trading account with %{crypto}!", "#1e1e1e", "#4ffd0c", :bright,
           crypto: ["CRYPT-O-ZONE\u2122", "#8c4dff"]
         ]
    puts " "
  end


  def self.menu
    puts
    puts Paint["~(˘▾˘~)", "#1e1e1e", "#63fe27", :bright,]
    puts Paint["Please choose from one of the following options:", "#1e1e1e", "#63fe27", :bright,]
    puts Paint["'1' to add USD to your account", "#1e1e1e", "#80fd4f", :bright]
    puts Paint["'2' to enter our crypto data research centre", "#1e1e1e", "#93ff69", :bright]
    puts Paint["'3' to buy crypto currency", "#1e1e1e", "#80fd4f", :bright]
    puts Paint["'4' to sell crypto currency", "#1e1e1e", "#63fe27", :bright]
    puts Paint["'q' to exit application, not sure why you would ever want to leave though  ¯\_(ツ)_/¯", "#1e1e1e", "#4ffd0c", :bright]
    puts Paint["...", "#1e1e1e", "#47ff00", :blink]
    puts " "
    gets.chomp.downcase
  end

  def self.menu_research_centre
        puts Paint["Welcome to the CRYPTO-O-ZONE\u2122 Research Centre\u2122", "#1e1e1e", "#63fe27", :bright]
        puts Paint["'1' to get the latest crypto prices", "#1e1e1e", "#80fd4f", :bright]
        puts Paint["'2' to get the latest market quote for a specific cryptocurrency", "#1e1e1e", "#93ff69", :bright]
        puts Paint["'3' to get the top 10 cryptocurrencies by market cap", "#1e1e1e", "#93ff69", :bright]
        puts Paint["'q' to return to main menu", "#1e1e1e", "#93ff69", :bright]
        puts Paint["...", "#1e1e1e", "#47ff00", :blink]
        puts " "
  end

  def self.research_centre_menu
    loop do
      CommandLine.menu_research_centre
      response = gets.chomp
      if response == '1'
        CommandLine.user_get_latest_prices
      elsif response == '2'
        puts Paint["Please enter the the 'symbol' of the cryptocurrency that you would like a price for", "#1e1e1e", "#93ff69", :bright]
        puts Paint["...", "#1e1e1e", "#47ff00", :blink]
        puts " "
        user_input = gets.chomp
        Currency.get_market_quote(user_input)
      elsif response == '3'
        puts Currency.get_top_ten
      elsif response == 'q'
        system("clear")
        run
      else
        puts Paint["That's not a valid entry", "#fff", :red, :blink]
      end
    end
  end

  def self.user_add_balance
    system("clear")
    puts Paint["Please deposit US Dollars into your account to start trading.", "#1e1e1e", "#63fe27", :bright]
    puts Paint["Amount:", "#1e1e1e", "#80fd4f", :bright]
    puts Paint["...", "#1e1e1e", "#47ff00", :blink]
    puts " "
    balance_input = gets.chomp.scan(/\d/).join.to_i
          if balance_input.is_a? Integer
            @user_name.add_usd_to_balance(balance_input)
            @user_name.user_current_crypto_balance
      else
        puts Paint["Invalid input. Please enter a whole number.", "#fff", :red, :blink]
      end
  end

  #Add menu here:
  def self.user_get_latest_prices
    system("clear")
    puts Paint["Fetching latest data from the trading floor....", "#1e1e1e", "#63fe27", :bright]
      0.step(100, 5) do |i|
      printf("\rProgress: [%-20s]", "=" * (i/5))
      sleep(0.2)
      end
    puts
    Currency.get_latest_prices
  end

  def self.choose_currency_to_buy
    system("clear")
    puts Paint["You may purchase the following cryptocurrencies:", "#1e1e1e", "#63fe27", :bright]
    puts Paint["- Bitcoin (BTC)", "#fff", "#f7941d", :bright]
    puts Paint["- Ethereum (ETH)", "#fff", "#2f3030", :bright]
    puts Paint["- XRP (Ripple) (XRP)", "#fff", "#3674ad", :bright]
    puts Paint["- Bitcoin Cash (BCH)", "#fff", "#4cc947", :bright]
    puts Paint["- EOS (EOS)", "#fff", "#000", :bright]
    puts Paint["- Stellar (XLM)", "#fff", "#0eb8e8", :bright]
    puts Paint["- Litecoin (LTC)", "#fff", "#6e6e6e", :bright]
    puts Paint["- Tether (USDT)", "#fff", "#26a17b", :bright]
    puts Paint["- Cardano (ADA)", "#fff", "#0b2029", :bright]
    puts Paint["- Monero (XMR)", "#fff", "#ff6600", :bright]
    puts Paint["Please enter symbol to make your choice!", "#1e1e1e", "#63fe27", :bright]
    puts Paint["...", "#1e1e1e", "#47ff00", :blink]
    puts " "
    currency_choice = gets.chomp
    puts " "
    puts Paint["Please enter amount.", "#1e1e1e", "#63fe27", :bright]
    puts Paint["...", "#1e1e1e", "#47ff00", :blink]
    puts " "
    amount_entered = gets.chomp.to_i
    if amount_entered.is_a? Integer
      @user_name.buy_crypto_currency(currency_choice, amount_entered)
    else
      puts Paint["Invalid amount", "#fff", :red, :blink]
    end
  end

  def self.choose_currency_to_sell
    system("clear")
    @user_name.user_current_crypto_balance
    puts " "
    puts Paint["Which crytocurrency would you like to sell?", "#1e1e1e", "#63fe27", :bright]
    puts Paint["...", "#1e1e1e", "#47ff00", :blink]
    puts " "
    sym = gets.chomp
    puts " "
    puts Paint["How much would you like to sell?", "#1e1e1e", "#f7941d", :bright]
    puts Paint["...", "#1e1e1e", "#47ff00", :blink]
    puts " "
    amount = gets.chomp.to_i
    @user_name.sell_crypto_currency(sym, amount)
    puts " "
    puts Paint%["Thank you for trading %{crypto}!", "#1e1e1e", "#93ff69", :bright,
        crypto: ["CRYPT-O-ZONE\u2122", "#8c4dff"]
      ]
  end

  def self.user_check_balance
    system("clear")
    @user_name.user_current_crypto_balance
  end


end
