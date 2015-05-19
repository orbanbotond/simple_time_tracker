class WorkSession < ActiveRecord::Base
  belongs_to :user

  validates :description, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  def start_time
    time = attributes['start_time']
    return time unless date.present?
    return time unless time.present?
    time.change year: date.year, month: date.month, day:date.day
  end

  def end_time
    time = attributes['end_time']
    return time unless date.present?
    return time unless time.present?
    time.change year: date.year, month: date.month, day:date.day
  end

  def duration
    end_time - start_time
  end

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
end
