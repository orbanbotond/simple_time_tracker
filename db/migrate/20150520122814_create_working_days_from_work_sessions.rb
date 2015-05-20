class CreateWorkingDaysFromWorkSessions < ActiveRecord::Migration
  def up
    WorkSession.find_each do |ws|
      date = ws.date
      wd = WorkingDay.find_or_create_by date: date do |working_day|
        working_day.duration += ws.duration
        working_day.user = ws.user
        working_day.work_sessions << ws
      end
      wd.save
    end
  end
end
