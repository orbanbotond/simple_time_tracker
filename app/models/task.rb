class Task < ActiveRecord::Base
  belongs_to :user

  validates :description, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
