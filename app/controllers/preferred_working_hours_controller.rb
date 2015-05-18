class PreferredWorkingHoursController < ApplicationController
  def edit
    @preferred_working_hours = PreferredWorkingHours.new
  end

  def update
    current_user.preferred_working_hours.destroy_all
    @preferred_working_hours = PreferredWorkingHours.new params[:preferred_working_hours]

    (0..23).to_a.each do |hour|
      if @preferred_working_hours.send :"preferred_hour_#{hour}?"
        current_user.preferred_working_hours.create hour: hour
      end
    end

    flash.now[:info] = 'The preferences were saved'
    render :edit
  end
end
