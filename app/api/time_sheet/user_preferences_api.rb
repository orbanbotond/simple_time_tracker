module TimeSheet
  class UserPreferencesApi < Grape::API
    helpers ApiHelpers::AuthenticationHelper
    before { restrict_access_to_developers }
    before { authenticate! }

    format :json

    desc 'End point for the Preferences'
    namespace :preferences do

      desc 'show the preferences'
      params do
        requires :token, type: String, desc: 'The user authentication token'
      end
      get do
        current_user.preferred_working_hours.pluck :hour
      end

      desc 'set the preferences'
      params do
        requires :token, type: String, desc: 'The user authentication token'
        requires :hours, type: String, desc: 'The string representation of a Json array of hours. Example: [1,3,4]'
      end
      post do
        preferred_working_hours = PreferredWorkingHours.new
        hours_in_array = JSON.parse(params[:hours])
        hours_in_array.each do |hour|
          preferred_working_hours.send :"preferred_hour_#{hour}=", true
        end
        service = UserPreferenceManager.new current_user, preferred_working_hours
        if service.persist_user_data
          current_user.preferred_working_hours.pluck :hour
        else
          error_code = ErrorCodes::SERVER_ERROR
          error_msg = 'Server Error. We are working hard to resolve the issue'
          error!({ 'error_msg' => error_msg, 'error_code' => error_code }, 500)
        end
      end
    end
  end
end
