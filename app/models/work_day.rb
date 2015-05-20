class WorkDay < ActiveRecord::Base
  belongs_to :user
  has_many :work_sessions

  validates :duration, presence: true
end
