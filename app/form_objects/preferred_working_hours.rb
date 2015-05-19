class PreferredWorkingHours
  include ActiveAttr::Model

  (0..23).to_a.each do |hour|
    attribute :"preferred_hour_#{hour}", default: false, type: Boolean
  end

  def load_user_data(user = nil)
    return unless user.present?
    user.preferred_working_hours.each do |hour|
      send :"preferred_hour_#{hour.hour}=", true
    end
  end

  def persist_user_data(user)
    return false unless user.present?

    user.preferred_working_hours.destroy_all

    (0..23).to_a.each do |hour|
      if send :"preferred_hour_#{hour}?"
        user.preferred_working_hours.create hour: hour
      end
    end

    true
  end
end
