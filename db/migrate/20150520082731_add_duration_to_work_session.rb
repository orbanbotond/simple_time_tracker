class AddDurationToWorkSession < ActiveRecord::Migration
  def change
    add_column :work_sessions, :duration, :integer
    WorkSession.find_each do |work|
      work.save
    end
  end
end
