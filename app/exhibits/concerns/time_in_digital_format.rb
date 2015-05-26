module TimeInDigitalFormat
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
        time = __getobj__.send self.__class__.field
        time.strftime('%H:%M')
      end
    end
  end
end
