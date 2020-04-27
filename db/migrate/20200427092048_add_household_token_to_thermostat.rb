class AddHouseholdTokenToThermostat < ActiveRecord::Migration[6.0]
  def change
    add_column :thermostats, :household_token, :text
  end
end
