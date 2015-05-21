require 'rails_helper'

describe Entities::WorkSessionEntity do
  describe 'fields' do
    subject(:subject) { Entities::WorkSessionEntity }
    specify { expect(subject).to represent(:start_time)}
    specify { expect(subject).to represent(:end_time)}
    specify { expect(subject).to represent(:duration)}
  end
end
