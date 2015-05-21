class ApiKey < ActiveRecord::Base
  validates :token, presence: true
end
