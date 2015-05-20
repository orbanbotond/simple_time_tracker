class AddWorkingDayIdToWorkSession < ActiveRecord::Migration
  def change
    add_column :work_sessions, :working_day_id, :integer
  end
end
