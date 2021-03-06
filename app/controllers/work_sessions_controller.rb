class WorkSessionsController < ApplicationController
  include DisplayCase::ExhibitsHelper
  include Pundit

  before_action :authenticate_user!

  def edit
    @work_session = WorkSession.find params[:id]
    authorize @work_session
  end

  def update
    @work_session = WorkSession.find params[:id]
    authorize @work_session
    if @work_session.update work_session_params
      redirect_to work_sessions_path, notice: 'The Work Session has been updated'
    else
      render action: :edit
    end
  end

  def new
    @time_input = TimeInput.new
  end

  def destroy
    work_session = WorkSession.find params[:id]
    authorize work_session
    work_session.destroy
    redirect_to work_sessions_path, notice: 'Work Session is Destroyed'
  end

  def create
    @time_input = TimeInput.new time_input_params
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

  def time_input_params
    params.require(:time_input).permit(:description, :date, :start_time, :end_time)
  end

  def work_session_params
    params.require(:work_session).permit(:description, :start_time, :end_time, :id)
  end

  def filter_params
    if params[:filter].present?
      params.require(:filter).permit(:to, :from)
    else
      {}
    end
  end
end
