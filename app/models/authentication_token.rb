class AuthenticationToken < ActiveRecord::Base
  belongs_to :user

  validates :token, presence: true

  scope :valid,  -> { where{ (expires_at == nil) | (expires_at > Time.zone.now) } }

  DEFAULT_EXPIRES_INTERVAL = 60.days

  class << self
    def generate(user, expiration_intervall = DEFAULT_EXPIRES_INTERVAL)
      expires = Time.zone.now + expiration_intervall
      user.authentication_tokens.create token: SecureRandom.hex(16), expires_at: expires
    end
  end
end
