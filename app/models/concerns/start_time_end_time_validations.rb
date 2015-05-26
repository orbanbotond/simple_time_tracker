module StartTimeEndTimeValidations
  extend ActiveSupport::Concern

  included do
    validates :start_time, presence: true
    validates :end_time, presence: true

    validate :start_time_is_before_end_time
    validate :end_time_is_not_in_the_future

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
  end

  module ClassMethods
  end
end
