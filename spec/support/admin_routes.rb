shared_examples 'Admin Resource Routes' do |resource, options|
  singularized_resource = resource.to_s.downcase.singularize
  pluralized_resource = resource.to_s.downcase.pluralize

  if options.nil? || (options.present? && options.include?(:index))
    specify 'index' do
      if pluralized_resource == singularized_resource
        path = "admin_#{pluralized_resource}_index_path"
      else
        path = "admin_#{pluralized_resource}_path"
      end

      expect(:get => send(path)).
        to route_to :controller => "admin/#{pluralized_resource}", :action => "index"
    end
  end
  if options.nil? || (options.present? && options.include?(:show))
    specify 'show' do
      expect(:get => send("admin_#{singularized_resource}_path", -1)).
        to route_to :controller => "admin/#{pluralized_resource}", :action => "show", :id => '-1'
    end
  end
  if options.nil? || (options.present? && options.include?(:new))
    specify 'new' do
      expect(:get => send( "new_admin_#{singularized_resource}_path")).
        to route_to :controller => "admin/#{pluralized_resource}", :action => "new"
    end
  end
  if options.nil? || (options.present? && options.include?(:create))
    specify 'create' do
      # expect(:post => admin_#{singularized_resource}_path()).
      #   to route_to(:controller => "admin/#{pluralized_resource}", :action => "create")
    end
  end
  if options.nil? || (options.present? && options.include?(:update))
    specify 'update' do
      expect(:put => send( "admin_#{singularized_resource}_path", -1)).
        to route_to(:controller => "admin/#{pluralized_resource}", :action => "update", :id => '-1')
    end
  end
  if options.nil? || (options.present? && options.include?(:edit))
    specify 'edit' do
      expect(:get => send( "edit_admin_#{singularized_resource}_path", -1)).
        to route_to(:controller => "admin/#{pluralized_resource}", :action => "edit", :id => '-1')
    end
  end
  if options.nil? || (options.present? && options.include?(:destroy))
    specify 'destroy' do
      expect(:delete => send( "admin_#{singularized_resource}_path", -1)).
        to route_to(:controller => "admin/#{pluralized_resource}", :action => "destroy", :id => '-1')
    end
  end
end