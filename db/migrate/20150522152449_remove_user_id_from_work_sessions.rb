class RemoveUserIdFromWorkSessions < ActiveRecord::Migration
  def change
    remove_column :work_sessions, :user_id, :integer
  end
end
