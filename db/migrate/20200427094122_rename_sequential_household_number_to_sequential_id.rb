class RenameSequentialHouseholdNumberToSequentialId < ActiveRecord::Migration[6.0]
  def change
    rename_column :readings, :sequential_household_number, :sequential_id
  end
end
