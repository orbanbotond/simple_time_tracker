require 'rails_helper'

describe PreferredWorkingHours do

  context 'fields' do
    (0..23).to_a.each do |hour|
      it { is_expected.to respond_to(:"preferred_hour_#{hour}?") }
    end
  end
   
  context 'fields' do
    (0..23).to_a.each do |hour|
      it { is_expected.to respond_to(:"preferred_hour_#{hour}=") }
    end
  end

end
