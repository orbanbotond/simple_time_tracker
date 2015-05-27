class API < Grape::API

  prefix 'api'

  rescue_from Pundit::NotAuthorizedError do |e|
    rack_response({
      error_msg: 'not enough privileges',
      error_code: ErrorCodes::BAD_PARAMS
    }.to_json, 401)
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    rack_response({ error_type: "not_found" }.to_json, 404)
  end

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    rack_response({
      status: e.status,
      error_msg: e.message,
      error_code: ErrorCodes::BAD_PARAMS
    }.to_json, 400)
  end

  rescue_from :all do |e|
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
