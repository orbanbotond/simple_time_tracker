class WorkDay < ActiveRecord::Base
  belongs_to :user
  has_many :work_sessions

  validates :duration, presence: true

  accepts_nested_attributes_for :work_sessions, allow_destroy: true, :reject_if => lambda { |a| a[:description].blank? }

  def recalculate_duration
    self.duration = work_sessions.pluck(:duration).reduce(:+)
    save
  end
end
