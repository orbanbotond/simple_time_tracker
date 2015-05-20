class AddDateToWorkingDay < ActiveRecord::Migration
  def change
    add_column :working_days, :date, :date
  end
end
