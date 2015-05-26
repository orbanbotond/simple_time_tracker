require 'rails_helper'

describe 'WorkSessionManager' do
  let(:subject) { WorkSessionManager.new user, time_input }
  let!(:another_user) { create :user }
  let(:user) { create :user }
  let(:work_day) { create :work_day, date: '02/05.2015', user: user }
  let!(:work_day_for_another_user) { create :work_day, date: '02/05.2015', user: another_user }

  context 'first call for a specific date' do
    let(:time_input) { TimeInput.new description: 'lorem', date: '03/05.2015', start_time: '12:02', end_time: '13:05' }
    specify 'creates the work day' do
      expect do
        subject.save
      end.to change { user.work_days.count }.by(1)
    end
    specify 'creates the work_session' do
      expect do
        subject.save
      end.to change { WorkSession.count }.by(1)
      expect(user.work_days.last.work_sessions.count).to eq(1)
    end
  end

  context 'calling for the same date will not create another work day' do
    let(:time_input) { TimeInput.new description: 'lorem', date: work_day.date, start_time: '12:02', end_time: '13:05' }
    specify 'does not create the work day' do
      work_day
      expect do
        subject.save
      end.to_not change { user.work_days.count }
    end

    specify 'creates the work_session' do
      expect do
        subject.save
      end.to change { WorkSession.count }.by(1)
      expect(user.work_days.last.work_sessions.count).to eq(1)
      expect(WorkSession.last.work_day).to eq(work_day)
    end
  end
end
