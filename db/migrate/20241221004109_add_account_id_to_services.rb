class AddAccountIdToServices < ActiveRecord::Migration[8.0]
  def change
    add_column :services, :account_id, :integer
    add_index :services, :account_id
  end
end
