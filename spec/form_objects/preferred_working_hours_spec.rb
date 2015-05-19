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

  context '#load_user_data' do
    let!(:user) { create :user }
    let!(:preferred_working_hour_1) { create :preferred_working_hour, user: user, hour: 3 }
    let!(:preferred_working_hour_2) { create :preferred_working_hour, user: user, hour: 5 }
    let(:preferred_working_hours) do
      preferred_working_hours = PreferredWorkingHours.new
      preferred_working_hours.load_user_data(user)
      preferred_working_hours
    end

    it { is_expected.to respond_to(:load_user_data) }

    specify 'the object query methods should reflect the preferred working hours' do
      expect(preferred_working_hours).to be_preferred_hour_5
      expect(preferred_working_hours).to be_preferred_hour_3
    end
  end

  context "#persist_user_data" do
    let!(:user) { create :user }
    let!(:preferred_working_hour_1) { create :preferred_working_hour, user: user, hour: 3 }
    let!(:preferred_working_hour_2) { create :preferred_working_hour, user: user, hour: 5 }
    let(:preferred_working_hours) do
      preferred_working_hours = PreferredWorkingHours.new
      preferred_working_hours.load_user_data(user)
      preferred_working_hours.preferred_hour_3 = false
      preferred_working_hours.preferred_hour_4 = true
      preferred_working_hours
    end

    it { is_expected.to respond_to(:persist_user_data) }

    specify 'the users preferred working hours are adjusted' do
      preferred_working_hours.persist_user_data user
      expect(user.preferred_working_hours.pluck(:hour).sort).to eq([4,5])
    end
  end
end
