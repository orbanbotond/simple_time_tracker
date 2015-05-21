module TimeSheet
  class WorkSessionApi < Grape::API
    helpers ApiHelpers::AuthenticationHelper
    before { restrict_access_to_developers }
    before { authenticate! }

    format :json
    prefix 'api'

    desc 'End point for the Work Sessions'
    namespace :work_sessions do

      desc 'Listing a Time Sheet'
      params do
        optional :from, type: Date, desc: "The start date part of the filter. In format: 'dd/mm/yyy'"
        optional :to, type: Date, desc: "The end date part of the filter. In format: 'dd/mm/yyy'"
      end
      get do
        filter = FilterWorkSessions.new params.slice(:from, :to)
        relation = WorkSessionQueries.new(current_user, filter).execute
        present relation, with: Entities::WorkSessionEntity
      end

      desc 'Post a Work Entry'
      params do
      end
      post do
      end
    end
  end
end
