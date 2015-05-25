module InheritedResourcesWithPundit
  extend ActiveSupport::Concern

  included do
    include Pundit

    inherit_resources

    alias_method_chain :resource, :authority
    alias_method_chain :build_resource, :authority
    alias_method_chain :update_resource, :authority
    alias_method_chain :collection, :authority
  end

  protected

  def collection_with_authority
    collection_without_authority
    authorize get_collection_ivar
    get_collection_ivar
  end

  def resource_with_authority
    resource_without_authority
    authorize get_resource_ivar
    get_resource_ivar
  end

  def build_resource_with_authority
    build_resource_without_authority
    authorize get_resource_ivar
    get_resource_ivar
  end

  def update_resource_with_authority(object, attributes)
    object.assign_attributes(*attributes)
    authorize object
    object.save
  end
end
