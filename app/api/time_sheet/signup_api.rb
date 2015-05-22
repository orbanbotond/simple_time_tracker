module TimeSheet
  class SignupApi < Grape::API
    helpers ApiHelpers::AuthenticationHelper
    before { restrict_access_to_developers }

    format :json

    desc 'End-points for the Signup'
    namespace :sign_up do

      desc 'Signup a User'
      params do
        requires :name, type: String, desc: 'Name of the User'
        requires :email, type: String, desc: 'email'
        requires :password, type: String, desc: 'password'
        requires :password_confirmation, type: String, desc: 'password'
      end
      post do
        error!({ 'error_msg' => 'An Account Using That Email Is Already Present', 'error_code' => ErrorCodes::BAD_PARAMS }, 400) if User.find_by_email params[:email]
        user = User.create ActionController::Parameters.new(params).permit(:name, :email, :password, :password_confirmation)
        if user.valid?
          AuthenticationToken.generate user
          present user, with: Entities::UserWithTokenEntity
        else
          error_code = ErrorCodes::BAD_PARAMS
          error_msg = user.errors.full_messages
          error!({ 'error_msg' => error_msg, 'error_code' => error_code }, 400)
          #TODO create an audit log entry...
        end
      end
    end
  end
end
