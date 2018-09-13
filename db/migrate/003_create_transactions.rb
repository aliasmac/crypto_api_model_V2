class CreateTransactions < ActiveRecord::Migration[5.0]
  #define a change method in which to do the migration
  def change
    create_table :transactions do |t| #we get a block variable here for the table
      t.integer :currency_id
      t.integer :user_id
      t.integer :amount
      t.timestamps null: false
    end
  end
end
