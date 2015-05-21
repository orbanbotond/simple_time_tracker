require 'rails_helper'

describe WorkDay do
  context 'fields' do
    it { is_expected.to respond_to(:duration) }
    it { is_expected.to respond_to(:date) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:duration) }
  end

  context 'assotiations' do
    it { is_expected.to have_many(:work_sessions) }
    it { is_expected.to belong_to(:user) }
  end

  context 'duration is calculation' do
    let!(:work_day) { create :work_day }
    let!(:work_session) { create :work_session, work_day: work_day}

    specify 'saving the work session adjusts the work_days duration' do
      work_session2 = build :work_session, work_day: work_day
      work_session2.save
      work_session3 = build :work_session, work_day: work_day
      expect do
        work_session3.save
      end.to change { work_day.duration }.by(work_session2.duration)
    end
  end
end
