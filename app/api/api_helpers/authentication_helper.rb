module ApiHelpers
  module AuthenticationHelper
    TOKEN_PARAM_NAME = :token

    def restrict_access_to_developers
      header_token = headers['Authorization']
      key = ApiKey.where{ token == my{ header_token } }
      Rails.logger.info "API call: #{headers}\tWith params: #{params.inspect}" if ENV['DEBUG']
      if key.blank?
        error_code = ErrorCodes::DEVELOPER_KEY_MISSING
        error_msg = 'please aquire a developer key'
        error!({ :error_msg => error_msg, :error_code => error_code }, 401)
        #TODO create an audit...
      end
    end

    def current_user
    end

    def signed_in?
      !!current_user
    end
  end
end
