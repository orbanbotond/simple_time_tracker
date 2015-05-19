class EntityCreatedAtRelative < DisplayCase::Exhibit
  include DateAtRelativeToNow

  applicable_to :created_at
end
