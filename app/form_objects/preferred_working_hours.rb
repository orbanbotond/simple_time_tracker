class PreferredWorkingHours
  include ActiveAttr::Model

  (0..23).to_a.each do |hour|
    attribute :"preferred_hour_#{hour}", default: false, type: Boolean
  end

end
