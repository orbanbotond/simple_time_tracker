class WorkDay < ActiveRecord::Base
  belongs_to :user
  has_many :work_sessions

  validates :duration, presence: true

  def recalculate_duration
    self.duration = work_sessions.pluck(:duration).reduce(:+)
    save
  end
end
