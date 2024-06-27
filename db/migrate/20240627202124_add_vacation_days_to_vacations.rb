class AddVacationDaysToVacations < ActiveRecord::Migration[7.1]
  def change
    add_column :vacations, :vacation_days, :integer
  end
end
