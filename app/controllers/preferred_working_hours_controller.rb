class PreferredWorkingHoursController < ApplicationController

  before_action :authenticate_user!

  def edit
    service = UserPreferenceManager.new current_user, PreferredWorkingHours.new
    service.load_user_data
    @preferred_working_hours = service.preferred_working_hours
  end

  def update
    @preferred_working_hours = PreferredWorkingHours.new params[:preferred_working_hours]
    service = UserPreferenceManager.new current_user, @preferred_working_hours
    if service.persist_user_data
      flash.now[:info] = 'The preferences were saved'
    else
      flash.now[:error] = 'Error occured saving the preferences.'
    end

    render :edit
  end
end
