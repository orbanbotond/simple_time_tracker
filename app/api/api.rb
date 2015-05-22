class API < Grape::API

  prefix 'api'

  rescue_from ActiveRecord::RecordNotFound do |e|
    # LogApiCall.new({env: env, level: :error, status: 404, backtrace: $!.to_s}).execute
    rack_response({ error_type: "not_found" }.to_json, 404)
  end

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    # LogApiCall.new({env: env, level: :error, status: 500, backtrace: "Grape::Exceptions::ValidationErrors: #{e.to_json}"}).execute
    rack_response({
      status: e.status,
      error_msg: e.message,
      error_code: ErrorCodes::BAD_PARAMS
    }.to_json, 400)
  end

  rescue_from :all do |e|
    # LogApiCall.new({env: env, level: :error, status: 500}).execute
    # binding.pry unless Rails.env.production?
    # Rails.logger.error e.message
    # Rails.logger.error e.backtrace
    rack_response({ error_type: "invalid_request" }.to_json, 500)
  end

  mount TimeSheet::Ping
  mount TimeSheet::PingProtected
  mount TimeSheet::Login
  mount TimeSheet::SignupApi
  mount TimeSheet::WorkSessionApi
  mount TimeSheet::UserPreferencesApi

  add_swagger_documentation
end

# require 'entities/work_session'
