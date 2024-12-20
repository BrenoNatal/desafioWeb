class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.text :description
      t.integer :account_id_target
      t.integer :account_id_source
      t.integer :account_num_target
      t.integer :account_num_source

      t.timestamps
    end
    add_index :transactions, :account_id_target
    add_index :transactions, :account_id_source
  end
end
