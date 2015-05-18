class PreferredWorkingHour < ActiveRecord::Base
  belongs_to :user

  validates :hour, presence: true, inclusion: { in: 0..23 }
end
