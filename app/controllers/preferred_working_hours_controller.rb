class PreferredWorkingHoursController < ApplicationController

  before_action :authenticate_user!

  def edit
    @preferred_working_hours = PreferredWorkingHours.new
    @preferred_working_hours.load_user_data current_user
  end

  def update
    @preferred_working_hours = PreferredWorkingHours.new params[:preferred_working_hours]
    if @preferred_working_hours.persist_user_data(current_user)
      flash.now[:info] = 'The preferences were saved'
    else
      flash.now[:error] = 'Error occured saving the preferences.'
    end

    render :edit
  end
end
