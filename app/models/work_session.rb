class WorkSession < ActiveRecord::Base
  belongs_to :user
  belongs_to :work_day

  validates :description, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  validate :start_time_is_before_end_time
  validate :end_time_is_not_in_the_future

  before_save :calculate_duration
  after_save :recalculate_workdays_duration

  delegate :user, to: :work_day

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

  def start_time_is_before_end_time
    return unless start_time.present?
    return unless end_time.present?

    errors.add(:start_time, 'can not start after the task ends') if start_time > end_time
  end

  def end_time_is_not_in_the_future
    return unless end_time.present?

    errors.add(:end_time, 'end_time can\'t be in the future') if end_time > Time.zone.now
  end

  def calculate_duration
    return unless start_time.present?
    return unless end_time.present?
    self.duration = end_time - start_time    
  end

  def recalculate_workdays_duration
    work_day.recalculate_duration
  end
end
