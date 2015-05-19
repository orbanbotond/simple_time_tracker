class WorkSessionsController < ApplicationController
  inherit_resources
  include DisplayCase::ExhibitsHelper

  actions :index, :new, :create

  before_action :authenticate_user!

  def create
    @work_session = WorkSession.new work_session_params
    @work_session.user = current_user
    create!
  end

  protected

  def collection
    get_collection_ivar || set_collection_ivar(exhibit(super))
  end

  private

  def work_session_params
    params.require(:work_session).permit(:description, :date, :start_time, :end_time)
  end
end
