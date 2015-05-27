module AgainstOverlapping
  extend ActiveSupport::Concern

  included do
    validate :against_overlapping

    private

    def against_overlapping
      return unless start_time.present?
      return unless end_time.present?
      return unless work_day.present?

      relation_start = work_day.work_sessions.where{ (start_time <= my{ start_time }) & ( end_time >= my{ start_time }) }
      relation_end = work_day.work_sessions.where{ (start_time <= my{ end_time }) & ( end_time >= my{ end_time }) }
      relation_overlap = work_day.work_sessions.where{ (start_time >= my{ start_time }) & ( end_time <= my{ end_time }) }

      if respond_to?(:persisted?) && persisted? && respond_to?(:id)
        relation_start = relation_start.where{ id != my{ id } }
        relation_end = relation_end.where{ id != my{ id } }
        relation_overlap = relation_overlap.where{ id != my{ id } }
      end

      errors.add :start_time, 'there is an overlapping work session' if relation_start.present?
      errors.add :end_time, 'there is an overlapping work session' if relation_end.present?

      if relation_overlap.present?
        errors.add :start_time, 'there is an overlapping work session'
        errors.add :end_time, 'there is an overlapping work session'
      end
    end
  end

  module ClassMethods
  end
end
