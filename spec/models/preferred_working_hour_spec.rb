require 'rails_helper'

describe PreferredWorkingHour do
  context 'assotiations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'field' do
    it { is_expected.to respond_to(:hour) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:hour) }

    specify 'valid values' do 
     is_expected.to validate_inclusion_of(:hour).in_array((0..23).to_a)
   end
  end
end
