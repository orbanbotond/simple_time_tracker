module TimeSheet
  class PingProtected < Grape::API
    helpers ApiHelpers::AuthenticationHelper
    before { restrict_access_to_developers }

    format :json
    desc "Returns pong."
    get :ping_dev do
      { :ping => params[:pong] || 'pong' }
    end
  end
end
