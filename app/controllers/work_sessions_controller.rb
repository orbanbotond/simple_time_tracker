class WorkSessionsController < ApplicationController
  inherit_resources
  actions :index, :new, :create

  before_action :authenticate_user!

  def create
    @work_session = WorkSession.new work_session_params
    @work_session.user = current_user
    create!
  end

  private

  def work_session_params
    params.require(:work_session).permit(:description, :date, :start_time, :end_time)
  end
end
