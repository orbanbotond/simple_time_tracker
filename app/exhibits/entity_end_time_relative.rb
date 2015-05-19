class EntityEndTimeRelative < DisplayCase::Exhibit
  include DateAtRelativeToNow

  applicable_to :end_time
end
