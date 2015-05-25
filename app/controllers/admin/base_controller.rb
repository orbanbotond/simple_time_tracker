module Admin
  class BaseController < ApplicationController
    include RestrictedForRoles

    restrict_for_roles :admin
  end
end
