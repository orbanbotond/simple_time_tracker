module DateAtRelativeToNow
  extend ActiveSupport::Concern

  included do
    include ActionView::Helpers::DateHelper
  end

  module ClassMethods
    attr_reader :field

    def applicable_to?(object, _context)
      field = self.field
      object.respond_to? field
    end

    def applicable_to(field)
      @field = field

      define_method field do
        date = __getobj__.send self.__class__.field
        if date.present?
          "#{distance_of_time_in_words_to_now date} ago"
        else
          'Never'
        end
      end
    end
  end
end
