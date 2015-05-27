class WorkSessionsController < ApplicationController
  include DisplayCase::ExhibitsHelper

  before_action :authenticate_user!

  def new
    @time_input = TimeInput.new
  end

  def create
    @time_input = TimeInput.new work_session_params
    work_session_manager = WorkSessionManager.new current_user, @time_input
    if work_session_manager.save
      redirect_to work_sessions_path, notice: 'Time is saved!'
    else
      render :new
    end
  end

  def download
    relation = current_user.work_days.joins(:work_sessions).includes(:work_sessions).order(:date)
    @filter = FilterWorkSessions.new filter_params
    if @filter.filtering?
      relation = relation.where{ (work_days.date >= my{ @filter.from }) & (work_days.date <= my{ @filter.to }) }
    end
    @wdays = exhibit(relation)
    html = render_to_string action: :download, layout: 'download'
    send_data html, :filename    => "time_sheet.html",
                    :type => 'text/html',
                    :disposition => 'attachment'
  end

  def index
    @filter = FilterWorkSessions.new filter_params
    relation = WorkSessionQueries.new(current_user, @filter).execute
    @work_sessions = exhibit(relation)
  end

  private

  def work_session_params
    params.require(:time_input).permit(:description, :date, :start_time, :end_time)
  end

  def filter_params
    if params[:filter].present?
      params.require(:filter).permit(:to, :from)
    else
      {}
    end
  end
end
