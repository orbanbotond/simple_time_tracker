class DurationHumanized < DisplayCase::Exhibit
  include TimeAgoInWords

  applicable_to :duration
end
