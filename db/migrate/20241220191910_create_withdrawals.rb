class CreateWithdrawals < ActiveRecord::Migration[8.0]
  def change
    create_table :withdrawals do |t|
      t.decimal :amount
      t.integer :account_id

      t.timestamps
    end
    add_index :withdrawals, :account_id
  end
end
