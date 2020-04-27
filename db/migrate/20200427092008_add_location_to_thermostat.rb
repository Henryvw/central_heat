class AddLocationToThermostat < ActiveRecord::Migration[6.0]
  def change
    add_column :thermostats, :location, :string
  end
end
