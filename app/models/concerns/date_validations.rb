module DateValidations
  extend ActiveSupport::Concern

  included do
    validates :date, presence: true
    validate :date_is_not_in_the_future

    private

    def date_is_not_in_the_future
      return unless date.present?

      errors.add(:date, 'date can\'t be in the future') if date > Time.zone.now
    end
  end

  module ClassMethods
  end
end
