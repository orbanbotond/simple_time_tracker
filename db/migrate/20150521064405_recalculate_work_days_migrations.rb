class RecalculateWorkDaysMigrations < ActiveRecord::Migration
  def change
    WorkDay.find_each do |wd|
      wd.recalculate_duration
    end
  end
end
