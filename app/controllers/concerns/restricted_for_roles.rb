module RestrictedForRoles
  extend ActiveSupport::Concern

  included do
    before_filter :authenticate_by_roles!
    layout 'admin'

    def authenticate_by_roles!
      if (self.class.accessor_roles.present? && current_user.blank?) ||
         (self.class.accessor_roles.none?{|x|current_user.roles_name.include? x.to_s})
        redirect_to(new_user_session_path,  :warning => "Sorry! This page has restricted access.") 
      end
    end

  end

  module ClassMethods

    def accessor_roles
      @accessor_roles || @@accessor_roles
    end

    def restrict_for_roles(*roles)
      @accessor_roles = roles
      begin
        @@accessor_roles
      rescue
        @@accessor_roles = roles
      end
    end
  end
end