class WorkSessionsController < ApplicationController
  inherit_resources
  include DisplayCase::ExhibitsHelper

  actions :index, :new, :create

  before_action :authenticate_user!

  def download
    @time_sheet = current_user.work_sessions
    html = render_to_string action: :download, layout: 'download'
    send_data html, :filename    => "time_sheet.html",
                    :type => 'text/html',
                    :disposition => 'attachment'
  end

  def index
    @filter = FilterWorkSessions.new filter_params
    index!
  end

  def create
    @work_session = WorkSession.new work_session_params
    @work_session.user = current_user
    create!
  end

  protected

  def collection
    c = super
    if @filter.filtering?
      c = c.where{ (date >= my{ @filter.from }) & (date <= my{ @filter.to }) }
    end
    set_collection_ivar(exhibit(c))
  end

  private

  def work_session_params
    params.require(:work_session).permit(:description, :date, :start_time, :end_time)
  end

  def filter_params
    if params[:filter].present?
      params.require(:filter).permit(:to, :from)
    else
      {}
    end
  end
end
