class RenameWorkingDaysToWorkDays < ActiveRecord::Migration
  def change
    rename_table :working_days, :work_days
  end
end
