class RenameWorkinDayIdToWorkDayId < ActiveRecord::Migration
  def change
    rename_column :work_sessions, :working_day_id, :work_day_id 
  end
end
