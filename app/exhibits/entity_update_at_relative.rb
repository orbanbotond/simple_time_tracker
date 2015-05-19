class EntityUpdatedAtRelative < DisplayCase::Exhibit
  include DateAtRelativeToNow

  applicable_to :updated_at
end
