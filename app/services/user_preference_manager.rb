class UserPreferenceManager

  attr_reader :user, :preferred_working_hours

  def initialize(user, preferred_working_hours)
    @user = user
    @preferred_working_hours = preferred_working_hours
  end

  def load_user_data
    return unless user.present?
    user.preferred_working_hours.each do |hour|
      preferred_working_hours.send :"preferred_hour_#{hour.hour}=", true
    end
  end

  def persist_user_data
    return false unless user.present?

    user.preferred_working_hours.destroy_all

    (0..23).to_a.each do |hour|
      if preferred_working_hours.send :"preferred_hour_#{hour}?"
        user.preferred_working_hours.create hour: hour
      end
    end

    true
  end
end
