class TimeInput
  include ActiveAttr::Model
  include StartTimeEndTimeValidations
  include DateValidations

  attribute :start_time, type: DateTime
  attribute :end_time, type: DateTime
  attribute :description, type: String
  attribute :date, type: Date

  validates :description, presence: true

  def start_time_is_before_end_time
    return unless start_time.present?
    return unless end_time.present?

    errors.add(:start_time, 'can not start after the task ends') if start_time > end_time  
  end

  def start_time
    time = super
    return time unless date.present?
    return time unless time.present?
    time.change year: date.year, month: date.month, day:date.day
  end

  def end_time
    time = super
    return time unless date.present?
    return time unless time.present?
    time.change year: date.year, month: date.month, day:date.day
  end
end
