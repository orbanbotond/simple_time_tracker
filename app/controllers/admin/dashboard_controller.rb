module Admin
  class DashboardController < Admin::BaseController
    def index
      @total_users = User.count
      @total_hours = WorkDay.sum :duration
      @total_tasks = WorkSession.count
    end
  end
end