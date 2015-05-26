require 'rails_helper'

describe 'UserPreferenceManager' do
  let(:subject) { UserPreferenceManager.new user, preferred_working_hours }

  context '#load_user_data' do
    let!(:user) { create :user }
    let!(:preferred_working_hour_1) { create :preferred_working_hour, user: user, hour: 3 }
    let!(:preferred_working_hour_2) { create :preferred_working_hour, user: user, hour: 5 }
    let(:preferred_working_hours) { PreferredWorkingHours.new }
    let(:user_preference_manager) { UserPreferenceManager.new user, preferred_working_hours }

    it { is_expected.to respond_to(:load_user_data) }

    specify 'the object query methods should reflect the preferred working hours' do
      user_preference_manager.load_user_data
      expect(preferred_working_hours).to be_preferred_hour_5
      expect(preferred_working_hours).to be_preferred_hour_3
    end
  end

  context '#persist_user_data' do
    let!(:user) { create :user }
    let!(:preferred_working_hour_1) { create :preferred_working_hour, user: user, hour: 3 }
    let!(:preferred_working_hour_2) { create :preferred_working_hour, user: user, hour: 5 }
    let(:preferred_working_hours) { PreferredWorkingHours.new }
    let(:user_preference_manager) { UserPreferenceManager.new user, preferred_working_hours }

    it { is_expected.to respond_to(:persist_user_data) }

    specify 'the users preferred working hours are adjusted' do
      user_preference_manager.load_user_data
      preferred_working_hours.preferred_hour_3 = false
      preferred_working_hours.preferred_hour_4 = true
      user_preference_manager.persist_user_data
      expect(user.preferred_working_hours.pluck(:hour).sort).to eq([4,5])
    end
  end
end
