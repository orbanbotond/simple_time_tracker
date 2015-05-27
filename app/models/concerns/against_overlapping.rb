module AgainstOverlapping
  extend ActiveSupport::Concern

  included do
    validate :against_overlapping

    private

    def against_overlapping
      return unless start_time.present?
      return unless end_time.present?
      return unless work_day.present?

      errors.add :start_time, 'there is an overlapping work session' if work_day.work_sessions.where{ (start_time <= my{ start_time }) & ( end_time >= my{ start_time }) }.present?
      errors.add :end_time, 'there is an overlapping work session' if work_day.work_sessions.where{ (start_time <= my{ end_time }) & ( end_time >= my{ end_time }) }.present?

      if work_day.work_sessions.where{ (start_time >= my{ start_time }) & ( end_time <= my{ end_time }) }.present?
        errors.add :start_time, 'there is an overlapping work session'
        errors.add :end_time, 'there is an overlapping work session'
      end
    end
  end

  module ClassMethods
  end
end
