module Admin
  class RestfullController < Admin::BaseController
    include InheritedResourcesWithPundit
    include ::SortingHelpers

    def collection
      @collection ||= end_of_association_chain

      if params[:sort].present? && params[:sort_direction].present?
        @collection = @collection.order(sort_sql)
      end


      @collection = @collection.paginate(:page => params[:page], :per_page => 10)
    end

    def attrs_for_index
      []
    end

    def attrs_for_form
      []
    end

    def permitted_for_form
      attrs_for_form
    end

    helper_method :attrs_for_index
    helper_method :attrs_for_form

  protected

    def permitted_params
      resource = resource_class.to_s.underscore.downcase.to_sym
      {resource => params.fetch(resource, {}).permit(permitted_for_form)}
    end

  end
end
