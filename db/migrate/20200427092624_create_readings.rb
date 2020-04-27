class CreateReadings < ActiveRecord::Migration[6.0]
  def change
    create_table :readings do |t|
      t.references :thermostat, null: false, foreign_key: true
      t.integer :sequential_household_number
      t.float :temperature
      t.float :humidity
      t.float :battery_charge

      t.timestamps
    end
  end
end
