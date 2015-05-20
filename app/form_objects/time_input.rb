class TimeInput
  include ActiveAttr::Model

  attribute :start_time, type: String
  attribute :end_time, type: String
  attribute :description, type: String
  attribute :date, type: String

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :date, presence: true
  validates :description, presence: true
end
