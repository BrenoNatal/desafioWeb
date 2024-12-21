class CreateServices < ActiveRecord::Migration[8.0]
  def change
    create_table :services do |t|
      t.string :service_type
      t.decimal :amount

      t.timestamps
    end
  end
end
