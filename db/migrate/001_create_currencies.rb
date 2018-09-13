class CreateCurrencies < ActiveRecord::Migration[5.0]
  #define a change method in which to do the migration
  def change
    create_table :currencies do |t| #we get a block variable here for the table
      t.string :name
      t.string :symbol
    end
  end
end
