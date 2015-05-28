module TimeSheet
  class WorkSessionApi < Grape::API
    helpers ApiHelpers::AuthenticationHelper
    helpers Pundit

    before { restrict_access_to_developers }
    before { authenticate! }

    format :json

    desc 'End point for the Work Sessions'
    namespace :work_sessions do

      route_param :id do

        desc 'Updates A Work Session'
        params do
          requires :token, type: String, desc: 'The user authentication token'
          optional :description, type: String, desc: 'The user authentication token'
          optional :start_time, type: String, desc: 'The start time. Format: HH:MM. Example: 08:12'
          optional :end_time, type: String, desc: 'The start time. Format: HH:MM. Example: 08:12'
        end
        put do
          work_session = WorkSession.find params[:id]
          authorize work_session, :update?
          if work_session.update ActionController::Parameters.new(params).permit(:description, :start_time, :end_time)
            status 200
            { 'message' => 'The entity is updated' }.as_json
          else
            error_code = ErrorCodes::BAD_PARAMS
            error_msg = work_session.errors.messages
            error!({ 'error_msg' => error_msg, 'error_code' => error_code }, 400)
          end
        end

        desc 'Delete A Work Session'
        params do
          requires :token, type: String, desc: 'The user authentication token'
        end
        delete do
          work_session = WorkSession.find params[:id]
          authorize work_session, :destroy?
          work_session.destroy
          status 200
          { 'message' => 'The entity is deleted' }.as_json
        end
      end

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
