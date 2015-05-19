class EntityStartTimeRelative < DisplayCase::Exhibit
  include DateAtRelativeToNow

  applicable_to :start_time
end
