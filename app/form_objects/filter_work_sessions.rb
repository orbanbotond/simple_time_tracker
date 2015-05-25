class FilterWorkSessions
  include ActiveAttr::Model

  attribute :from, type: Date
  attribute :to, type: Date

  validate :start_time_is_before_end_time
  validate :end_time_is_not_in_the_future

  def filtering?
    from.present? && to.present?
  end

  private

  def start_time_is_before_end_time
    return unless from.present?
    return unless to.present?

    errors.add(:from, 'to must be after from') if from > to
  end

  def end_time_is_not_in_the_future
    return unless to.present?

    errors.add(:to, 'to can\'t be in the future') if to > Time.zone.now
  end

end
