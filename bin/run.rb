require 'pry'
require_relative '../config/environment'
# require_relative '../app/models/currency.rb'
# require_relative '../app/models/transactions.rb'
# require_relative '../app/models/user.rb'
require_relative '../lib/commandLine.rb'


CommandLine.welcome
CommandLine.instructions
CommandLine.prompt_user_name

#Display menu only after user has opened account
def run
  case CommandLine.menu
    when '1'
      CommandLine.user_add_balance
      run
    when '2'
      CommandLine.research_centre_menu
    when '3'
      CommandLine.choose_currency_to_buy
      run
    when '4'
      CommandLine.choose_currency_to_sell
      run
    when '5'
      CommandLine.user_check_balance
      run
    when 'q'
      exit
    else
      puts "That's not a valid entry"
      run
    end
end

run

binding.pry
puts "HELLO WORLD"
