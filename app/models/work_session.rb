class WorkSession < ActiveRecord::Base
  belongs_to :work_day

  before_save :calculate_duration
  after_save :recalculate_workdays_duration

  delegate :user, to: :work_day

  def in_preferred_hour?
    preferred_hours = user.preferred_working_hours
    preferred_intervals = preferred_hours.map do |x|
      hour = Time.parse("#{x.hour}:00")
      [hour.beginning_of_hour.seconds_since_midnight, hour.end_of_hour.seconds_since_midnight]
    end
    preferred_intervals.any? do |x|
      b = x.first
      e = x.last
      start_t = start_time.seconds_since_midnight
      end_t = end_time.seconds_since_midnight
      b <= start_t && start_t <= e ||
      b <= end_t  && end_t <= e ||
      start_t <= b && e <= end_t
    end
  end

  private

  def calculate_duration
    return unless start_time.present?
    return unless end_time.present?
    self.duration = end_time.to_i - start_time.to_i
  end

  def recalculate_workdays_duration
    work_day.recalculate_duration
  end
end
