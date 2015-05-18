class RenameTasksToWorkSessions < ActiveRecord::Migration
  def change
    rename_table :tasks, :work_sessions
  end
end
