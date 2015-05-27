module TimeSheet
  class WorkSessionApi < Grape::API
    helpers ApiHelpers::AuthenticationHelper
    before { restrict_access_to_developers }
    before { authenticate! }

    format :json

    desc 'End point for the Work Sessions'
    namespace :work_sessions do

      desc 'Listing a Time Sheet'
      params do
        requires :token, type: String, desc: 'The user authentication token'
        optional :from, type: Date, desc: 'The start date part of the filter. Format: \'dd/mm/yyyy\''
        optional :to, type: Date, desc: 'The end date part of the filter. Format: \'dd/mm/yyyy\''
      end
      get do
        filter = FilterWorkSessions.new params.slice(:from, :to)
        relation = WorkSessionQueries.new(current_user, filter).execute
        present relation, with: Entities::WorkSessionEntity
      end

      desc 'Post a Work Entry'
      params do
        requires :token, type: String, desc: 'The user authentication token'
        requires :description, type: String, desc: 'The descriptino of the work session'
        requires :date, type: String, desc: 'The date of the work session. Format: \'dd/mm/yyyy\''
        requires :start_time, type: String, desc: 'The start_time of work session. Format: \'hh:mm\''
        requires :end_time, type: String, desc: 'The end_time of work session. Format: \'hh:mm\''
      end
      post do
        input = TimeInput.new params
        manager = WorkSessionManager.new current_user, input
        ws = manager.save
        if ws
          present ws, with: Entities::WorkSessionEntity
        else
          error_code = ErrorCodes::BAD_PARAMS
          error_msg = input.errors.messages
          error!({ 'error_msg' => error_msg, 'error_code' => error_code }, 400)
        end
      end
    end
  end
end
