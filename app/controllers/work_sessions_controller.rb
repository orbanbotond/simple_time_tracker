class WorkSessionsController < ApplicationController
  include DisplayCase::ExhibitsHelper

  before_action :authenticate_user!

  def new
    @time_input = TimeInput.new
  end

  def create
    @time_input = TimeInput.new work_session_params
    work_session_manager = WorkSessionManager.new current_user, @time_input
    if @time_input.valid? && work_session_manager.save
      redirect_to work_sessions_path, notice: 'Time is saved!'
    else
      render :new
    end
  end

  def download
    @wdays = current_user.work_days.joins(:work_sessions).includes(:work_sessions).order(:date)
    html = render_to_string action: :download, layout: 'download'
    send_data html, :filename    => "time_sheet.html",
                    :type => 'text/html',
                    :disposition => 'attachment'
  end

  def index
    @filter = FilterWorkSessions.new filter_params
    relation = WorkSession.joins(:work_day).includes(:work_day).where{work_day.user_id == my{current_user.id}}.order{work_day.date}
    if @filter.filtering?
      relation = relation.where{ (work_day.date >= my{ @filter.from }) & (work_day.date <= my{ @filter.to }) }
    end
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
