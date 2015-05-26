class WorkDay < ActiveRecord::Base
  include DateValidations

  belongs_to :user
  has_many :work_sessions

  validates :duration, presence: true
  validate :no_other_work_day_is_on_this_date

  accepts_nested_attributes_for :work_sessions, allow_destroy: true, :reject_if => lambda { |a| a[:description].blank? }

  def recalculate_duration
    self.duration = work_sessions.pluck(:duration).reduce(:+)
    save
  end

  private

  def no_other_work_day_is_on_this_date
    return unless date.present?
    return unless user.present?

    errors.add :date, 'there is a work day on that date belonging to the same user' if new_record? && user.work_days.find_by_date(date).present?
    errors.add :date, 'there is a work day on that date belonging to the same user' if persisted? && user.work_days.where{ (id != my{ id }) & (date == my{ date })}.present?
  end
end
