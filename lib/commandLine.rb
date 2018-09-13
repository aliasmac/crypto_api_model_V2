require 'pry'

require_relative '../app/models/currency.rb'
require_relative '../app/models/transactions.rb'
require_relative '../app/models/user.rb'


class CommandLine

  attr_accessor :user_name

  def self.welcome
    p "Thank you for choosing CRYPT-O-ZONE, we're here to make your dreams come true"
  end

  def self.instructions
    p "Step 1: Open an account."
    p "Step 2: Use our research centre to unleash synergistic functionalities."
    p "step 3: buy and sell cryto assets"
  end

  def self.prompt_user_name
    p "To continue, please choose a user name to open you account"
    user_input = gets.chomp
    @user_name = User.create(name: user_input) #Change to find_by_or_create method
    @user_name.activate_account
    p "Congratulations #{@user_name.name}, you have successfully opened your crypto trading account with CRYPTO-O-ZONE!"
  end


  def self.menu
    p "~(˘▾˘~)"
    p "Please choose from one of the following options:"
    p "'1' to add USD to your account"
    p "'2' to enter our crypto data research centre"
    p "'3' to buy crypto currency"
    p "'4' to sell crypto currency"
    p "'5' to check balance'"
    p "'q' to exit application, not sure why you would ever want to leave though  ¯\_(ツ)_/¯"
    gets.chomp.downcase
  end

  def self.menu_research_centre
    p "Welcome to the CRYPTO-O-ZONE\u2122 Research Centre\u2122"
        p "'1' to get the latest crypto prices"
        p "'2' to get the latest market quote for a specific cryptocurrency"
        p "'3' to get the top 10 cryptocurrencies by market cap"
        p "'q' to return to main menu"
        # gets.chomp.downcase
  end

  def self.research_centre_menu
    loop do
      CommandLine.menu_research_centre
      response = gets.chomp
      if response == '1'
        CommandLine.user_get_latest_prices
      elsif response == '2'
        puts "Please enter the the 'symbol' of the cryptocurrency that you would like a price for"
        user_input = gets.chomp
        Currency.get_market_quote(user_input)
      elsif response == '3'
        puts Currency.get_top_ten
      elsif response == 'q'
        run
      else
        puts "That's not a valid entry"
      end
    end
  end

  def self.user_add_balance
    p "Please deposit US Dollars into your account to start trading."
    p "Amount:"
    balance_input = gets.chomp.scan(/\d/).join.to_i
      if balance_input.is_a? Integer
        @user_name.add_usd_to_balance(balance_input)
        @user_name.user_current_crypto_balance
      else
        p "Invalid input. Please enter a whole number."
      end
  end

  #Add menu here:
  def self.user_get_latest_prices
    p "Fetching latest data from the trading floor...."
    0.step(100, 5) do |i|
    printf("\rProgress: [%-20s]", "=" * (i/5))
    sleep(0.2)
    end
    puts
    Currency.get_latest_prices
  end

  def self.choose_currency_to_buy
    p "You may purchase the following cryptocurrencies:"
    p "- Bitcoin (BTC)"
    p "- Ethereum (ETH)"
    p "- XRP (Ripple) (XRP)"
    p "- Bitcoin Cash (BCH)"
    p "- EOS (EOS)"
    p "- Stellar (XLM)"
    p "- Litecoin (LTC)"
    p "- Tether (USDT)"
    p "- Cardano (ADA)"
    p "- Monero (XMR)"
    p "Please enter symbol to make your choice!"
    currency_choice = gets.chomp
    p "Please enter amount."
    amount_entered = gets.chomp.to_i
    if amount_entered.is_a? Integer
      @user_name.buy_crypto_currency(currency_choice, amount_entered)
    else
      p "Invalid amount"
    end
  end


  def self.choose_currency_to_sell
    @user_name.user_current_crypto_balance
    p "Which crytocurrency would you like to sell?"
    sym = gets.chomp
    p "How much would you like to sell?"
    amount = gets.chomp.to_i
    @user_name.sell_crypto_currency(sym, amount)
    p "Thank you for trading CRYPT-O-ZONE!"
  end

  def self.user_check_balance
    @user_name.user_current_crypto_balance
  end



end
