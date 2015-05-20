class WorkSessionManager

  attr_reader :user, :time_input

  def initialize(user, time_input)
    @user = user
    @time_input = time_input
  end

  def save
    wd = WorkDay.find_or_create_by date: Date.parse(time_input.date) do |work_day|
      work_day.duration = 0
      work_day.user = user
    end
    wd.work_sessions.create time_input.attributes.slice('start_time', 'end_time', 'description')
  end
end
