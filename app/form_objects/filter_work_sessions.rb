class FilterWorkSessions
  include ActiveAttr::Model

  attribute :from, type: Date
  attribute :to, type: Date

  def filtering?
    from.present? && to.present?
  end
end
