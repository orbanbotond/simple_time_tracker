class RemoveDateFromWorkSession < ActiveRecord::Migration
  def change
    remove_column :work_sessions, :date, :date
  end
end
