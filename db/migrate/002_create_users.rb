class CreateUsers < ActiveRecord::Migration[5.0]
  #define a change method in which to do the migration
  def change
    create_table :users do |t| #we get a block variable here for the table
      t.string :name
      # t.integer :user_balance
    end
  end
end
