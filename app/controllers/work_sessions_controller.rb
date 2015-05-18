class WorkSessionsController < ApplicationController
  inherit_resources
  actions :index, :new, :create

  before_action :authenticate_user!

  private

  def work_session_params
    params.require(:work_session).permit(:description, :date, :start_time, :end_time)
  end
end
