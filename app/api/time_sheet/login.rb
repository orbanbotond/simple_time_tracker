module TimeSheet
  class Login < Grape::API
    helpers ApiHelpers::AuthenticationHelper
    before { restrict_access_to_developers }

    format :json
    prefix 'api'

    desc 'End-points for the Login'
    namespace :login do

      desc 'Login via email and password'
      params do
        requires :email, type: String, desc: 'email'
        requires :password, type: String, desc: 'password'
      end
      post do
        service = LoginService.new params[:email], params[:password]
        if token = service.execute
          status 200
          present token.user, with: Entities::UserWithTokenEntity
        else
          error_code = ErrorCodes::BAD_AUTHENTICATION_PARAMS
          error_msg = 'Bad Authentication Parameters'
          error!({ 'error_msg' => error_msg, 'error_code' => error_code }, 401)
          #TODO create an audit log entry...
        end
      end

      desc 'Forgot password'
      params do
        requires :email, type: String, desc: 'email'
      end
      post :forgot_password do
        user = User.find_by_email params[:email]
        if user.present?
          user.send_reset_password_instructions
          status 200
          present user, with: Entities::UserEntity
        else
          error_code = ErrorCodes::BAD_AUTHENTICATION_PARAMS
          error_msg = 'Bad Authentication Parameters'
          error!({ 'error_msg' => error_msg, 'error_code' => error_code }, 404)
          #TODO create an audit log entry...
        end
      end
    end
  end
end
