module SortingHelpers

  extend ActiveSupport::Concern

  included do
    helper_method :sort_column, :sort_direction

    def sort_column(sort_param = :sort)
      resource_class.column_names.include?(params[sort_param]) ? params[sort_param] : "name"
    end

    def sort_direction(sort_direction = :sort_direction)
      %w[asc desc].include?(params[sort_direction]) ? params[sort_direction] : 'asc'
    end

    def sort_sql
      dir = sort_direction
      dir = dir == 'desc' ? 'DESC NULLS LAST' : dir
      "#{sort_column} #{dir}"
    end
  end

  module ClassMethods
  end
end